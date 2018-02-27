// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, BIB_Monkey
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "IDAPMissionDefines.sqf"

private _wreckPos = "";
private _wreck = "";
private _box1 = "" ;
private _box2 = "" ;
private _MissionDifficulty = selectrandom ["Regular"]; // "Veteran", "SpecialForces"

_setupVars =
{
	_missionType = "IDAP Aircraft Wreck";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_wreckPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);

	// Class, Position, Fuel, Ammo, Damage, Special
	_wreckTypes = selectrandom ["C_IDAP_Heli_Transport_02_F"];
	_wreckName = getText (configFile >> "CfgVehicles" >> _wreckTypes >> "displayName");
	_wreck = [_wreckTypes, _wreckPos, 0, 0, 1] call createMissionVehicle;

	
	private _BoxPos1 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box1 = [_BoxPos1, "IDAP", "1", 0, 0] call createrandomlootcrate;
	private _BoxPos2 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box2 = [_BoxPos2, "IDAP", "1", 0, 10000] call createrandomlootcrate;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	_aiGroup = createGroup CIVILIAN;
	for "_i" from 1 to 12 do
	{
		[_aiGroup, _missionPos, "IDAP", "Rifleman"] call createsoldier;
	};
	_aiGroup setCombatMode 	"RED";

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

	_successHintMessage = "The airwreck supplies have been collected, well done.";
};

_this call IDAPMissionProcessor;
