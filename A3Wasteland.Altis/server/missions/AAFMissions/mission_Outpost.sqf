// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_VehicleCapture.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private ["_nbUnits", "_outpost", "_objects"];

_setupVars =
{
	_missionType = "AAF Outpost";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_outpost = (call compile preprocessFileLineNumbers "server\missions\outposts\outpostsList.sqf") call BIS_fnc_selectRandom;
	_objects = [_outpost, _missionPos, 0] call createOutpost;

	_aiGroup = createGroup CIVILIAN;
	for "_i" from 1 to 20 do
	{
		private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
		switch (_soldierType) do
		{
			case "Rifleman": {[_aiGroup, _missionPos] call createAAFRegularRifleman};
			case "AT": {[_aiGroup, _missionPos] call createAAFRegularAT};
			case "AA": {[_aiGroup, _missionPos] call createAAFRegularAA};
			case "SAW": {[_aiGroup, _missionPos] call createAAFRegularSAW};
			case "Engineer": {[_aiGroup, _missionPos] call createAAFRegularEngineer};
			case "Medic": {[_aiGroup, _missionPos] call createAAFRegularMedic};
			case "Grenedier": {[_aiGroup, _missionPos] call createAAFRegularGrenedier};
			case "Marksman": {[_aiGroup, _missionPos] call createAAFRegularMarksman};
		};
	};
	_aiGroup setCombatMode "RED";
	_missionHintText = format ["An armed <t color='%1'>outpost</t> containing weapon crates has been spotted near the marker, go capture it!", AAFMissionColor]
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
};

_successExec =
{
	// Mission complete
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects;
	[_locationsArray, _missionLocation, _objects] call setLocationObjects;

	_successHintMessage = "The outpost has been captured, good work.";
};

_this call AAFMissionProcessor;
