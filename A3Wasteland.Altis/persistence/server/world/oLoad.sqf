// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: oLoad.sqf
//	@file Author: AgentRev, JoSchaap, Austerror, BIB_Monkey

#include "functions.sqf"
#define STR_TO_SIDE(VAL) ([sideUnknown,BLUFOR,OPFOR,INDEPENDENT,CIVILIAN,sideLogic] select ((["WEST","EAST","GUER","CIV","LOGIC"] find toUpper (VAL)) + 1))

private ["_maxLifetime", "_isWarchestEntry", "_isBeaconEntry", "_worldDir", "_methodDir", "_objCount", "_objects", "_exclObjectIDs"];

_maxLifetime = ["A3W_objectLifetime", 0] call getPublicVar;

_isWarchestEntry = { [_variables, "a3w_warchest", false] call fn_getFromPairs };
_isBeaconEntry = { [_variables, "a3w_spawnBeacon", false] call fn_getFromPairs };

_worldDir = "persistence\server\world";
_methodDir = format ["%1\%2", _worldDir, call A3W_savingMethodDir];

_objCount = 0;
_objects = call compile preprocessFileLineNumbers format ["%1\getObjects.sqf", _methodDir];
_objectsArray = [];

_exclObjectIDs = [];

{
	private ["_allowed", "_obj", "_objectID", "_class", "_pos", "_dir", "_locked", "_damage", "_allowDamage", "_owner", "_variables", "_weapons", "_magazines", "_items", "_backpacks", "_turretMags", "_ammoCargo", "_fuelCargo", "_repairCargo", "_hoursAlive", "_valid"];

	{ (_x select 1) call compile format ["%1 = _this", _x select 0]	} forEach _x;

	if (isNil "_locked") then { _locked = 1 };
	if (isNil "_hoursAlive") then { _hoursAlive = 0 };
	_valid = false;

	if (!isNil "_class" && !isNil "_pos" && {_maxLifetime <= 0 || _hoursAlive < _maxLifetime}) then
	{
		if (isNil "_variables") then { _variables = [] };

		_allowed = switch (true) do
		{
			case (call _isWarchestEntry):       { _warchestSavingOn };
			case (call _isBeaconEntry):         { _beaconSavingOn };
			case (_class call _isBox):          { _boxSavingOn };
			case (_class call _isStaticWeapon): { _staticWeaponSavingOn };
			default                             { _baseSavingOn };
		};

		if (!_allowed) exitWith {};

		_objCount = _objCount + 1;
		_valid = true;

		{ if (typeName _x == "STRING") then { _pos set [_forEachIndex, parseNumber _x] } } forEach _pos;

		_obj = createVehicle [_class, _pos, [], 0, "None"];
		_objectsArray pushBack _obj;
		_obj allowDamage false;
		_obj hideObjectGlobal true;
		_obj enableSimulation false;
		_obj setPosWorld ATLtoASL _pos;

		if (!isNil "_dir") then
		{
			_obj setVectorDirAndUp _dir;
		};

		[_obj, false] call vehicleSetup;
		[_obj] call basePartSetup;

		if (!isNil "_objectID") then
		{
			_obj setVariable ["A3W_objectID", _objectID, true];
			_obj setVariable ["A3W_objectSaved", true, true];
			A3W_objectIDs pushBack _objectID;
		};

		_obj setVariable ["baseSaving_hoursAlive", _hoursAlive];
		_obj setVariable ["baseSaving_spawningTime", diag_tickTime];
		_obj setVariable ["objectLocked", true, true]; // force lock

		if (_allowDamage > 0) then
		{
			_obj allowDamage true;
			_obj setDamage _damage;
			_obj setVariable ["allowDamage", true, true];
		}
		else
		{
			_obj setVariable ["allowDamage", false, true];
		};

		if (!isNil "_owner") then
		{
			_obj setVariable ["ownerUID", _owner, true];
		};

		private _uavSide = if (isNil "_playerSide") then { sideUnknown } else { _playerSide };
		private _uavAuto = true;

		{
			_var = _x select 0;
			_value = _x select 1;

			switch (_var) do
			{
				case "side": { _value = _value call _strToSide };
				case "cmoney": { if (_value isEqualType "") then { _value = parseNumber _value } };
				case "R3F_Side": { _value = _value call _strToSide };
				case "lockDown": { _value }; // BASE LOCKER
				case "Lights": { _value }; // BASE LOCKER
				case "password": { _value }; // BASE LOCKER - SAFE - DOOR
				case "ManagerLevel" : {_value};
				case "moveable": {_value};
				case "bis_disabled_Door_1": {_value};
				case "bis_disabled_Door_2": {_value};
				case "bis_disabled_Door_3": {_value};
				case "bis_disabled_Door_4": {_value};
				case "bis_disabled_Door_5": {_value};
				case "bis_disabled_Door_6": {_value};
				case "bis_disabled_Door_7": {_value};
				case "bis_disabled_Door_8": {_value};
				case "GOM_fnc_fuelCargo" : {_value};
				case "GOM_fnc_ammoCargo" : {_value};
				case "GOM_fnc_repairCargo" : {_value};
				case "ownerName":
				{
					switch (typeName _value) do
					{
						case "ARRAY": { _value = toString _value };
						case "STRING":
						{
							if (_savingMethod == "iniDB") then
							{
								_value = _value call iniDB_Base64Decode;
							};
						};
						default { _value = "[Beacon]" };
					};
				};
				case "uavSide":
				{
					if (_uavSide isEqualTo sideUnknown) then { _uavSide = STR_TO_SIDE(_value) };
				};
				case "uavAuto":
				{
					if (_value isEqualType true) then
					{
						_uavAuto = _value;
					};
				};
			};

			_obj setVariable [_var, _value, true];
		} forEach _variables;

		if (unitIsUAV _obj) then
		{
			[_obj, _uavSide, false, _uavAuto] spawn fn_createCrewUAV;
		};
				//make sure existing objects are given moveable variable. Comment line after update.
		//_obj setVariable ["moveable", true, true];

		// Base locker lights
		if (_obj getVariable ["lights",""] == "off") then
		{
			_obj setHit ["light_1_hit", 0.97];
		};


		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;

		_unlock = switch (true) do
		{
			case (_obj call _isWarchest): { true };
			case (_obj call _isBeacon):
			{
				pvar_spawn_beacons pushBack _obj;
				publicVariable "pvar_spawn_beacons";
				true
			};
			case (_locked < 1): { true };
			default { false };
		};

		if (_unlock) then
		{
			_obj setVariable ["objectLocked", false, true];
		}
		else
		{
			if (_boxSavingOn && {_class call _isBox}) then
			{
				if (!isNil "_weapons") then
				{
					{ _obj addWeaponCargoGlobal _x } forEach _weapons;
				};
				if (!isNil "_magazines") then
				{
					[_obj, _magazines] call processMagazineCargo;
				};
				if (!isNil "_items") then
				{
					{ _obj addItemCargoGlobal _x } forEach _items;
				};
				if (!isNil "_backpacks") then
				{
					{
						_obj addBackpackCargoGlobal _x;
					} forEach _backpacks;
				};
			};

			if (!isNil "_turretMags" && _staticWeaponSavingOn && {_class call _isStaticWeapon}) then
			{
				_obj setVehicleAmmo 0;
				{ _obj removeMagazineTurret [_x select 0, _x select 1] } forEach magazinesAllTurrets _obj;
				{ _obj addMagazine _x } forEach _turretMags;
			};

			if (!isNil "_ammoCargo") then { _obj setAmmoCargo _ammoCargo };
			if (!isNil "_fuelCargo") then { _obj setFuelCargo _fuelCargo };
			if (!isNil "_repairCargo") then { _obj setRepairCargo _repairCargo };

			reload _obj;
		};

		_obj hideObjectGlobal false;
	};

	if (!_valid && !isNil "_objectID") then
	{
		if (!isNil "_obj") then
		{
			_obj setVariable ["A3W_objectID", nil, true];
		};

		_exclVehicleIDs pushBack _vehicleID;
		_exclObjectIDs pushBack _objectID;
	};

	//Restore Service Objects
	if ({_obj iskindof _x} count 
	[
		"Box_NATO_AmmoVeh_F",
		"Box_EAST_AmmoVeh_F",
		"Box_IND_AmmoVeh_F",
		"B_Slingload_01_Ammo_F",
		"B_Slingload_01_Fuel_F",
		"B_Slingload_01_Medevac_F",
		"B_Slingload_01_Repair_F",
		"StorageBladder_01_fuel_forest_F",
		"StorageBladder_01_fuel_sand_F",
		"Land_fs_feed_F",
		"Land_FuelStation_01_pump_malevil_F",
		"Land_FuelStation_Feed_F",
		"Land_Pod_Heli_Transport_04_fuel_F",
		"Land_Pod_Heli_Transport_04_repair_F"
	] > 0) then	
	{
		_obj spawn GOM_fnc_addAircraftLoadoutToObject;
	};
	// //Re-enable door locking/unlocking for owned objects
	// if (_obj iskindof "Static") then
	// {
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_1',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_1', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_1"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_1',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_1', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_1"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_2',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_2', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_2"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_2',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_2', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_2"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_3',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_3', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_3"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_3',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_3', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_3"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_4',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_4', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_4"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_4',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_4', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_4"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_5',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_5', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_5"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_5',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_5', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_5"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_6',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_6', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_6"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_6',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_6', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_6"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_7',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_7', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_7"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_7',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_7', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_7"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_8',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_8', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_8"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_8',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_8', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_8"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_9',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_9', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_9"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_9',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_9', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_9"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_10',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_10', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_10"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_10',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_10', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_10"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_11',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_11', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_11"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_11',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_11', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_11"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_12',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_12', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_12"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_12',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_12', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_12"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_13',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_13', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_13"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_13',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_13', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_13"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_14',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_14', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_14"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_14',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_14', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_14"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_15',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_15', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_15"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_15',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_15', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_15"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_16',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_16', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_16"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_16',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_16', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_16"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_17',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_17', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_17"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_17',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_17', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_17"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_18',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_18', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_18"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_18',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_18', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_18"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_19',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_19', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_19"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_19',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_19', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door1_9"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_20',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_20', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_20"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_20',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_20', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_20"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_21',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_21', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_21"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_21',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_21', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_21"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Lock Door", {(_this select 0) setVariable ['bis_disabled_Door_22',1,true]}, nil, -99, false, true, "", "(_target  getVariable ['bis_disabled_Door_22', 0]) == 0 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_22"]] remoteExec ["addAction", -2, _obj];
	// 	[_obj, ["Unlock Door", {(_this select 0) setVariable ['bis_disabled_Door_22',0,true]}, nil, -99, false, true, "", "(_target getVariable ['bis_disabled_Door_22', 0]) == 1 && (_target getVariable 'ownerUID') == (getPlayerUID _this)", 50, false, "door_22"]] remoteExec ["addAction", -2, _obj];
	// };
} forEach _objects;
{
	//Restore building, towers, etc first
	if (_x iskindof "NonStrategic") then
	{
		_x hideObjectGlobal false;
		_x enableSimulation true;
	};
} foreach _objectsArray; // entities "NonStrategic";
{
	//Restore things that go in those buildings
	if (_x iskindof "Thing") then
	{
		_x hideObjectGlobal false;
		_x enableSimulation true;
	};
} foreach _objectsArray; // foreach entities "Thing";
{
	//Restore eerything else
	if (_x iskindof "All") then
	{
		_x hideObjectGlobal false;
		_x enableSimulation true;
	};
} foreach _objectsArray; // foreach entities "Thing";


if (_warchestMoneySavingOn) then
{
	_amounts = call compile preprocessFileLineNumbers format ["%1\getWarchestMoney.sqf", _methodDir];

	pvar_warchest_funds_west = (_amounts select 0) max 0;
	publicVariable "pvar_warchest_funds_west";
	pvar_warchest_funds_east = (_amounts select 1) max 0;
	publicVariable "pvar_warchest_funds_east";
};

diag_log format ["A3Wasteland - world persistence loaded %1 objects from %2", _objCount, call A3W_savingMethodName];

_exclObjectIDs call fn_deleteObjects;
