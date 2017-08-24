// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//  @file Name: fn_AResupplyPoint.sqf
//  @file Author: BIB_Monkey

#define RESUPPLY_TRUCK_DISTANCE 20
#define PRICE_RELATIONSHIP 10 // resupply price = brand-new store price divided by PRICE_RELATIONSHIP
#define RESUPPLY_TIMEOUT 30
// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith {
	titleText ["You are already performing another action.", "PLAIN DOWN", 0.5];
};

params ["", ["_unit",objNull,[objNull]]];

_vehicle = vehicle _unit;

_pylons = //Array of all possible pylon weapons
  [

		//	Pylon Weapons						,						Price					What it actually is

    ["PylonRack_1Rnd_LG_scalpel",             10000],   	//SCALPEL X1
    ["PylonRack_3Rnd_LG_scalpel",             30000],  	//SCALPEL X3
    ["PylonRack_4Rnd_LG_scalpel",             40000],		//SCALPEL X4
    ["PylonRack_1Rnd_Missile_AGM_02_F",       15000], 		//MACER AGM X1
    ["PylonRack_Missile_AGM_02_x1",           20000],		//MACER II AGM X1
    ["PylonMissile_Missile_AGM_02_x2",        30000], 		//MACER AGM X2
    ["PylonRack_Missile_AGM_02_x2",           40000],		//MACER II X2
    ["PylonRack_3Rnd_Missile_AGM_02_F",      	45000], 	//MACER AGM X3
    ["PylonRack_12Rnd_PG_missiles",           20000], 	//DAGR X12
    ["PylonRack_1Rnd_Missile_AGM_01_F",       15000],		//SHARUR X1
    ["PylonMissile_Missile_AGM_KH25_x1",      20000],		//KH-25 X1
    ["PylonRack_1Rnd_Missile_AA_04_F",        15000], 		//FALCHION 22 X1
    ["PylonRack_1Rnd_AAA_missiles",           2500], 		//ASRAAM X1
    ["PylonRack_Missile_AMRAAM_C_x1",         4000],		//AMRAAM C X1
    ["PylonRack_Missile_AMRAAM_C_x2",         8000],		//AMRAAM C X2
    ["PylonMissile_Missile_AMRAAM_D_INT_x1",  5000], 		//AMRAAM D X1
    ["PylonRack_Missile_AMRAAM_D_x2",         10000], 	//AMRAAM D X2
    ["PylonRack_Missile_BIM9X_x2",            14000], 	//BIM9X X2
    ["PylonMissile_Missile_BIM9X_x1",         7000],		//BIM8X X1
    ["PylonRack_1Rnd_Missile_AA_03_F",        8000], 		//SAHR-3
    ["PylonMissile_Missile_AA_R73_x1",        9000],		//R-73 X1
    ["PylonMissile_Missile_AA_R77_x1",        10000],		//R-77 X1
    ["PylonRack_1Rnd_GAA_missiles",           40000],		//ZYPHER X1
    ["PylonRack_12Rnd_missiles",              3000], 		//DAR ROCKETS X12
    ["PylonRack_7Rnd_Rocket_04_HE_F",          14000],   //SHRIEKER HE ROCKETS X7
    ["PylonRack_7Rnd_Rocket_04_AP_F",          14000], 	//SHRIEKER AP ROCKETS X7
    ["PylonRack_20Rnd_Rocket_03_HE_F",         24000],	//TRATNYR HE ROCKETS X20
    ["PylonRack_20Rnd_Rocket_03_AP_F",         24000],	//TRATNYR AP ROCKETS X20
    ["PylonRack_19Rnd_Rocket_Skyfire",         19000],		//SKYFIRE X19
    ["PylonMissile_1Rnd_Bomb_04_F",            2500], 	//GBU-12 GUIDED BOMB NATO X1
    ["PylonMissile_1Rnd_Bomb_03_F",            2500],		//LOM-250G GUIDED BOMB CSAT X1
    ["PylonMissile_Bomb_GBU12_x1",             2500], 	//GBU-12 LASER GUIDIED BOMB X1
    ["PylonRack_Bomb_GBU12_x2",                5000],		//GBU-12 LASER GUIDED BOMB X2
    ["PylonMissile_Bomb_KAB250_x1",            2500],		//KAB250 GUIDED BOMB X1
    ["PylonMissile_1Rnd_Mk82_F",               500], 		//MK-82 DUMB BOMB X1
    ["PylonWeapon_300Rnd_20mm_shells",         1700],		//20mm TWIN CANNON
    ["PylonWeapon_2000Rnd_65x39_belt",         100]			//6.5mm GATTLING GUN (RIGHT SIDE)
];

