// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, BIB_Monkey
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "CSATMissionDefines.sqf"

private _wreckPos = "";
private _wreck = "";
private _box1 = "" ;
private _box2 = "" ;
private _MissionDifficulty = selectrandom ["Regular"]; // "Veteran", "SpecialForces"

_setupVars =
{
	_missionType = "CSAT Aircraft Wreck";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_wreckPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);

	// Class, Position, Fuel, Ammo, Damage, Special
_wreckTypes = selectrandom 
	[
		"O_Plane_CAS_02_dynamicLoadout_F",
		"O_Plane_Fighter_02_F",
		"O_Plane_Fighter_02_Stealth_F",
		"O_Heli_Transport_04_F",
		"O_Heli_Transport_04_ammo_F",
		"O_Heli_Transport_04_bench_F",
		"O_Heli_Transport_04_box_F",
		"O_Heli_Transport_04_fuel_F",
		"O_Heli_Transport_04_medevac_F",
		"O_Heli_Transport_04_repair_F",
		"O_Heli_Transport_04_covered_F",
		"O_Heli_Attack_02_dynamicLoadout_F",
		"O_Heli_Light_02_dynamicLoadout_F",
		"O_Heli_Light_02_unarmed_F",
		"O_T_VTOL_02_infantry_dynamicLoadout_F",
		"O_T_VTOL_02_vehicle_dynamicLoadout_F"
	];
	_wreckName = getText (configFile >> "CfgVehicles" >> _wreckTypes >> "displayName");
	_wreck = [_wreckTypes, _wreckPos, 0, 0, 1] call createMissionVehicle;

	
	private _BoxPos1 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box1 = [_BoxPos1, "CSAT", "1", 0, 0] call createrandomlootcrate;
	private _BoxPos2 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box2 = [_BoxPos2, "CSAT", "1", 0, 0] call createrandomlootcrate;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	_aiGroup1 = createGroup CIVILIAN;
	for "_i" from 1 to 6 do
	{
		private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
		[_aiGroup1, _missionPos, "CSAT", _soldierType] call createsoldier;
	};
	_aiGroup1 setCombatMode "RED";
	_aiGroup2 = createGroup CIVILIAN;
	for "_i" from 1 to 6 do
	{
		private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
		[_aiGroup2, _missionPos, "CSAT", _soldierType] call createsoldier;
	};
	_aiGroup2 setCombatMode "RED";

	_missionPicture = getText (configFile >> "CfgVehicles" >> typeOf _wreck >> "picture");
	_missionHintText = format ["A %1 has been shot down. Hurry and recover the cargo!", _wreckName];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _wreck];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	{ _x setVariable ["Moveable", true, true] } forEach [_box1, _box2];
	{ _x setVariable ["cmoney",ceil (random 10000), true] } forEach [_box1, _box2];

	_successHintMessage = "The airwreck supplies have been collected, well done.";
};

_this call CSATMissionProcessor;
