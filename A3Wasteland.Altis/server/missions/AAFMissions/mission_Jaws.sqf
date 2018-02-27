// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ArmedDiversquad.sqf
//	@file Author: JoSchaap, AgentRev, BIB_Monkey

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private ["_box1", "_box2", "_box3", "_box4", "_boxPos", "_vehicleClass", "_vehicle", "_wreck","_explosive"];

_setupVars =
{
	_missionType = "AAF Ship Wreck";
	_locationsArray = SunkenMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_wreck = createVehicle ["Land_UWreck_FishingBoat_F", _missionPos, [], 5, "None"];
	_wreck setDir random 360;

	private _BoxPos1 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box1 = [_BoxPos1, "AAF", "1", 0, 0] call createrandomlootcrate;
	private _BoxPos2 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box2 = [_BoxPos2, "AAF", "2", 0, 0] call createrandomlootcrate;
	private _BoxPos3 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box3 = [_BoxPos3, "AAF", "2", 0, 0] call createrandomlootcrate;
	private _BoxPos4 = [_missionPos, 3, 10,1,0,0,0] call findSafePos;
	_box4 = [_BoxPos4, "AAF", "3", 0, 0] call createrandomlootcrate;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2, _box3, _box4];

	{
		_boxPos = getPosASL _x;
		_boxPos set [2, getTerrainHeightASL _boxPos + 1];
		_x setPos _boxPos;
		_x setVariable ["R3F_LOG_disabled", true, true];
	} forEach [_box1, _box2, _wreck];

	_createVehicle = 
	{
		private _type = _this select 0;
		private _position = _this select 1;
		private _direction = _this select 2;
		private _vehiclePos = [_position, 10, 50,5,2,0,0] call findSafePos;
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
		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;
		if (_drivers > 0) then
		{
			for "_i" from 1 to _drivers do
			{
				private _Driver = [_aiGroup, _position, "AAF", "Rifleman"] call createsoldier;;
				_Driver moveInAny _vehicle;
			};
		};
		if (_Commanders > 0) then
		{
			for "_i" from 1 to _Commanders do
			{
				private _Commander = [_aiGroup, _position, "AAF", "Rifleman"] call createsoldier;;
				_Commander moveInCommander _vehicle;
			};
		};
		if (_Gunners > 0) then
		{
			private _gunner = [_aiGroup, _position, "AAF", "Rifleman"] call createsoldier;;
			_gunner moveInGunner _vehicle;
		};
		_vehicle addItemCargoGlobal ["U_I_Wetsuit", 2];
		_vehicle addItemCargoGlobal ["V_RebreatherIA", 2];
		_vehicle addItemCargoGlobal ["G_Diving", 2];
		_vehicle addWeaponCargoGlobal ["arifle_SDAR_F", 2];
		_vehicle addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 8];

		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked
		_vehicle
	};
	_vehclass1 ="I_Boat_Armed_01_minigun_F";
	_vehclass2 ="I_Boat_Armed_01_minigun_F";
	_aiGroup = createGroup CIVILIAN;
	_veh1 = [_vehclass1, _missionPos, random 360] call _createVehicle;
	_veh2 = [_vehclass2, _missionPos, random 360] call _createVehicle;
	private _Passangers1 = _veh1 emptyPositions "Cargo";
	private _Passangers2 = _veh2 emptyPositions "Cargo";
	for "_i" from 1 to (_Passangers1 + _Passangers2) do
	{
		[_aiGroup, _missionPos, "AAF", "Diver"] call createsoldier;
	};
	_aiGroup setCombatMode "RED";
	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehclass1 >> "picture");
	_missionHintText = "We are going to need a Bigger Boat.<br/>Enemy divers are trying to recover arms and loot, go kill them and claim the loot.";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3, _box4, _wreck];
};

// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3, _box4];
	{ deleteVehicle _x } forEach [_wreck];

	_successHintMessage = "The sunken loot and money has been captured, well done.";
};

_this call AAFMissionProcessor;
