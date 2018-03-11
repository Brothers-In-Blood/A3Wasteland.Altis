// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD, BIB_Monkey

if (!isServer) exitwith {};
#include "NATOMissionDefines.sqf";

private ["_planeChoices", "_convoyVeh", "_veh1", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_Boxes1", "_currBox1", "_Boxes2", "_currBox2", "_Box1", "_Box2"];

_setupVars =
{
	_missionType = "NATO Supply Drop";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_veh1types = selectrandom ["B_T_VTOL_01_vehicle_F","B_T_VTOL_01_infantry_F"];
	_veh1 = [_veh1types, _missionPos,1,1,0,"FLY"] call createMissionVehicle;
	_aiGroup1 = createGroup CIVILIAN;
	
	_vehicles = [_veh1];
	{
		_vehicle = _x;
		_position = getPos _vehicle;
		private _drivers = _vehicle emptyPositions "Driver";
		private _Passangers = _vehicle emptyPositions "Cargo";
		if (_drivers > 0) then
		{
			for "_i" from 1 to _drivers do
			{
				private _Driver = [_aiGroup1, _position, "NATO", "HeliPilot"] call createsoldier;
				_Driver moveInDriver _vehicle;
			};
		};
		private _Copilot = [_aiGroup1, _position, "NATO", "HeliPilot"] call createsoldier;
		_Copilot moveInAny _vehicle;
		for "_i" from 1 to 2 do
		{
			private _gunner = [_aiGroup1, _position, "NATO", "HeliCrew"] call createsoldier;
			_gunner moveInAny _vehicle;
		};
		if (_Passangers > 0) then
		{
			for "_i" from 1 to _Passangers do
			{
				private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
				_soldier = [_aiGroup1, _missionPos, "NATO", _soldierType] call createsoldier;
				_soldier moveInCargo _vehicle;
			};
		};
	} foreach _vehicles;

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup1 selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup1 setCombatMode "BLUE";
	_aiGroup1 setBehaviour "CARELESS";
	_aiGroup1 setFormation "STAG COLUMN";

	_speedMode ="FULL";

	// behaviour on waypoints
	{
		_waypoint = _aiGroup1 addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "BLUE";
		_waypoint setWaypointBehaviour "CARELESS";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup1;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1types >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1types >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, NATOMissionColor];

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
	_lootPos = getMarkerPos _marker;
	for "_i" from 1 to 7 do
	{
		private _tier = selectrandom ["2","3","4","5"];
		private _maxmoney = random 10000;
		private _box = [_lootPos, "NATO", _tier, 0, _maxmoney] call createrandomlootcrate;
		_box setVariable ["moveable", true, true];
	};
	_smoke2= "SmokeShellGreen" createVehicle _lootPos;
	_flare2= "F_40mm_Green" createVehicle _lootPos;

_this call NATOMissionProcessor;
