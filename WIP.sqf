/***************************************************** Configuration Stuff Goes Here ************************************************************************************************************************/
private _soldierTypes = selectrandom ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
//Soldier Gear
	private _uniformTypes = selectrandom 
	[ 
		"U_I_CombatUniform",
		"U_I_CombatUniform_shortsleeve"
	];
	private _vestTypes = selectrandom 
	[
		"V_Chestrig_oli",
		"V_Chestrig_rgr"
	];
	private _BackpackTypes = 
	[
		"B_AssaultPack_rgr",
		"B_Kitbag_rgr",
		"B_TacticalPack_rgr",
		"B_TacticalPack_oli",
		"B_Carryall_oli"
	];
	private _weaponTypesRifle = selectrandom 
	[
		"arifle_TRG20_F",
		"arifle_TRG21_F"	
	];
	private _weaponTypesLauncher = selectrandom 
	[
		"launch_NLAW_F",
		"launch_I_Titan_short_F"
	];
	private _weaponTypesPistor = selectrandom 
	[
		""
	];
	private _weaponSight = selectrandom 
	[
		"", 
		"optic_Aco",
		"optic_Aco_grn",
		"optic_Holosight",
	];
	private _weaponsRail = selectrandom 
	[
		""
	];
	private _weaponsBipod = selectrandom 
	[
		""
	];
	private _weaponsMuzzle = selectrandom 
	[
		""
	];
	private _BinocularTypes = selectrandom 
	[
		"",
		"Binocular"
	];
	private _TerminalTypes = selectRandom 
	[
		""

	];
	private _itemsList = 
	[
		"",
		"SmokeShellBlue",
		"SmokeShellGreen",
		"SmokeShellOrange",	
		"SmokeShellPurple",
		"SmokeShellRed",
		"SmokeShell",
		"SmokeShellYellow",	
		"Chemlight_blue",
		"Chemlight_green",
		"Chemlight_red",
		"Chemlight_yellow",
		"FirstAidKit",
		"B_IR_Grenade",
		"I_IR_Grenade",	
		"O_IR_Grenade",	
		"Medikit",
		"ToolKit"	
	];
	private _headgear = selectrandom 
	[
		"H_MilCap_dgtl",
		"H_HelmetIA"
	];
	private _faceItems = selectRandom 
	[
		"", 
		"G_Aviator", 
		"G_Combat", 
		"G_Lady_Red", 
		"G_Lady_Mirror", 
		"G_Lady_Dark", 
		"G_Lady_Blue", 
		"G_Lowprofile", 
		"G_Shades_Black", 
		"G_Shades_Blue", 
		"G_Shades_Green", 
		"G_Shades_Red", 
		"G_Spectacles", 
		"G_Sport_Red", 
		"G_Sport_Blackyellow", 
		"G_Sport_BlackWhite", 
		"G_Sport_Checkered", 
		"G_Sport_Blackred", 
		"G_Sport_Greenblack", 
		"G_Squares_Tinted", 
		"G_Squares", 
		"G_Tactical_Clear", 
		"G_Tactical_Clear", 
		"G_Tactical_Black", 
		"G_Spectacles_Tinted"
	];
//Soldier Skill and Attributes
	private _allowFleeing = 1; // can the unit flee? 0 = no 1 = yes
	private _rank = "CORPORAL"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
	//Soldier Skills are set from 0 to 1; 
	private _Accuracy = 0.4; //Soldier accuracy;
	private _Courage = 0.4; //Affects unit's subordinates' morale (Higher value = more courage)
	private _aimingShake = 0.4; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
	private _aimingSpeed = 0.4; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
	private _spotDistance = 0.4; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
	private _spotTime = 0.4; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
	private _reloadSpeed = 0.4; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
	private _commanding = 0.4; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
/**************************************************************************************************************************************************************************************************************/
comment "Exported from Arsenal by Monkey";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_I_CombatUniform_shortsleeve";
this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {this addItemToUniform "9Rnd_45ACP_Mag";};
this addItemToUniform "HandGrenade";
this addItemToUniform "SmokeShell";
this addVest "V_PlateCarrierIA2_dgtl";
for "_i" from 1 to 2 do {this addItemToVest "200Rnd_65x39_cased_Box";};
this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {this addItemToVest "Chemlight_green";};
this addHeadgear "H_HelmetIA_camo";

comment "Add weapons";
this addWeapon "LMG_Mk200_F";
this addPrimaryWeaponItem "acc_pointer_IR";
this addPrimaryWeaponItem "bipod_03_F_blk";
this addWeapon "hgun_ACPC2_F";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "NVGoggles_INDEP";

comment "Set identity";
this setFace "GreekHead_A3_07";
this setSpeaker "male02gre";
