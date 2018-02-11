// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_altisPatrol.sqf
//	@file Author: JoSchaap, AgentRev, LouD, BIB_Monkey

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private ["_convoyVeh","_veh1","_veh2","_veh3","_veh4","_veh5","_createVehicle","_pos","_rad","_vehiclePosArray","_vPos1","_vPos2","_vPos3","_vehiclePos1","_vehiclePos2","_vehiclePos3","_vehiclePos4","_vehicles","_leader","_speedMode","_waypoint","_vehicleName","_numWaypoints","_box1","_box2","_box3","_box4"];

_setupVars =
{
	_missionType = "AAF Medium Patrol";
	_locationsArray = nil; //Mission spawns at random town
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);

	_veh1 = selectrandom ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];
	_veh2 = "I_APC_Wheeled_03_cannon_F";
	_veh3 = "I_APC_tracked_03_cannon_F";
	_veh4 = "I_APC_Wheeled_03_cannon_F";
	_veh5 = selectrandom ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];

	_createVehicle = 
	{
		private _type = _this select 0;
		private _position = _this select 1;
		private _direction = _this select 2;
		private _vehiclePos = [_position, 10, 50,5,0,0,0] call findSafePos;
		private _vehicle = createVehicle [_type, _vehiclePos, [], 0, "None"];
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [west, true];
		_vehicle confirmSensorTarget [east, true];
		_vehicle confirmSensorTarget [resistance, true];
		[_vehicle] call vehicleSetup;
		private _drivers = _vehicle emptyPositions "Driver";
		private _Commanders =  _vehicle emptyPositions "Commander";
		private _Gunners = _vehicle emptyPositions "Gunner";
		private _Passangers = _vehicle emptyPositions "Cargo";
		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;
		if (_drivers > 0) then
		{
			for "_i" from 1 to _drivers do
			{
				private _Driver = [_aiGroup, _position] call createAAFRegularRifleman;
				_Driver moveInDriver _vehicle;
			};
		};
		if (_Commanders > 0) then
		{
			for "_i" from 1 to _Commanders do
			{
				private _Commander = [_aiGroup, _position] call createAAFRegularRifleman;
				_Commander moveInCommander _vehicle;
			};
		};
		if (_Gunners > 0) then
		{
			private _gunner = [_aiGroup, _position] call createAAFRegularRifleman;
			_gunner moveInGunner _vehicle;
		};
		if (_Passangers > 0) then
		{
			for "_i" from 1 to _Passangers do
			{
				private _soldier = [_aiGroup, _position] call createAAFRegularRifleman;
				_soldier moveInCargo _vehicle;
			};
		};
		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_rad = _town select 1;
	_vehiclePosArray = [_missionPos,_rad,_rad + 50,5,0,0,0] call findSafePos;

	_vehicles =
	[
		[_veh1, _vehiclePosArray, 0] call _createVehicle,
		[_veh2, _vehiclePosArray, 0] call _createVehicle,
		[_veh3, _vehiclePosArray, 0] call _createVehicle,
		[_veh4, _vehiclePosArray, 0] call _createVehicle,
		[_veh5, _vehiclePosArray, 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "YELLOW"; // Will fire on enemies
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "FILE";

	_speedMode = "NORMAL";
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh3 >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _veh4 >> "displayName");

	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling Altis! Stop the patrol and capture the goods and money!", _vehicleName, _vehicleName2, _vehicleName3, AAFMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_drop_item =
{
	private _item = _this select 0;
	private _pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private _id = _item select 0;
	private _class = _item select 1;

	private _obj = createVehicle [_class, _pos, [], 5, "None"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
};

_successExec =
{
	// Mission completed

	_BoxTypes = 
	[
		"Box_FIA_Ammo_F",
		"Box_IND_Ammo_F",
		"Box_IND_Wps_F",
		"Box_AAF_Equip_F",
		"Box_IND_AmmoOrd_F",
		"Box_IND_Grenades_F",
		"Box_IND_WpsLaunch_F",
		"Box_IND_WpsSpecial_F",
		"Box_IND_Support_F",
		"Box_AAF_Uniforms_F",
		"Box_FIA_Wps_F"
	];
	private _loottypes = 
	[
		"mission_USLaunchers",
		"mission_USSpecial",
		"Launchers_Tier_2",
		"Diving_Gear",
		"General_supplies",
		"GEVP",
		"Ammo_Drop",
		"mission_AALauncher",
		"mission_CompactLauncher",
		"mission_snipers",
		"mission_RPG",
		"mission_Pistols",
		"mission_AssRifles",
		"mission_SMGs",
		"mission_LMGs",
		"Medical",
		"mission_Field_Engineer"
	];

	_box1type = selectrandom _BoxTypes;
	_box1Loot = selectrandom _loottypes;
	_box1 = _box1type createVehicle getMarkerPos _marker;
    [_box1,_box1Loot] call fn_refillbox;
	_box1 setVariable ["moveable", true, true];
	_box1 allowDamage false;
	_money = ceil random 50000;
	_box1 setVariable ["cmoney", _money, true];

	_box2type = selectrandom _BoxTypes;
	_box2Loot = selectrandom _loottypes;
	_box2 = _box2type createVehicle getMarkerPos _marker;
    [_box2,_box2Loot] call fn_refillbox;
	_box2 setVariable ["moveable", true, true];
	_box2 allowDamage false;

	_box3type = selectrandom _BoxTypes;
	_box3Loot = selectrandom _loottypes;
	_box3 = _box3type createVehicle getMarkerPos _marker;
    [_box3,_box3Loot] call fn_refillbox;
	_box3 setVariable ["moveable", true, true];
	_box3 allowDamage false;

	_box4 = "B_supplyCrate_F" createVehicle getMarkerPos _marker;
    [_box4,"Launchers_Tier_2"] call fn_refillbox;
	_box4 setVariable ["moveable", true, true];
	_box4 allowDamage false;

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3, _box4];

	_successHintMessage = "The patrol has been stopped, the money and crates and vehicles are yours to take.";
};

_this call AAFMissionProcessor;
