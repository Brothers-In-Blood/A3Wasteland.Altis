// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ArmedDiversquad.sqf
//	@file Author: JoSchaap, AgentRev, BIB_Monkey

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private ["_box1", "_box2", "_boxPos", "_vehicleClass", "_vehicle", "_wreck","_explosive"];

_setupVars =
{
	_missionType = "Ship Wreck";
	_locationsArray = SunkenMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_wreck = createVehicle ["Land_UWreck_FishingBoat_F", _missionPos, [], 5, "None"];
	_wreck setDir random 360;

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
	_box1 = createVehicle [_box1type, _missionPos, [], 0, "None"];
	_box1 setVariable ["R3F_LOG_disabled", true, true];
	_box1 setVariable ["moveable", false, true];
	_box1 setDir random 360;
	[_box1, _box1Loot] call fn_refillbox;

	_box2type = selectrandom _BoxTypes;
	_box2Loot = selectrandom _loottypes;
	_box2 = createVehicle [_box2type, _missionPos, [], 0, "None"];
	_box2 setVariable ["R3F_LOG_disabled", true, true];
	_box2 setVariable ["moveable", false, true];
	_box2 setDir random 360;
	[_box2, _box2Loot] call fn_refillbox;

	_box3type = selectrandom _BoxTypes;
	_box3Loot = selectrandom _loottypes;
	_box3 = createVehicle [_box3type, _missionPos, [], 0, "None"];
	_box3 setVariable ["R3F_LOG_disabled", true, true];
	_box3 setVariable ["moveable", false, true];
	_box3 setDir random 360;
	[_box3, _box3Loot] call fn_refillbox;

	_box4type = selectrandom _BoxTypes;
	_box4Loot = selectrandom _loottypes;
	_box4 = createVehicle [_box4type, _missionPos, [], 0, "None"];
	_box4 setVariable ["R3F_LOG_disabled", true, true];
	_box4 setVariable ["moveable", false, true];
	_box4 setDir random 360;
	[_box4, _box4Loot] call fn_refillbox;

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
		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked
		_vehicle
	};
	_vehclass1 ="I_Boat_Armed_01_minigun_F";
	_vehclass2 ="I_Boat_Armed_01_minigun_F";
	_aiGroup = createGroup CIVILIAN;
	veh1 = [_vehclass1, _missionPos, random 360] call _createVehicle;
	veh2 = [_vehclass2, _missionPos, random 360] call _createVehicle;
	{
		_x addItemCargoGlobal ["U_I_Wetsuit", 2];
		_x addItemCargoGlobal ["V_RebreatherIA", 2];
		_x addItemCargoGlobal ["G_Diving", 2];
		_x addWeaponCargoGlobal ["arifle_SDAR_F", 2];
		_x addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 8];
	} foreach [_veh1, _veh2];
	private _Passangers1 = _veh1 emptyPositions "Cargo";
	private _Passangers2 = _veh2 emptyPositions "Cargo";
	for "_i" from 1 to (_Passangers1 + _Passangers2) do
	{
		[_aiGroup, _missionPos] call createAAFRegularDiver;
	};
	_aiGroup setCombatMode "RED";
	[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
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