//check if caller is in vehicle
if (_vehicle == _unit) exitWith {};

//Define Vehicle
_vehClass = typeOf _vehicle;
_vehCfg = configFile >> "CfgVehicles" >> _vehClass;
_vehName = getText (_vehCfg >> "displayName");

// price = 1000 for vehicles not found in vehicle store
_baseprice = 1000;

//Determine base cost of servicing vehicle pased on percentage of store price
{
if (_vehClass == _x select 1) exitWith
{
	_baseprice = _x select 2;
	_baseprice = round (_baseprice / PRICE_RELATIONSHIP);
};
} forEach (call allVehStoreVehicles + call staticGunsArray);

// Differntiate between nondymanic and dynamic vehicles as well as by number of pylons
Switch (true) do
{
	// Non-Dynamic Vehicles
	case ({_vehicle iskindof _x} count
	[
		"B_CTRG_LSV_01_light_F", "B_CTRG_Heli_Transport_01_sand_F", "B_CTRG_Heli_Transport_01_tropic_F", "B_G_Boat_Transport_01_F", "B_G_Van_01_fuel_F",
		"B_G_Offroad_01_F", "B_G_Offroad_01_armed_F", "B_G_Offroad_01_repair_F", "B_G_Quadbike_01_F", "B_G_Van_01_transport_F", "B_G_Mortar_01_F",
		"B_GEN_Offroad_01_gen_F", "B_APC_Tracked_01_AA_F", "B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_CRV_F", "B_APC_Tracked_01_rcws_F",
		"B_MBT_01_arty_F", "B_MBT_01_mlrs_F", "B_Boat_Transport_01_F", "B_Lifeboat", "B_Boat_Armed_01_minigun_F", "B_Truck_01_mover_F",
		"B_Truck_01_ammo_F", "B_Truck_01_box_F", "B_Truck_01_fuel_F", "B_Truck_01_Repair_F", "B_Truck_01_medical_F", "B_Truck_01_transport_F",
		"B_Truck_01_covered_F", "B_MRAP_01_F", "B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F", "B_LSV_01_armed_F", "B_LSV_01_unarmed_F", "B_Quadbike_01_F",
		"B_UAV_01_F", "B_UGV_01_F", "B_UGV_01_rcws_F", "B_Heli_Transport_03_F", "B_Heli_Transport_03_unarmed_F", "B_Heli_Light_01_F", "B_Heli_Transport_01_F",
		"B_MBT_01_cannon_F", "B_MBT_01_TUSK_F", "B_SAM_System_02_F", "B_HMG_01_F", "B_HMG_01_high_F", "B_HMG_01_A_F", "B_GMG_01_F", "B_GMG_01_high_F", "B_GMG_01_A_F",
		"B_SAM_System_01_F", "B_Mortar_01_F", "B_AAA_System_01_F", "B_Static_Designator_01_F", "B_static_AA_F", "B_static_AT_F", "B_T_Lifeboat", "B_T_VTOL_01_armed_F",
		"B_T_VTOL_01_infantry_F", "B_T_VTOL_01_vehicle_F", 	"O_APC_Tracked_02_AA_F", "O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_F", "O_MBT_02_arty_F",
		"O_Boat_Transport_01_F", "O_Lifeboat", "O_Boat_Armed_01_hmg_F", "O_MRAP_02_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F", "O_LSV_02_armed_F", "O_LSV_02_unarmed_F",
		"O_Quadbike_01_F", "O_Truck_03_device_F", "O_Truck_03_ammo_F", "O_Truck_03_fuel_F", "O_Truck_03_medical_F", "O_Truck_03_repair_F", "O_Truck_03_transport_F",
		"O_Truck_03_covered_F", "O_Truck_02_Ammo_F", "O_Truck_02_fuel_F", "O_Truck_02_medical_F", "O_Truck_02_medical_F", "O_Truck_02_box_F", "O_Truck_02_transport_F",
		"O_Truck_02_covered_F", "O_UAV_01_F", "O_UGV_01_F", "O_UGV_01_rcws_F", "O_Heli_Transport_04_F", "O_Heli_Transport_04_ammo_F", "O_Heli_Transport_04_bench_F",
		"O_Heli_Transport_04_box_F", "O_Heli_Transport_04_fuel_F", "O_Heli_Transport_04_medevac_F", "O_Heli_Transport_04_repair_F", "O_Heli_Transport_04_covered_F",
		"O_Heli_Light_02_unarmed_F", "O_SDV_01_F", "B_SDV_01_F", "I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_Boat_Transport_01_F",
		"I_Boat_Armed_01_minigun_F", "I_Quadbike_01_F", "I_MRAP_03_F", "I_MRAP_03_gmg_F", "I_MRAP_03_hmg_F", "I_Truck_02_ammo_F", "I_Truck_02_fuel_F",
		"I_Truck_02_medical_F", "I_Truck_02_box_F", "I_Truck_02_transport_F", "I_Truck_02_covered_F", "I_UAV_01_F", "I_UGV_01_F", "I_UGV_01_rcws_F",
		"I_Heli_Transport_02_F", "I_Heli_light_03_unarmed_F", "I_SDV_01_F", "I_MBT_03_cannon_F", "I_HMG_01_F", "I_HMG_01_high_F", "I_HMG_01_A_F",
		"I_GMG_01_F", "I_GMG_01_high_F", "I_GMG_01_A_F", "I_Mortar_01_F", "I_static_AA_F", "I_static_AT_F", "I_C_Boat_Transport_02_F", "C_Heli_Light_01_civil_F",
		"C_Van_01_fuel_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_Kart_01_F", "C_Kart_01_Blu_F", "C_Kart_01_Fuel_F", "C_Kart_01_Red_F", "C_Kart_01_Vrana_F",
		"C_Offroad_02_unarmed_F", "C_Offroad_01_F", "C_Offroad_01_repair_F", "C_Quadbike_01_F", "C_SUV_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Truck_02_fuel_F",
		"C_Truck_02_box_F", "C_Truck_02_transport_F", "C_Truck_02_covered_F", "C_Plane_Civil_01_F", "C_Plane_Civil_01_racing_F", "O_T_LSV_02_armed_F", "O_MBT_02_cannon_F"
	]>0):
	{
		//Non Dynamic vehicles are service based on percentage of store price
	 _totalprice = _baseprice;

	 //Find ot how much money the player has
	 _money = player getVariable ["cmoney", 0];

	 // Check player has enough money
	 if (_money >= _totalprice) then {
	 	//Prompt player to confirm cost
	 	_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
	 	[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
	 	mutexScriptInProgress = true;  //prevents players from doing other actions
	 	doCancelAction = false;

	 	//Subtract cost from player money
	 	player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

	 	//Begin Service Actions
	 	 titleText ["Rearming...", "PLAIN"];
	 	 sleep 15;
	 	_vehicle setVehicleAmmo 1;
	 	titleText ["Reparing...", "PLAIN"];
	 	sleep 15;
	 	_vehicle setDammage 0;
	 	titleText ["Refueling...", "PLAIN"];
	 	sleep 15;
	 	_vehicle setFuel 1;
	 	titleText ["Vehicle Ready!", "PLAIN"];
	 } else {
	 		titleText ["You don't have enough money", "PLAIN", 1];
	 };
	};


	//Dynamic Vehicle with Two Pylons
	case ({_vehicle iskindof _x} count ["B_UAV_02_dynamicLoadout_F", "B_UAV_05_F", "B_Heli_Light_01_dynamicLoadout_F", "O_Heli_Light_02_dynamicLoadout_F", "I_Heli_light_03_dynamicLoadout_F", "O_UAV_02_dynamicLoadout_F", "I_UAV_02_dynamicLoadout_F"] >0):
	{

		//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;

		//Set 0 pylon value if none Loaded
		_pylon1price = 0;
		_pylon2price = 0;

		//Set price per pylon weapon laoded on aircraft
		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;

		//Total Price equials sum of prices of all components
		_totalprice = (_baseprice + _pylon1price + _pylon2price);

		//Find ot how much money the player has
		_money = player getVariable ["cmoney", 0];

		// Check player has enough money
		if (_money >= _totalprice) then {
			//Prompt player to confirm cost
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
			[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
			mutexScriptInProgress = true;  //prevents players from doing other actions
			doCancelAction = false;

			//Subtract cost from player money
			player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

			//Begin Service Actions
			 titleText ["Rearming...", "PLAIN"];
			 sleep 15;
			_vehicle setVehicleAmmo 1;
			titleText ["Reparing...", "PLAIN"];
			sleep 15;
			_vehicle setDammage 0;
			titleText ["Refueling...", "PLAIN"];
			sleep 15;
			_vehicle setFuel 1;
			titleText ["Vehicle Ready!", "PLAIN"];
		} else {
				titleText ["You don't have enough money", "PLAIN", 1];
		};
	};


	//Dynamic Vehicles with 4 pylons
	case ({_vehicle iskindof _x} count ["B_T_UAV_03_dynamicLoadout_F", "O_Heli_Attack_02_dynamicLoadout_F", "O_T_VTOL_02_infantry_dynamicLoadout_F", "O_T_VTOL_02_vehicle_dynamicLoadout_F"] >0):
	{

			//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;
		_pylon3 = _pylonsequiped select 2;
		_pylon4 = _pylonsequiped select 3;

		_pylon1price = 0;
		_pylon2price = 0;
		_pylon3price = 0;
		_pylon4price = 0;

		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon3 == _x select 0) exitWith
			{
				_pylon3price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon4 == _x select 0) exitWith
			{
				_pylon4price = _x select 1;
			};
		} forEach _pylons;


		_totalprice = (_baseprice + _pylon1price + _pylon2price + _pylon3price + _pylon4price);

		//Find ot how much money the player has
		_money = player getVariable ["cmoney", 0];

		// Check player has enough money
		if (_money >= _totalprice) then {
			//Prompt player to confirm cost
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
			[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
			mutexScriptInProgress = true;  //prevents players from doing other actions
			doCancelAction = false;

			//Subtract cost from player money
			player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

			//Begin Service Actions
			 titleText ["Rearming...", "PLAIN"];
			 sleep 15;
			_vehicle setVehicleAmmo 1;
			titleText ["Reparing...", "PLAIN"];
			sleep 15;
			_vehicle setDammage 0;
			titleText ["Refueling...", "PLAIN"];
			sleep 15;
			_vehicle setFuel 1;
			titleText ["Vehicle Ready!", "PLAIN"];
		} else {
				titleText ["You don't have enough money", "PLAIN", 1];
		};
	};


	// Dynamic Vehicles with 6 pylons
	case ({_vehicle iskindof _x} count ["B_Heli_Attack_01_dynamicLoadout_F", "I_Plane_Fighter_04_F"] >0):
	{
			//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;
		_pylon3 = _pylonsequiped select 2;
		_pylon4 = _pylonsequiped select 3;
		_pylon5 = _pylonsequiped select 4;
		_pylon6 = _pylonsequiped select 5;

		//Set 0 pylon value if none Loaded
		_pylon1price = 0;
		_pylon2price = 0;
		_pylon3price = 0;
		_pylon4price = 0;
		_pylon5price = 0;
		_pylon6price = 0;

			//Set price per pylon weapon laoded on aircraft
		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon3 == _x select 0) exitWith
			{
				_pylon3price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon4 == _x select 0) exitWith
			{
				_pylon4price = _x select 1;
			};
		} forEach _pylons;
		{
		if (_pylon5 == _x select 0) exitWith
		{
			_pylon6price = _x select 1;
		};
		} forEach _pylons;
		{
			if (_pylon6 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;


		//Total Price equials sum of prices of all components
		_totalprice = (_baseprice + _pylon1price + _pylon2price + _pylon3price + _pylon4price + _pylon5price + _pylon6price);

		//Find ot how much money the player has
		_money = player getVariable ["cmoney", 0];

		// Check player has enough money
		if (_money >= _totalprice) then {
			//Prompt player to confirm cost
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
			[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
			mutexScriptInProgress = true;  //prevents players from doing other actions
			doCancelAction = false;

			//Subtract cost from player money
			player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

			//Begin Service Actions
			 titleText ["Rearming...", "PLAIN"];
			 sleep 15;
			_vehicle setVehicleAmmo 1;
			titleText ["Reparing...", "PLAIN"];
			sleep 15;
			_vehicle setDammage 0;
			titleText ["Refueling...", "PLAIN"];
			sleep 15;
			_vehicle setFuel 1;
			titleText ["Vehicle Ready!", "PLAIN"];
		} else {
				titleText ["You don't have enough money", "PLAIN", 1];
		};
	};


	// Dynamic Vehicles with 7 pylons
	case ({_vehicle iskindof _x} count ["O_Plane_Fighter_02_Stealth_F", "I_Plane_Fighter_03_dynamicLoadout_F"] >0):
	{
			//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;
		_pylon3 = _pylonsequiped select 2;
		_pylon4 = _pylonsequiped select 3;
		_pylon5 = _pylonsequiped select 4;
		_pylon6 = _pylonsequiped select 5;
		_pylon7 = _pylonsequiped select 6;

		//Set 0 pylon value if none Loaded
		_pylon1price = 0;
		_pylon2price = 0;
		_pylon3price = 0;
		_pylon4price = 0;
		_pylon5price = 0;
		_pylon6price = 0;
		_pylon7price = 0;

			//Set price per pylon weapon laoded on aircraft
		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon3 == _x select 0) exitWith
			{
				_pylon3price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon4 == _x select 0) exitWith
			{
				_pylon4price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon5 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon6 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon7 == _x select 0) exitWith
			{
				_pylon7price = _x select 1;
			};
		} forEach _pylons;

		//Total Price equials sum of prices of all components
		_totalprice = (_baseprice + _pylon1price + _pylon2price + _pylon3price + _pylon4price + _pylon5price + _pylon6price + _pylon7price);

		//Find ot how much money the player has
		_money = player getVariable ["cmoney", 0];

		// Check player has enough money
		if (_money >= _totalprice) then {
			//Prompt player to confirm cost
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
			[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
			mutexScriptInProgress = true;  //prevents players from doing other actions
			doCancelAction = false;

			//Subtract cost from player money
			player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

			//Begin Service Actions
			 titleText ["Rearming...", "PLAIN"];
			 sleep 15;
			_vehicle setVehicleAmmo 1;
			titleText ["Reparing...", "PLAIN"];
			sleep 15;
			_vehicle setDammage 0;
			titleText ["Refueling...", "PLAIN"];
			sleep 15;
			_vehicle setFuel 1;
			titleText ["Vehicle Ready!", "PLAIN"];
		} else {
				titleText ["You don't have enough money", "PLAIN", 1];
		};
	};


	// Dynamic Vehicles with 10 pylons
	case ({_vehicle iskindof _x} count ["B_Plane_Fighter_01_Stealth_F"] >0):
	{
			//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;
		_pylon3 = _pylonsequiped select 2;
		_pylon4 = _pylonsequiped select 3;
		_pylon5 = _pylonsequiped select 4;
		_pylon6 = _pylonsequiped select 5;
		_pylon7 = _pylonsequiped select 6;
		_pylon8 = _pylonsequiped select 7;


		//Set 0 pylon value if none Loaded
		_pylon1price = 0;
		_pylon2price = 0;
		_pylon3price = 0;
		_pylon4price = 0;
		_pylon5price = 0;
		_pylon6price = 0;
		_pylon7price = 0;
		_pylon8price = 0;


		//Set price per pylon weapon laoded on aircraft
		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon3 == _x select 0) exitWith
			{
				_pylon3price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon4 == _x select 0) exitWith
			{
				_pylon4price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon5 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon6 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon7 == _x select 0) exitWith
			{
				_pylon7price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon8 == _x select 0) exitWith
			{
				_pylon8price = _x select 1;
			};
		} forEach _pylons;



		//Total Price equials sum of prices of all components
		_totalprice = (_baseprice + _pylon1price + _pylon2price + _pylon3price + _pylon4price + _pylon5price + _pylon6price + _pylon7price + _pylon8price);
	};


	// Dynamic Vehicles with 10 pylons
	case ({_vehicle iskindof _x} count ["B_Plane_CAS_01_dynamicLoadout_F", "O_Plane_CAS_02_dynamicLoadout_F"] >0):
	{
			//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;
		_pylon3 = _pylonsequiped select 2;
		_pylon4 = _pylonsequiped select 3;
		_pylon5 = _pylonsequiped select 4;
		_pylon6 = _pylonsequiped select 5;
		_pylon7 = _pylonsequiped select 6;
		_pylon8 = _pylonsequiped select 7;
		_pylon9 = _pylonsequiped select 8;
		_pylon10 = _pylonsequiped select 9;


		//Set 0 pylon value if none Loaded
		_pylon1price = 0;
		_pylon2price = 0;
		_pylon3price = 0;
		_pylon4price = 0;
		_pylon5price = 0;
		_pylon6price = 0;
		_pylon7price = 0;
		_pylon8price = 0;
		_pylon9price = 0;
		_pylon10price = 0;


		//Set price per pylon weapon laoded on aircraft
		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon3 == _x select 0) exitWith
			{
				_pylon3price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon4 == _x select 0) exitWith
			{
				_pylon4price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon5 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon6 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon7 == _x select 0) exitWith
			{
				_pylon7price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon8 == _x select 0) exitWith
			{
				_pylon8price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon9 == _x select 0) exitWith
			{
			_pylon9price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon10 == _x select 0) exitWith
			{
			_pylon10price = _x select 1;
			};
		} forEach _pylons;



		//Total Price equials sum of prices of all components
		_totalprice = (_baseprice + _pylon1price + _pylon2price + _pylon3price + _pylon4price + _pylon5price + _pylon6price + _pylon7price + _pylon8price + _pylon9price + _pylon10price);

		//Find ot how much money the player has
		_money = player getVariable ["cmoney", 0];

		// Check player has enough money
		if (_money >= _totalprice) then {
			//Prompt player to confirm cost
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
			[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
			mutexScriptInProgress = true;  //prevents players from doing other actions
			doCancelAction = false;

			//Subtract cost from player money
			player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

			//Begin Service Actions
			 titleText ["Rearming...", "PLAIN"];
			 sleep 15;
			_vehicle setVehicleAmmo 1;
			titleText ["Reparing...", "PLAIN"];
			sleep 15;
			_vehicle setDammage 0;
			titleText ["Refueling...", "PLAIN"];
			sleep 15;
			_vehicle setFuel 1;
			titleText ["Vehicle Ready!", "PLAIN"];
		} else {
				titleText ["You don't have enough money", "PLAIN", 1];
		};
	};


	// Dynamic Vehicles with 12 pylons
	case ({_vehicle iskindof _x} count ["B_Plane_Fighter_01_F"] >0):
	{
			//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;
		_pylon3 = _pylonsequiped select 2;
		_pylon4 = _pylonsequiped select 3;
		_pylon5 = _pylonsequiped select 4;
		_pylon6 = _pylonsequiped select 5;
		_pylon7 = _pylonsequiped select 6;
		_pylon8 = _pylonsequiped select 7;
		_pylon9 = _pylonsequiped select 8;
		_pylon10 = _pylonsequiped select 9;
		_pylon11 = _pylonsequiped select 10;
		_pylon12 = _pylonsequiped select 11;


		//Set 0 pylon value if none Loaded
		_pylon1price = 0;
		_pylon2price = 0;
		_pylon3price = 0;
		_pylon4price = 0;
		_pylon5price = 0;
		_pylon6price = 0;
		_pylon7price = 0;
		_pylon8price = 0;
		_pylon9price = 0;
		_pylon10price = 0;
		_pylon11price = 0;
		_pylon12price = 0;


		//Set price per pylon weapon laoded on aircraft
		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon3 == _x select 0) exitWith
			{
				_pylon3price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon4 == _x select 0) exitWith
			{
				_pylon4price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon5 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon6 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon7 == _x select 0) exitWith
			{
				_pylon7price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon8 == _x select 0) exitWith
			{
				_pylon8price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon9 == _x select 0) exitWith
			{
			_pylon9price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon10 == _x select 0) exitWith
			{
			_pylon10price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon11 == _x select 0) exitWith
			{
			_pylon11price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon12 == _x select 0) exitWith
			{
			_pylon12price = _x select 1;
			};
		} forEach _pylons;


		//Total Price equials sum of prices of all components
		_totalprice = (_baseprice + _pylon1price + _pylon2price + _pylon3price + _pylon4price + _pylon5price + _pylon6price + _pylon7price + _pylon8price + _pylon9price + _pylon10price + _pylon10price + _pylon12price);

		//Find ot how much money the player has
		_money = player getVariable ["cmoney", 0];

		// Check player has enough money
		if (_money >= _totalprice) then {
			//Prompt player to confirm cost
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
			[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
			mutexScriptInProgress = true;  //prevents players from doing other actions
			doCancelAction = false;

			//Subtract cost from player money
			player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

			//Begin Service Actions
			 titleText ["Rearming...", "PLAIN"];
			 sleep 15;
			_vehicle setVehicleAmmo 1;
			titleText ["Reparing...", "PLAIN"];
			sleep 15;
			_vehicle setDammage 0;
			titleText ["Refueling...", "PLAIN"];
			sleep 15;
			_vehicle setFuel 1;
			titleText ["Vehicle Ready!", "PLAIN"];
		} else {
				titleText ["You don't have enough money", "PLAIN", 1];
		};
	};


	// Dynamic Vehicles with 13 pylons
	case ({_vehicle iskindof _x} count ["O_Plane_Fighter_02_F"] >0):
	{
			//Determine Weapons Loaded on Pylons
		_pylonsequiped = GetPylonMagazines _vehicle;
		_pylon1 = _pylonsequiped select 0;
		_pylon2 = _pylonsequiped select 1;
		_pylon3 = _pylonsequiped select 2;
		_pylon4 = _pylonsequiped select 3;
		_pylon5 = _pylonsequiped select 4;
		_pylon6 = _pylonsequiped select 5;
		_pylon7 = _pylonsequiped select 6;
		_pylon8 = _pylonsequiped select 7;
		_pylon9 = _pylonsequiped select 8;
		_pylon10 = _pylonsequiped select 9;
		_pylon11 = _pylonsequiped select 10;
		_pylon12 = _pylonsequiped select 11;
		_pylon13 = _pylonsequiped select 13;


		//Set 0 pylon value if none Loaded
		_pylon1price = 0;
		_pylon2price = 0;
		_pylon3price = 0;
		_pylon4price = 0;
		_pylon5price = 0;
		_pylon6price = 0;
		_pylon7price = 0;
		_pylon8price = 0;
		_pylon9price = 0;
		_pylon10price = 0;
		_pylon11price = 0;
		_pylon12price = 0;
		_pylon13price = 0;


		//Set price per pylon weapon laoded on aircraft
		{
			if (_pylon1 == _x select 0) exitWith
			{
				_pylon1price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon2 == _x select 0) exitWith
			{
				_pylon2price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon3 == _x select 0) exitWith
			{
				_pylon3price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon4 == _x select 0) exitWith
			{
				_pylon4price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon5 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon6 == _x select 0) exitWith
			{
				_pylon6price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon7 == _x select 0) exitWith
			{
				_pylon7price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon8 == _x select 0) exitWith
			{
				_pylon8price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon9 == _x select 0) exitWith
			{
			_pylon9price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon10 == _x select 0) exitWith
			{
			_pylon10price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon11 == _x select 0) exitWith
			{
			_pylon11price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon12 == _x select 0) exitWith
			{
			_pylon12price = _x select 1;
			};
		} forEach _pylons;
		{
			if (_pylon13 == _x select 0) exitWith
			{
			_pylon13price = _x select 1;
			};
		} forEach _pylons;


		//Total Price equials sum of prices of all components
		_totalprice = (_baseprice + _pylon1price + _pylon2price + _pylon3price + _pylon4price + _pylon5price + _pylon6price + _pylon7price + _pylon8price + _pylon9price + _pylon10price + _pylon10price + _pylon12price + _pylon13price);

		//Find ot how much money the player has
		_money = player getVariable ["cmoney", 0];

		// Check player has enough money
		if (_money >= _totalprice) then {
			//Prompt player to confirm cost
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _totalprice, _vehName], "Do you want to proceed?"];
			[_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage;
			mutexScriptInProgress = true;  //prevents players from doing other actions
			doCancelAction = false;

			//Subtract cost from player money
			player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _totalprice, true];

			//Begin Service Actions
			 titleText ["Rearming...", "PLAIN"];
			 sleep 15;
			_vehicle setVehicleAmmo 1;
			titleText ["Reparing...", "PLAIN"];
			sleep 15;
			_vehicle setDammage 0;
			titleText ["Refueling...", "PLAIN"];
			sleep 15;
			_vehicle setFuel 1;
			titleText ["Vehicle Ready!", "PLAIN"];
		} else {
				titleText ["You don't have enough money", "PLAIN", 1];
		};


	};
};

mutexScriptInProgress = false;
//All Done!
