// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_Coastal_Convoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), BIB_Monkey
//	@file Created: 02/09/2013 11:29
//	@file Args: none

if (!isServer) exitwith {};
#include "NATOMissionDefines.sqf"

private [ "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "NATO Coastal Patrol";
	_locationsArray = CoastalConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_veh1 = "B_Boat_Armed_01_minigun_F";
	_veh2 = "B_Boat_Armed_01_minigun_F";
	_veh3 = "B_Boat_Armed_01_minigun_F";

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_variant", "_special", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		_SpawnPos = [_position, 0, 10,10,2,0,0] call findSafePos;
		if (_type isEqualType []) then
		{
			_type = _type select 0;
		};

		_vehicle = createVehicle [_type, _position, [], 0, "NONE"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [west, true];
		_vehicle confirmSensorTarget [east, true];
		_vehicle confirmSensorTarget [resistance, true];
		[_vehicle] call vehicleSetup;
		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;
		private _drivers = _vehicle emptyPositions "Driver";
		private _Commanders =  _vehicle emptyPositions "Commander";
		private _Gunners = _vehicle emptyPositions "Gunner";
		private _Passangers = _vehicle emptyPositions "Cargo";
		if (_drivers > 0) then
		{
			for "_i" from 1 to _drivers do
			{
				private _Driver = [_aiGroup, _position, "NATO", "Rifleman"] call createsoldier;
				_Driver moveInAny _vehicle; //Boats don't like moveInDriver for some reason
			};
		};
		if (_Commanders > 0) then
		{
			for "_i" from 1 to _Commanders do
			{
				private _Commander = [_aiGroup, _position, "NATO", "Rifleman"] call createsoldier;
				_Commander moveInCommander _vehicle;
			};
		};
		if (_Gunners > 0) then
		{
			private _gunner = [_aiGroup, _position, "NATO", "Rifleman"] call createsoldier;
			_gunner moveInGunner _vehicle;
		};
		if (_Passangers > 0) then
		{
			for "_i" from 1 to _Passangers do
			{
				private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
				_soldier = [_aiGroup, _position, "NATO", _soldierType] call createsoldier;
				_soldier moveInAny _vehicle;
			};
		};
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startdirs select 0] call _createVehicle,
		[_veh2, _starts select 0, _startdirs select 0] call _createVehicle,
		[_veh3, _starts select 0, _startdirs select 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "AWARE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = "NORMAL";

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");

	_missionHintText = format ["Two <t color='%3'>%1</t> are patrolling the coasts.<br/>Intercept them and recover their cargo!", _vehicleName, _vehicleName2, NATOMissionColor];

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
	_lootPos = getMarkerPos _marker;
	for "_i" from 1 to 4 do
	{
		private _tier = selectrandom ["1","2","3"];
		private _maxmoney = random 15000;
		private _box = [_lootPos, "NATO", _tier, 0, _maxmoney] call createrandomlootcrate;
		_box setVariable ["moveable", true, true];
	};
	_successHintMessage = "The patrol has been stopped, the ammo crates are yours to take. Find them near the wreck!";
};

_this call NATOMissionProcessor;
