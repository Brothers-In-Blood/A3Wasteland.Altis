// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_WepCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy
//	@file Created: 08/12/2012 15:19
//	@file Args:

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private ["_box1", "_boxPos", "_vehicleClass", "_vehicle"];

_setupVars =
{
	_missionType = "Sunken Treasure";
	_locationsArray = SunkenMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	private _BoxTypes = 
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

	_vehicleClass = "I_Boat_Armed_01_minigun_F";
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
		_vehicle lockDriver true;

		if (_drivers > 0) then
		{
			for "_i" from 1 to _drivers do
			{
				private _Driver = [_aiGroup, _position] call createAAFRegularRifleman;
				_Driver moveInAny _vehicle; //The boat doesn't like moveindriver for some reason 
			};
		};
		if (_Commanders > 0) then
		{
			for "_i" from 1 to _Commanders do
			{
				private _Commander = [_aiGroup, _position] call createAAFRegularRifleman;
				_Commander moveInCommander _vehicle;
			};
		};
		if (_Gunners > 0) then
		{
			private _gunner = [_aiGroup, _position] call createAAFRegularRifleman;
			_gunner moveInGunner _vehicle;
		};	
		_vehicle setVariable ["R3F_LOG_disabled", true, true]; // force vehicles to be locked
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock; // force vehicles to be locked
		_vehicle addItemCargoGlobal ["U_I_Wetsuit", 2];
		_vehicle addItemCargoGlobal ["V_RebreatherIA", 2];
		_vehicle addItemCargoGlobal ["G_Diving", 2];
		_vehicle addWeaponCargoGlobal ["arifle_SDAR_F", 2];
		_vehicle addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 8];

		_vehicle
	};
	// Vehicle Class, Position, Fuel, Ammo, Damage, Special
	_aiGroup = createGroup CIVILIAN;
	_vehicle = [_vehicleClass, _missionPos, random 360] call _createVehicle;
	private _Passangers = _vehicle emptyPositions "Cargo";

	if (_Passangers > 0) then
	{
		for "_i" from 1 to _Passangers do
		{
			[_aiGroup, _missionPos] call createAAFRegularDiver;
		};
	};
	_aiGroup setCombatMode "RED";
	[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_missionHintText = format ["A treasure containing <t color='%1'>$100,000</t> and weapons is being recovered.<br/>If you want to capture it, you will need diving gear and an underwater weapon."];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	deleteVehicle _box1;
};

// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission complete
	_box1 setVariable ["R3F_LOG_disabled", false, true];
	_box1 setVariable ["cmoney", 100000, true];
	_box1 setVariable ["moveable", true, true];
	_vehicle lockDriver false;

	_successHintMessage = "The treasure has been captured, well done.";
};

_this call AAFMissionProcessor;
