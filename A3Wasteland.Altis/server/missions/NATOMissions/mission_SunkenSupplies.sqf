// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SunkenSupplies.sqf
//	@file Author: JoSchaap, AgentRev, BIB_Monkey

if (!isServer) exitwith {};
#include "NATOMissionDefines.sqf"

private ["_box1", "_box2", "_boxPos"];

_setupVars =
{
	_missionType = "Sunken Supplies";
	_locationsArray = SunkenMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	private _BoxPos1 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box1 = [_BoxPos1, "NATO", "1", 0, 0] call createrandomlootcrate;
	private _BoxPos2 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box2 = [_BoxPos2, "NATO", "1", 0, 10000] call createrandomlootcrate;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];


	{
		_boxPos = getPosASL _x;
		_boxPos set [2, getTerrainHeightASL _boxPos + 1];
		_x setPos _boxPos;
		_x setDir random 360;
		_x setVariable ["R3F_LOG_disabled", true, true];
	} forEach [_box1, _box2];

	_aiGroup1 = createGroup CIVILIAN;
	for "_i" from 1 to 10 do
	{
		[_aiGroup1, _missionPos, "NATO", "Diver"] call createsoldier;
	};
	_aiGroup1 setCombatMode "RED";
	_missionHintText = "Sunken supplies have been spotted in the ocean near the marker, and are heavily guarded. Diving gear and an underwater weapon are recommended.";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	{ _x setVariable ["Moveable", true, true] } forEach [_box1, _box2];
	_successHintMessage = "The sunken supplies have been collected, well done.";
};

_this call NATOMissionProcessor;
