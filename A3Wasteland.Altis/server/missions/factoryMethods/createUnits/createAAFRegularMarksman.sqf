// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createAAFRegular.sqf
/*
 * Creates a random AFF Regular rifleman.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    init: String - (optional, default "") Command to be executed upon creation of unit. Parameter this is set to the created unit and passed to the code.
 *    skill: Number - (optional, default 0.5)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};
private _group = _this select 0;
private _position = _this select 1;

/***************************************************** Configuration Stuff Goes Here ************************************************************************************************************************/
private _soldierTypes = selectrandom ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
//Soldier Gear
	private _uniformTypes = selectrandom 
	[ 
		"U_I_CombatUniform",
		"U_I_CombatUniform_shortsleeve",
		"U_I_GhillieSuit"
	];
	private _vestTypes = selectrandom 
	[
		"V_Chestrig_oli",
		"V_Chestrig_rgr"
	];
	private _BackpackTypes = selectrandom
	[
		"",
		"B_AssaultPack_rgr",
		"B_Kitbag_rgr",
		"B_TacticalPack_rgr",
		"B_TacticalPack_oli",
		"B_Carryall_oli"

	];
	private _weaponTypesRifle = selectrandom 
	[
		"arifle_MXM_F",
		"srifle_DMR_01_F",
		"srifle_EBR_F"
	];
	private _weaponTypesLauncher = selectrandom 
	[
		""
	];
	private _weaponTypesPistor = selectrandom 
	[
		""
	];
	private _weaponSight = selectrandom 
	[
		"optic_SOS",
		"optic_SOS_khk_F",
		"optic_DMS",
		"optic_DMS_ghex_F",
		"optic_KHS_old",
		"optic_KHS_blk",
		"optic_KHS_hex",
		"optic_KHS_tan",
		"optic_AMS",
		"optic_AMS_khk",
		"optic_AMS_snd",
		"optic_LRPS",
		"optic_LRPS_ghex_F",
		"optic_LRPS_tna_F",
		"optic_NVS"
	];
	private _weaponsRail = selectrandom 
	[
		"",
		"acc_pointer_IR"
	];
	private _weaponsBipod = selectrandom 
	[
		"bipod_03_F_blk",
		"bipod_03_F_oli",
		"bipod_01_F_snd",
		"bipod_02_F_tan",
		"bipod_01_F_khk"
	];
	private _weaponsMuzzle = selectrandom 
	[
		""
	];
	private _BinocularTypes = selectrandom 
	[
		"Rangefinder"
	];
	private _TerminalTypes = selectRandom 
	[
		"",
		"ItemGPS"
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
		"FirstAidKit"
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
	private _rank = "PRIVATE"; //  PRIVATE, CORPORAL, SERGEANT, LIEUTENANT, CAPTAIN, MAJOR or COLONEL
	//Soldier Skills are set from 0 to 1; 
	private _Accuracy = 0.2; //Soldier accuracy;
	private _Courage = 0.2; //Affects unit's subordinates' morale (Higher value = more courage)
	private _aimingShake = 0.2; //Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)
	private _aimingSpeed = 0.2; //Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)
	private _spotDistance = 0.2; //Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
	private _spotTime = 0.2; //Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
	private _reloadSpeed = 0.2; //Affects the delay between switching or reloading a weapon (Higher value = less delay)
	private _commanding = 0.2; //Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)	
/**************************************************************************************************************************************************************************************************************/


private _soldier = _group createUnit [_soldierTypes, _position, [], 0, "NONE"];

//Give soldier a uniform
	_soldier addUniform (_uniformTypes);
//Give Soldier a Vest
	_soldier addVest (_vestTypes);
//Maybe give the soldier a backpack
	if (_BackpackTypes != "") then
	{
		_soldier addBackpack _BackpackTypes;
	};
//Maybe Give the Soldier a weapon
	if (_weaponTypesRifle != "") then
	{
		[_soldier, _weaponTypesRifle, 3] call BIS_fnc_addWeapon;
	};
//Maybe give the soldier a Launcher
	if (_weaponTypesLauncher != "") then
	{
		[_soldier, _weaponTypesLauncher, 3] call BIS_fnc_addWeapon;
	};
//Maybe give the soldier a pistol
	if (_weaponTypesPistor != "") then
	{
		[_soldier, _weaponTypesPistor, 3] call BIS_fnc_addWeapon;
	};
//Maybe give the soldier some gun bling
	if (_weaponSight != "") then
	{
		_soldier addPrimaryWeaponItem _weaponSight;
	};
	if (_weaponsRail != "") then
	{
		_soldier addPrimaryWeaponItem _weaponsRail;
	};
	if (_weaponsBipod != "") then
	{
		_soldier addPrimaryWeaponItem _weaponsBipod;
	};
	if (_weaponsMuzzle != "") then
	{
		_soldier addPrimaryWeaponItem _weaponsMuzzle;
	};
//Maybe give the soldier some binoculars
	if (_BinocularTypes != "") then
	{
		_soldier additem _BinocularTypes;
		_soldier linkitem _BinocularTypes;
	};
//Give the soldier a hat
	_soldier addHeadgear _headgear;
//Maybe give the soldier some glasses
	if (_faceItems != "") then
	{
		_soldier additem _faceItems;
		_soldier linkItem _faceItems;
	};
//Give the soldier some stuff
	for "_i" from 1 to 10 do
	{
		private _item = selectrandom _itemsList;
		if (_item != "") then
		{
			_soldier additem _item;
		};
	};
//Maybe give the soldier a GPS or UAV Terminal
	if (_TerminalTypes != "") then
	{
		_soldier additem _TerminalTypes;
		_soldier linkitem _TerminalTypes;
	};
//Set the Soldiers rank and Skills
	_soldier setRank _rank;
	_soldier allowFleeing 1;
	_soldier setSkill ["aimingAccuracy", _Accuracy];
	_soldier setSkill ["courage", _Courage];
	_soldier setskill ["aimingShake", _aimingShake];
	_soldier setskill ["aimingSpeed", _aimingSpeed];
	_soldier setskill ["spotDistance", _spotDistance];
	_soldier setskill ["spotTime", _spotTime];
	_soldier setskill ["commanding", _commanding];
	_soldier setskill ["reloadSpeed", _reloadSpeed];




//Finish up
	_soldier triggerDynamicSimulation true;
	_soldier addEventHandler ["Killed", server_playerDied];
	_soldier
