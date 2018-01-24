// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2017 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: vehicleLoadouts.sqf
//	@file Author: AgentRev, BIB_Monkey

/*
	HOW TO CREATE A PYLON LOADOUT:
	 1. Create new scenario in Eden, add vehicle, adjust pylon loadout, and set Object Init to: copyToClipboard str getPylonMagazines this
	 3. Play scenario, wait until loaded, then pause game and return to Eden.
	 4. Your pylon array is now in the clipboard, which you can paste in this file, e.g. _pylons = ["PylonMissile_Missile_AA_R73_x1","","","","","","","","","","","","",""];

	Note: You can use any pylon type you want in the script, even if not shown in the editor, it should normally work! e.g. "PylonRack_12Rnd_missiles" for "B_Plane_Fighter_01_F"
*/
/*
PYLON OPTIONS:
	AIR TO GROUND MISSILES:
		"PylonRack_1Rnd_LG_scalpel"						SCALPEL X1
		"PylonRack_3Rnd_LG_scalpel"						SCALPEL X3
		"PylonRack_4Rnd_LG_scalpel"						SCALPEL X4
		"PylonRack_1Rnd_Missile_AGM_02_F"				MACER AGM X1
		"PylonRack_Missile_AGM_02_x1"					MACER II AGM X1
		"PylonMissile_Missile_AGM_02_x2"				MACER AGM X2
		"PylonRack_Missile_AGM_02_x2"					MACER II X2
		"PylonRack_3Rnd_Missile_AGM_02_F"				MACER AGM X3
		"PylonRack_12Rnd_PG_missiles"					DAGR X12
		"PylonRack_1Rnd_Missile_AGM_01_F"				SHARUR X1
		"PylonMissile_Missile_AGM_KH25_x1"				KH-25 X1

	AIR TO AIR MISSILES:
		"PylonRack_1Rnd_Missile_AA_04_F"				FALCHION 22 X1
		"PylonRack_1Rnd_AAA_missiles"					ASRAAM X1
		"PylonRack_Missile_AMRAAM_C_x1"					AMRAAM C X1
		"PylonRack_Missile_AMRAAM_C_x2"					AMRAAM C X2
		"PylonMissile_Missile_AMRAAM_D_INT_x1"			AMRAAM D X1
		"PylonRack_Missile_AMRAAM_D_x2"					AMRAAM D X2
		"PylonRack_Missile_BIM9X_x2"					BIM9X X2
		"PylonMissile_Missile_BIM9X_x1"					BIM8X X1
		"PylonRack_1Rnd_Missile_AA_03_F"				SAHR-3
		"PylonMissile_Missile_AA_R73_x1"				R-73 X1
		"PylonMissile_Missile_AA_R77_x1"				R-77 X1
		"PylonRack_1Rnd_GAA_missiles"					ZYPHER X1

	ROCKETS:
		"PylonRack_12Rnd_missiles"						DAR ROCKETS X12
		"PylonRack_7Rnd_Rocket_04_HE_F"					SHRIEKER HE ROCKETS X7
		"PylonRack_7Rnd_Rocket_04_AP_F"					SHRIEKER AP ROCKETS X7
		"PylonRack_20Rnd_Rocket_03_HE_F"				TRATNYR HE ROCKETS X20
		"PylonRack_20Rnd_Rocket_03_AP_F"				TRATNYR AP ROCKETS X20
		"PylonRack_19Rnd_Rocket_Skyfire"				SKYFIRE X19

	 Guided BOMBS:
		"PylonMissile_1Rnd_Bomb_04_F"					GBU-12 GUIDED BOMB NATO X1
		"PylonMissile_1Rnd_Bomb_03_F"					LOM-250G GUIDED BOMB CSAT X1
		"PylonMissile_Bomb_GBU12_x1"					GBU-12 LASER GUIDIED BOMB X1
		"PylonRack_Bomb_GBU12_x2"						GBU-12 LASER GUIDED BOMB X2
		"PylonMissile_Bomb_KAB250_x1"					KAB250 GUIDED BOMB X1
	Dumb Bombs:
	"PylonMissile_1Rnd_Mk82_F"							MK-82 DUMB BOMB X1
	GUNS:
		"PylonWeapon_300Rnd_20mm_shells"				20mm TWIN CANNON
		"PylonWeapon_2000Rnd_65x39_belt"				6.5mm GATTLING GUN (RIGHT SIDE)

		NUMBER OF PYLONS:
			GREYHAWK/ABABIL: 2
			UCAV SENTINEL: 2
			MQ-12 FALCON: 2
			AH-6 PAWNEE: 2+2GUNS
			WY-55 HELLCAT: 2+2GUNS
			PO-30 ORCA: 2
			AH-99 BLACKFOOT: 6+MAIN CANNON
			Mi-48 KAJMAN 4
			A-143 BUZZARD: 7
			A-149 GRYPHON: 7+CANNON
			A-164 WIPEOUT 10+CANNON
			F/A-181 BLACK WASP II: 12+CANNON
			F/A-181 BLACK WASP II STEALTH: 8+CANNON
			To-199 NEOPHRON: 10+CANNON
			To-201 SHIKRA: 13+CANNON
			To-201 SHIKRA STEALTH: 7+CANNON
			Y-32 XI'AN: 4+MAIN CANNON
*/
switch (true) do
{
	// AH-9 Pawnee
	//(Gun-Only)
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeGun"):
	{
		_pylons = ["",""];
	};
	//20mm Cannons
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawnee20mm"):
	{
		_pylons = ["PylonWeapon_300Rnd_20mm_shells","PylonWeapon_300Rnd_20mm_shells"];
	};
	//DAR
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeDAR"):
	{
		_pylons = ["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"];
	};
	//SHRIEKER HE
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeS-HE"):
	{
		_pylons = ["PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_7Rnd_Rocket_04_HE_F"];
	};
	//SHRIEKER AP
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeS-AP"):
	{
		_pylons = ["PylonRack_7Rnd_Rocket_04_AP_F","PylonRack_7Rnd_Rocket_04_AP_F"];
	};
	//TRATNYR HE
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeT-HE"):
	{
		_pylons = ["PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_HE_F"];
	};
	//TRATNYR AP
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeT-AP"):
	{
		_pylons = ["PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_20Rnd_Rocket_03_AP_F"];
	};
	//SCALPEL X4
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeSCALX4"):
	{
		_pylons = ["PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel"];
	};
	//FLACHION
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F" && _variant == "pawneeFALCHION"):
	{
		_pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_Missile_AA_04_F"];
	};




	// PO-30 Orca (Unarmed)
	case (_class isKindOf "O_Heli_Light_02_dynamicLoadout_F" && _variant == "orcaUnArm"):
	{
		_pylons = ["",""];
	};
	// PO-30 Orca (Gun)
	case (_class isKindOf "O_Heli_Light_02_dynamicLoadout_F" && _variant == "orcaGUN"):
	{
		_pylons = ["PylonWeapon_2000Rnd_65x39_belt",""];
	};

	// PO-30 Orca (Gun+DAR)
	case (_class isKindOf "O_Heli_Light_02_dynamicLoadout_F" && _variant == "orcaGUNDAR"):
	{
		_pylons = ["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_missiles"];
	};

	// PO-30 Orca (GUN+DAGR)
	case (_class isKindOf "O_Heli_Light_02_dynamicLoadout_F" && _variant == "orcaGUNDAGR"):
	{
		_pylons = ["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_PG_missiles"];
	};



	// WY-55 HELLCAT (GUNS ONLY)
	case (_class isKindOf "I_Heli_light_03_dynamicLoadout_F" && _variant == "HellGun"):
	{
		_pylons = ["",""];
	};
	// WY-55 HELLCAT (GUNS + DAR)
	case (_class isKindOf "I_Heli_light_03_dynamicLoadout_F" && _variant == "HellDAR"):
	{
		_pylons = ["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"];
	};
	// WY-55 HELLCAT (GUNS + 20mm CANNONS)
	case (_class isKindOf "I_Heli_light_03_dynamicLoadout_F" && _variant == "Hell20mm"):
	{
		_pylons = ["PylonWeapon_300Rnd_20mm_shells","PylonWeapon_300Rnd_20mm_shells"];
	};
	// WY-55 HELLCAT (GUNS + DAGR)
	case (_class isKindOf "I_Heli_light_03_dynamicLoadout_F" && _variant == "HellDAGR"):
	{
		_pylons = ["PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_PG_missiles"];
	};
	// WY-55 HELLCAT (GUNS + LASER GUIDED BOMB)
	case (_class isKindOf "I_Heli_light_03_dynamicLoadout_F" && _variant == "HellBOMB"):
	{
		_pylons = ["PylonRack_Bomb_GBU12_x2","PylonRack_Bomb_GBU12_x2"];
	};




/*
	// AH-99 Blackfoot
	case (_class isKindOf "Heli_Attack_01_dynamicLoadout_base_F"):
	{
		_pylons = ["PylonMissile_1Rnd_AAA_missiles","PylonMissile_1Rnd_LG_scalpel","PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles","PylonMissile_1Rnd_LG_scalpel","PylonMissile_1Rnd_AAA_missiles"];
	};
*/


/*
	// Mi-48 Kajman
	case (_class isKindOf "Heli_Attack_02_dynamicLoadout_base_F"):
	{
		_pylons = ["PylonMissile_1Rnd_LG_scalpel","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_19Rnd_Rocket_Skyfire","PylonMissile_1Rnd_LG_scalpel"];
	};
*/


/*
	// Y-32 Xi'an
	case ({_class isKindOf _x} count ["VTOL_02_infantry_dynamicLoadout_base_F", "VTOL_02_vehicle_dynamicLoadout_base_F"] > 0):
	{
		_pylons = ["PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AGM_01_F"];
	};
*/



	// A-143 Buzzard AA
	case (_class isKindOf "Plane_Fighter_03_dynamicLoadout_base_F" && _variant == "buzzardAA"):
	{
		_pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_GAA_missiles","PylonRack_1Rnd_GAA_missiles","PylonWeapon_300Rnd_20mm_shells","PylonRack_1Rnd_GAA_missiles","PylonRack_1Rnd_GAA_missiles","PylonRack_1Rnd_Missile_AA_04_F"];
		_customCode =
		{
			_veh setAmmoOnPylon [4, 500]; // 20mm gun
		};
	};
	// A-143 Buzzard CAS
	case (_class isKindOf "Plane_Fighter_03_dynamicLoadout_base_F" && _variant == "buzzardCAS"):
	{
		_pylons = ["PylonRack_1Rnd_LG_scalpel","PylonRack_1Rnd_Missile_AA_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonWeapon_300Rnd_20mm_shells","PylonMissile_1Rnd_Bomb_04_F","PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_LG_scalpel"];
		_customCode =
		{
			_veh setAmmoOnPylon [4, 500]; // 20mm gun
		};
	};



/*
	// A-149 Gryphon
	case (_class isKindOf "Plane_Fighter_04_Base_F"):
	{
		_mags =
		[
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]], // extra gun mags (non-explosive ammo)
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1"];
	};
*/


/*
	// F/A-181 Black Wasp
	case (_class isKindOf "B_Plane_Fighter_01_F"):
	{
		_mags =
		[
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]], // extra gun mag (non-explosive ammo)
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_7Rnd_Rocket_04_AP_F","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
	};
*/


/*
	// F/A-181 Black Wasp (Stealth)
	case (_class isKindOf "B_Plane_Fighter_01_Stealth_F"):
	{
		_mags =
		[
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]], // extra gun mags to make up for lack of pylons (non-explosive ammo)
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["","","","","","","","","","","",""];
	};
*/


/*
	// To-201 Shikra
	case (_class isKindOf "O_Plane_Fighter_02_F"):
	{
		_mags =
		[
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]], // extra gun mag (non-explosive ammo)
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Bomb_KAB250_x1"];
	};
*/


/*
	// To-201 Shikra (Stealth)
	case (_class isKindOf "O_Plane_Fighter_02_Stealth_F"):
	{
		_mags =
		[
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]], // extra gun mags to make up for lack of pylons (non-explosive ammo)
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["","","","","","","","","","","","",""];
	};
*/



	/*// A-164 Wipeout CAS
	case (_class isKindOf "Plane_CAS_01_dynamicLoadout_base_F"):
	{
		_pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_Missile_AGM_02_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_7Rnd_Rocket_04_AP_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonRack_1Rnd_Missile_AGM_02_F","PylonRack_1Rnd_Missile_AA_04_F"];
	};*/




	/*// To-199 Neophron CAS
	case (_class isKindOf "Plane_CAS_02_dynamicLoadout_base_F"):
	{
		_pylons = ["PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonMissile_1Rnd_Bomb_03_F","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonMissile_1Rnd_Bomb_03_F","PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_1Rnd_Missile_AA_03_F","PylonRack_1Rnd_Missile_AA_03_F"];
	};*/



	// Greyhawk/Ababil Missile UAVs
	case (_class isKindOf "UAV_02_dynamicLoadout_base_F" && _variant == "greyhawkRecon"):
	{
		_pylons = ["",""];
	};
	// Greyhawk/Ababil Missile UAVs
	case (_class isKindOf "UAV_02_dynamicLoadout_base_F" && _variant == "greyhawkMissile"):
	{
		_pylons = ["PylonRack_3Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel"];
	};
	// Greyhawk/Ababil Bomber UAVs
	case (_class isKindOf "UAV_02_dynamicLoadout_base_F" && _variant == "greyhawkBomber"):
	{
		_pylons = ["PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F"];

	};




	// UCAV Sentinel Missile
	case (_class isKindOf "B_UAV_05_F" && _variant == "sentinelMissile"):
	{
		_pylons = ["PylonMissile_Missile_AGM_02_x2","PylonMissile_Missile_AGM_02_x2"];
	};

	// UCAV Sentinel Bomber
	case (_class isKindOf "B_UAV_05_F" && _variant == "sentinelBomber"):
	{
		_pylons = ["PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
	};




	/*// MQ-12 Falcon UAV (non-dynamicLoadout)
	case (_class isKindOf "B_T_UAV_03_F"):
	{
		_mags =
		[
			["120Rnd_CMFlare_Chaff_Magazine", [-1]],
			["1000Rnd_65x39_Belt_Green", [0]],
			["24Rnd_missiles", [0]],
			["2Rnd_LG_scalpel", [0]],
			["2Rnd_AAA_missiles", [0]],
			["Laserbatteries", [0]]
		];
		_weapons =
		[
			["CMFlareLauncher", [-1]],
			["LMG_M200", [0]],
			["missiles_DAR", [0]],
			["missiles_SCALPEL", [0]],
			["missiles_ASRAAM", [0]],
			["Laserdesignator_mounted", [0]]
		];
	};*/
};
