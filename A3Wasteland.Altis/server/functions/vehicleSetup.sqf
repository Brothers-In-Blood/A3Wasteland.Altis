// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: vehicleSetup.sqf
//	@file Author: AgentRev Edited by: BIB_Monkey
//	@file Created: 15/06/2013 19:57

if (!isServer) exitWith {};

params [["_vehicle",objNull,[objNull]], ["_brandNew",true,[false]]]; // _brandNew: true for newly spawned/purchased vehicle (default), false for vehicles restored from save
private ["_class", "_getInOut", "_centerOfMass", "_weapons"];
_class = typeOf _vehicle;

_vehicle setVariable [call vChecksum, true];

clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

if !(_class isKindOf "AllVehicles") exitWith {}; // if not actual vehicle, finish here

_vehicle setUnloadInCombat [false, false]; // Try to prevent AI from getting out of vehicles while in combat (not sure if this actually works...)
{
	_vehicle setVariable ["A3W_hitPoint_" + getText (_x >> "name"), configName _x, true];
} forEach (_class call getHitPoints);

_vehicle setVariable ["A3W_hitPointSelections", true, true];
_vehicle setVariable ["A3W_handleDamageEH", _vehicle addEventHandler ["HandleDamage", vehicleHandleDamage]];
_vehicle setVariable ["A3W_dammagedEH", _vehicle addEventHandler ["Dammaged", vehicleDammagedEvent]];
_vehicle setVariable ["A3W_engineEH", _vehicle addEventHandler ["Engine", vehicleEngineEvent]];
_vehicle addEventHandler ["GetIn", fn_vehicleGetInOutServer];
_vehicle addEventHandler ["GetOut", fn_vehicleGetInOutServer];
_vehicle addEventHandler ["Killed", fn_vehicleKilledServer];

//Setup Vpin
_vehicle setVariable ["vPin", true, true];
_vehicle setVariable ["password", 0000, true];

if ({_class isKindOf _x} count ["Air","UGV_01_base_F"] > 0) then
{
	_vehicle remoteExec ["A3W_fnc_setupAntiExplode", 0, _vehicle];
};

if ({_vehicle iskindof _x} count
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
		"B_APC_Tracked_01_CRV_F",
		"O_Heli_Transport_04_ammo_F",
		"O_Heli_Transport_04_repair_F",
		"O_Heli_Transport_04_fuel_F"
	] >0)
then
{
	private _AmmoResourcesMax =
	[
			["B_Truck_01_ammo_F",					25000],
			["O_Truck_03_ammo_F", 					15000],
			["I_Truck_02_ammo_F",					10000],
			["B_APC_Tracked_01_CRV_F",				500],
			["O_Heli_Transport_04_ammo_F",			20000]

	];
	private _FuelResourcesMax =
	[
			["C_Van_01_fuel_F",						1000],
			["B_G_Van_01_fuel_F",					1000],
			["B_Truck_01_fuel_F",					25000],
			["O_Truck_03_fuel_F",					20000],
			["I_Truck_02_fuel_F",					15000],
			["B_APC_Tracked_01_CRV_F",				500],
			["O_Heli_Transport_04_fuel_F",			22000]

	];
	private _RepairResourcesMax =
	[
			["C_Offroad_01_repair_F",				500],
			["C_Van_02_service_F",					1000],
			["B_Truck_01_Repair_F",					25000],
			["O_Truck_03_repair_F",					20000],
			["B_APC_Tracked_01_CRV_F",				500],
			["O_Heli_Transport_04_repair_F",		22000]

	];
	_vehicle setAmmoCargo 0;
	_vehicle setFuelCargo 0;
	_vehicle setRepairCargo 0;
	_vehicle spawn GOM_fnc_addAircraftLoadoutToObject;
	{
		if (_Vehclass == _x select 0) then
		{
			_Vehicle setVariable ["GOM_fnc_ammoCargo", _x select 1];
		};
	} foreach _AmmoResourcesMax;
	{
		If (_Vehclass == _x select 0) then
		{
			_Vehicle setVariable ["GOM_fnc_fuelCargo", _x select 1];
		};
	} foreach _FuelResourcesMax;
	{
		if (_vehclass == _x select 0) then
		{
			_Vehicle setVariable ["GOM_fnc_repairCargo", _x select 1];
		};
	} foreach _RepairResourcesMax;
};

