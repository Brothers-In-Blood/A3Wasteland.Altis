// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createRandomSoldier.sqf
/*
 * Creates a random civilian soldier.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    init: String - (optional, default "") Command to be executed upon creation of unit. Parameter this is set to the created unit and passed to the code.
 *    skill: Number - (optional, default 0.5)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private _soldierTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
private _uniformTypes = ["U_O_V_Soldier_Viper_F"];
private _vestTypes = ["V_HarnessO_ghex_F"];
private _weaponTypes = ["arifle_ARX_ghex_F"];

private _group = _this select 0;
private _position = _this select 1;
private _rank = param [2, "", [""]];

private _soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
_soldier addUniform (_uniformTypes call BIS_fnc_selectRandom);
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);
[_soldier, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;
_soldier addItemToUniform "FirstAidKit";
_soldier addBackpack "B_ViperHarness_ghex_Medic_F";
_soldier addItemToBackpack "Medikit";
_soldier addItemToBackpack "SmokeShellYellow";
_soldier addItemToBackpack "SmokeShellOrange";
_soldier addHeadgear "H_HelmetO_ViperSP_ghex_F";
_soldier addWeapon "arifle_ARX_ghex_F";
_soldier addPrimaryWeaponItem "muzzle_snds_65_TI_ghex_F";
_soldier addPrimaryWeaponItem "acc_pointer_IR";
_soldier addPrimaryWeaponItem "optic_ACO_grn";
_soldier addWeapon "hgun_Rook40_F";
_soldier addHandgunItem "muzzle_snds_L";
_soldier setFace "AsianHead_A3_06";
_soldier setSpeaker "Male02CHI";
for "_i" from 1 to 10 do {_soldier addItemToBackpack "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 4 do {_soldier addItemToBackpack "10Rnd_50BW_Mag_F";};
for "_i" from 1 to 4 do {_soldier addItemToBackpack "16Rnd_9x21_Mag";};
for "_i" from 1 to 4 do {_soldier addItemToBackpack "MiniGrenade";};
for "_i" from 1 to 2 do {_soldier addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {_soldier addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 2 do {_soldier addItemToUniform "Chemlight_red";};

if (_rank != "") then
{
	_soldier setRank _rank;
};

_soldier spawn refillPrimaryAmmo;
_soldier call setMissionSkill;
_soldier triggerDynamicSimulation true;
_soldier addEventHandler ["Killed", server_playerDied];

_soldier
