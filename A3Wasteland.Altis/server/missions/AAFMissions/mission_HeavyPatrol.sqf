// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_altisPatrol.sqf
//	@file Author: JoSchaap, AgentRev, LouD, BIB_Monkey

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private ["_convoyVeh","_veh1","_veh2","_veh3","_veh4","_veh5","_createVehicle","_pos","_rad","_vPos1","_vPos2","_vPos3","_vehiclePos1","_vehiclePos2","_vehiclePos3","_vehiclePos4","_vehicles","_leader","_speedMode","_waypoint","_vehicleName","_numWaypoints","_box1","_box2","_box3","_box4"];

_setupVars =
{
	_missionType = "AAF Medium Patrol";
	_locationsArray = PatrolMissionsMarkers; //Mission spawns at random town
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos _missionLocation;

	_veh1 = selectrandom ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];
	_veh2 = "I_APC_Wheeled_03_cannon_F";
	_veh3 = "I_APC_tracked_03_cannon_F";
	_veh4 = 
	_veh5 = 
	_veh6 = 
	_veh7 = "I_APC_tracked_03_cannon_F";
	_veh8 = "I_APC_Wheeled_03_cannon_F";
	_veh9 = selectrandom ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];

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
				private _Driver = [_aiGroup, _position] call createAAFRegularCrew;
				_Driver moveInDriver _vehicle;
			};
		};
		if (_Commanders > 0) then
		{
			for "_i" from 1 to _Commanders do
			{
				private _Commander = [_aiGroup, _position] call createAAFRegularCrew;
				_Commander moveInCommander _vehicle;
			};
		};
		if (_Gunners > 0) then
		{
			private _gunner = [_aiGroup, _position] call createAAFRegularCrew;
			_gunner moveInGunner _vehicle;
		};
		if (_Passangers > 0) then
		{
			for "_i" from 1 to _Passangers do
			{
				private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
				private _soldier = "";
				switch (_soldierType) do
				{
					case "Rifleman": {_soldier = [_aiGroup, _missionPos] call createAAFRegularRifleman};
					case "AT": {_soldier =[_aiGroup, _missionPos] call createAAFRegularAT};
					case "AA": {_soldier =[_aiGroup, _missionPos] call createAAFRegularAA};
					case "SAW": {_soldier =[_aiGroup, _missionPos] call createAAFRegularSAW};
					case "Engineer": {_soldier =[_aiGroup, _missionPos] call createAAFRegularEngineer};
					case "Medic": {_soldier =[_aiGroup, _missionPos] call createAAFRegularMedic};
					case "Grenedier": {_soldier =[_aiGroup, _missionPos] call createAAFRegularGrenedier};
					case "Marksman": {_soldier =[_aiGroup, _missionPos] call createAAFRegularMarksman};
				};
				_soldier moveInCargo _vehicle;
			};
		};
		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;
	_vehicles =
	[
		[_veh1, _missionPos, 0] call _createVehicle,
		[_veh2, _missionPos, 0] call _createVehicle,
		[_veh3, _missionPos, 0] call _createVehicle,
		[_veh4, _missionPos, 0] call _createVehicle,
		[_veh5, _missionPos, 0] call _createVehicle,
		[_veh6, _missionPos, 0] call _createVehicle,
		[_veh7, _missionPos, 0] call _createVehicle,
		[_veh8, _missionPos, 0] call _createVehicle,
		[_veh9, _missionPos, 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "GREEN"; // Will fire on enemies
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "FILE";

	_speedMode = "LIMITED";
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
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
	private _BoxTypes = 
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
	//Normal Loot Crate
	for "_i" from 1 to 7 do
	{
		private _boxtype = selectrandom _BoxTypes;
		private _boxLoot = selectrandom _loottypes;
		private _box = _boxtype createVehicle getMarkerPos _marker;
		[_box,_boxLoot] call fn_refillbox;
		_box setVariable ["moveable", true, true];
		_box allowDamage false;
	};
	//Loot Crate with money
	_moneyboxtype = selectrandom _BoxTypes;
	_moneyboxLoot = selectrandom _loottypes;
	_moneybox = _moneyboxtype createVehicle getMarkerPos _marker;
    [_moneybox,_moneyboxLoot] call fn_refillbox;
	_moneybox setVariable ["moveable", true, true];
	_moneybox allowDamage false;
	_money = ceil random [100000, 150000, 200000];
	_moneybox setVariable ["cmoney", _money, true];
	_successHintMessage = "The patrol has been stopped, the money and crates and vehicles are yours to take.";
};

_this call AAFMissionProcessor;
