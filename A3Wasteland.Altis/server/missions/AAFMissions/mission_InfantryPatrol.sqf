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
	_locationsArray = PatrolMissionsMarkers; //Mission spawns at random town
};

_setupObjects =
{
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos =markerPos _missionLocation;
	_aiGroup = createGroup CIVILIAN;
	for "_i" from 1 to 4 do
	{
		[_aiGroup, _missionPos] call createAAFRegularRifleman;
	};
	for "_i" from 1 to 2 do
	{
		[_aiGroup, _missionPos] call createAAFRegularSAW
	};
	for "_i" from 1 to 2 do
	{
		[_aiGroup, _missionPos] call createAAFRegularSAW
	};
	_Leader =[_aiGroup, _missionPos] call createAAFRegularMarksman
	_Leader setrank "LIEUTENANT";

	_aiGroup setCombatMode "YELLOW"; // Will fire on enemies
	_aiGroup setBehaviour "AWARE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "WEDGE";

	_speedMode = "LIMITED";
	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "AWARE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "WEDGE";
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
