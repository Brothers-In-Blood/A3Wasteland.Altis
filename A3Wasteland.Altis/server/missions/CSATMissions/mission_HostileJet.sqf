// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD, BIB_Monkey

if (!isServer) exitwith {};
#include "CSATMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_Boxes1", "_currBox1", "_Boxes2", "_currBox2", "_Box1", "_Box2"];

_setupVars =
{
	_missionType = "CSAT Jet Patrol";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_veh1types = selectrandom ["O_Plane_CAS_02_dynamicLoadout_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F"];
	_veh1 = [_veh1types, _missionPos,1,1,0,"FLY"] call createMissionVehicle;
	_aiGroup1 = createGroup CIVILIAN;
	
	_vehicles = [_veh1];
	{
		_vehicle = _x;
		_position = getPos _vehicle;
		_soldier =[_aiGroup1, _position, "CSAT", "JetPilot"] call createsoldier;
		_soldier moveInDriver _vehicle;
	} foreach _vehicles;

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup1 selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup1 setCombatMode "RED";
	_aiGroup1 setBehaviour "COMBAT";
	_aiGroup1 setFormation "STAG COLUMN";

	_speedMode ="NORMAL";

	// behaviour on waypoints
	{
		_waypoint = _aiGroup1 addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup1;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1types >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1types >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, CSATMissionColor];

	_numWaypoints = count waypoints _aiGroup1;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup1 >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed
	_successHintMessage = "The sky is clear again, the enemy patrol was taken out!";

	_lastPos set [2, 400];
	_box = [_lastPos, "CSAT", "3", 25000, 100000] call createrandomlootcrate;
	_para = createVehicle ["B_Parachute_02_F", _lastPos, [], 0, "None"];
	_Box attachTo [_para,[0,0,-1.5]];
	_Box allowDamage false;

	WaitUntil {((((position _Box) select 2) < 1) || (isNil "_para"))};
	detach _Box;
	_smoke2= "SmokeShellGreen" createVehicle getPos _Box;
	_flare2= "F_40mm_Green" createVehicle getPos _Box;
};

_this call CSATMissionProcessor;