//Recon Drones
if ({_vehicle iskindof _x} count 
	[
		"O_UAV_02_F",
		"I_UAV_02_F",
		"B_UAV_02_F"
	]>0)
Then
{
	_vehicle animate ["hideweapons",1];
	_vehicle removeweapon "missiles_SCALPEL";
};

[_vehicle, _brandNew] call A3W_fnc_setVehicleLoadout;

// Vehicle customization
switch (true) do
{
	case (_class isKindOf "SUV_01_base_F"):
	{
		// Lower SUV center of mass to prevent rollovers
		_centerOfMass = getCenterOfMass _vehicle;
		_centerOfMass set [2, -0.657]; // original = -0.557481
		_vehicle setCenterOfMass _centerOfMass;
	};
	case (_class isKindOf "MRAP_02_base_F"):
	{
		// Lower Ifrit center of mass to prevent rollovers
		_centerOfMass = getCenterOfMass _vehicle;
		_centerOfMass set [2, (_centerOfMass select 2) - 0.1]; // cannot be static number like SUV due to different values for each variant
		_vehicle setCenterOfMass _centerOfMass;
	};
	case (_class isKindOf "Offroad_01_repair_base_F"):
	{
		_vehicle animate ["HideServices", 0];
	};
	case ({_class isKindOf _x} count ["B_Heli_Light_01_F", "B_Heli_Light_01_armed_F"] > 0):
	{
		// Add flares to poor MH-9's
		_vehicle addWeaponTurret ["CMFlareLauncher", [-1]];

		if (_brandNew) then
		{
			_vehicle addMagazineTurret ["60Rnd_CMFlare_Chaff_Magazine", [-1]];
		};
	};
	case (_class isKindOf "Plane_Fighter_03_base_F"):
	{
		if (_brandNew) then
		{
			_vehicle addMagazineTurret ["300Rnd_20mm_shells", [-1]];
		};
	};
};

_weapons = getArray (configFile >> "CfgVehicles" >> _class >> "weapons");

// Horn customizations
switch (true) do
{
	case ({_x == "TruckHorn"} count _weapons > 0):
	{
		// Replace clown bike horn to something better
		_vehicle removeWeaponTurret ["TruckHorn", [-1]];
		_vehicle addWeaponTurret ["TruckHorn2", [-1]];
	};
	case ({_x == "CarHorn"} count _weapons > 0):
	{
		// Replace other clown bike horn to something better
		_vehicle removeWeaponTurret ["CarHorn", [-1]];
		_vehicle addWeaponTurret ["SportCarHorn", [-1]];
	};
	case (_class isKindOf "Truck_01_base_F"):
	{
		// Give real truck horn to HEMTT
		_vehicle removeWeaponTurret ["TruckHorn2", [-1]];
		_vehicle addWeaponTurret ["TruckHorn3", [-1]];
	};
	case (_class isKindOf "Kart_01_Base_F"):
	{
		// Add quadbike horn to karts
		_vehicle addWeaponTurret ["MiniCarHorn", [-1]];
	};
	case (_class isKindOf "B_GEN_Offroad_01_gen_F"):
	{
		_vehicle removeWeaponTurret ["SportCarHorn", [-1]];
		_vehicle addWeaponTurret ["AmbulanceHorn", [-1]];
	};
};

// Double minigun ammo to compensate for Bohemia's incompetence (http://feedback.arma3.com/view.php?id=21613)
if (_brandNew) then
{
	{
		_x params ["_mag", "_path"];
		if (_mag select [0,5] != "Pylon" && (toLower getText (configFile >> "CfgMagazines" >> _mag >> "ammo")) find "_minigun_" != -1) then
		{
			_vehicle addMagazineTurret [_mag, _path];
		};
	} forEach magazinesAllTurrets _vehicle;

	private "_magCfg";
	{
		_magCfg = configFile >> "CfgMagazines" >> _x;
		if ((toLower getText (_magCfg >> "ammo")) find "_minigun_" != -1) then
		{
			_vehicle setAmmoOnPylon [_forEachIndex + 1, 2 * getNumber (_magCfg >> "count")];
		};
	} forEach getPylonMagazines _vehicle;
};
