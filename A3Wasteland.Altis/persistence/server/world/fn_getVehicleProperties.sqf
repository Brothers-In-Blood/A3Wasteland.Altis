// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_getVehicleProperties.sqf
//	@file Author: AgentRev

private ["_veh", "_flying", "_class", "_purchasedVehicle", "_missionVehicle", "_pos", "_dir", "_vel", "_fuel", "_damage", "_hitPoints", "_hpDamage", "_variables", "_owner", "_doubleBSlash", "_textures", "_tex", "_texArr", "_weapons", "_magazines", "_items", "_backpacks", "_turretMags", "_turretMags2", "_turretMags3", "_hasDoorGuns", "_turrets", "_path", "_ammoCargo", "_fuelCargo", "_repairCargo", "_props"];

_veh = _this select 0;
_flying = if (count _this > 1) then { _this select 1 } else { false };

_class = typeOf _veh;
_purchasedVehicle = _veh getVariable ["A3W_purchasedVehicle", false];
_missionVehicle = (_veh getVariable ["A3W_missionVehicle", false] && !(_veh getVariable ["R3F_LOG_disabled", false]));

_pos = ASLtoATL getPosWorld _veh;
{ _pos set [_forEachIndex, _x call fn_numToStr] } forEach _pos;
_dir = [vectorDir _veh, vectorUp _veh];
_vel = velocity _veh;
_fuel = fuel _veh;
_damage = damage _veh;
_hitPoints = [];
_hpDamage = getAllHitPointsDamage _veh;

{
	if (_x != "") then
	{
		_hitPoints pushBack [_x, (_hpDamage select 2) select _forEachIndex];
	};
} forEach (_hpDamage select 0);

_variables = [];

switch (true) do
{
	case _purchasedVehicle:
	{
		_variables pushBack ["A3W_purchasedVehicle", true];
	};
	case _missionVehicle:
	{
		_variables pushBack ["A3W_missionVehicle", true];
	};
};

private _variant = _veh getVariable ["A3W_vehicleVariant", ""];

if (_variant != "") then
{
	_variables pushBack ["A3W_vehicleVariant", _variant];
};

private _resupplyTruck = _veh getVariable ["A3W_resupplyTruck", false];

if (_resupplyTruck) then
{
	_variables pushBack ["A3W_resupplyTruck", true];
};

private _isUav = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);

if (_isUav && side _veh in [BLUFOR,OPFOR,INDEPENDENT]) then
{
	_variables pushBack ["uavSide", str side _veh];
};

_owner = _veh getVariable ["ownerUID", ""];
private _ownerName = _veh getVariable ["ownerName", ""];

if (_ownerName != "") then
{
	_variables pushBack ["ownerName", toArray _ownerName];
};

private _locked = 1 max locked _veh; // default vanilla state is always 1, so we ignore 0's

_textures = [];
private _texturesVar = _veh getVariable ["A3W_objectTextures", []];

if (_texturesVar isEqualTypeAll "") then // TextureSource
{
	_textures = _texturesVar;
}
else // texture paths
{
	_doubleBSlash = (call A3W_savingMethod == "extDB");
	private _missionDir = [_veh getVariable "A3W_objectTextures_missionDir"] param [0, call currMissionDir, [""]];
	private _missionDirLen = count _missionDir;
	private _addTexture =
	{
		_tex = _x select 1;

		if (_tex select [0, _missionDirLen] == _missionDir) then
		{
			_tex = _tex select [_missionDirLen]; // exclude mission dir from path
		};

		if (_doubleBSlash) then
		{
			_tex = (["","\\"] select (_tex select [0,1] == "\")) + (_tex splitString "\" joinString "\\");
		};

		[_textures, _tex, [_x select 0]] call fn_addToPairs;
	};

	// vehicle has at least 2 random textures, save everything
	if (count getArray (configFile >> "CfgVehicles" >> _class >> "textureList") >= 4) then
	{
		{ _x = [_forEachIndex, _x]; call _addTexture } forEach getObjectTextures _veh;
	}
	else // only save custom ones
	{
		_addTexture forEach _texturesVar;
	};
};

_weapons = [];
_magazines = [];
_items = [];
_backpacks = [];

if (_class call fn_hasInventory) then
{
	// Save weapons & ammo
	_weapons = (getWeaponCargo _veh) call cargoToPairs;
	_magazines = _veh call fn_magazineAmmoCargo;
	_items = (getItemCargo _veh) call cargoToPairs;
	_backpacks = (getBackpackCargo _veh) call cargoToPairs;
};

// _turretMags is deprecated, leave empty
_turretMags = []; // magazinesAmmo _veh;
_turretMags2 = (magazinesAllTurrets _veh) select {_x select 0 != "FakeWeapon" && (_x select 0) select [0,5] != "Pylon"} apply {_x select [0,3]};
_turretMags3 = _veh call fn_getPylonsAmmo;

_ammoCargo = getAmmoCargo _veh;
_fuelCargo = getFuelCargo _veh;
_repairCargo = getRepairCargo _veh;

// Fix for -1.#IND
if (isNil "_ammoCargo" || {!finite _ammoCargo}) then { _ammoCargo = 0 };
if (isNil "_fuelCargo" || {!finite _fuelCargo}) then { _fuelCargo = 0 };
if (isNil "_repairCargo" || {!finite _repairCargo}) then { _repairCargo = 0 };

// Save vPin by LouD
{ _variables pushBack [_x select 0, _veh getVariable _x] } forEach
[
  ["vPin", false],
  ["password", ""]
];

//Service system

if ({_veh isKindOf _x} count 
	[
		"C_Offroad_01_repair_F",
		"C_Van_02_service_F",
		"C_Van_01_fuel_F",
		"B_G_Van_01_fuel_F",
		"B_Truck_01_fuel_F",
		"B_Truck_01_Repair_F",
		"B_Truck_01_ammo_F",
		"O_Truck_03_fuel_F",
		"O_Truck_03_repair_F",
		"O_Truck_03_ammo_F",
		"I_Truck_02_fuel_F",
		"I_Truck_02_ammo_F",
		"I_Truck_02_box_F",	
		"B_APC_Tracked_01_CRV_F",
		"O_Heli_Transport_04_ammo_F",
		"O_Heli_Transport_04_repair_F",
		"O_Heli_Transport_04_fuel_F"
	]>0) then
	{ 
		{_variables pushBack [_x select 0, _veh getVariable _x]} forEach [["GOM_fnc_repairCargo", nil], ["GOM_fnc_fuelCargo", nil], ["GOM_fnc_ammoCargo", nil]];
	};


_owner = _veh getVariable ["ownerUID", ""];

_props =
[
	["Class", _class],
	["Position", _pos],
	["Direction", _dir],
	["Velocity", _vel],
	["Fuel", _fuel],
	["Damage", _damage],
	["HitPoints", _hitPoints],
	["OwnerUID", _owner],
	["LockState", _locked],
	["Variables", _variables],
	["Textures", _textures],

	["Weapons", _weapons],
	["Magazines", _magazines],
	["Items", _items],
	["Backpacks", _backpacks],

	["TurretMagazines", _turretMags],
	["TurretMagazines2", _turretMags2],
	["TurretMagazines3", _turretMags3],

	["AmmoCargo", _ammoCargo],
	["FuelCargo", _fuelCargo],
	["RepairCargo", _repairCargo]
];

// If flying and not UAV, do not save current pos/dir/vel
if (_flying && !_isUav) then
{
	_props deleteRange [1,3];
};

_props
