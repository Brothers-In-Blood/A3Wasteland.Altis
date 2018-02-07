// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createGenarmarie.sqf
/*
 * Creates a random civilian Police.
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
private _soldierTypes = selectrandom ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
private _uniformTypes = selectrandom [ "U_I_CombatUniform", "U_I_CombatUniform_shortsleeve"];
private _vestTypes = selectrandom ["V_Chestrig_oli"];
private _BackpackTypes = [""];
private _weaponTypesRifle = selectrandom ["arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_Katiba_C_F", "arifle_Katiba_F", "arifle_Katiba_GL_F", "arifle_MXC_F", "arifle_MX_F" ];
private _weaponTypesLauncher = selectrandom [""];
private _weaponTypesPistor = selectrandom [""];
private _weaponSight = selectrandom ["", "optic_ACO_grn"];
private _weaponsRail = selectrandom [""];
private _weaponsBipod = selectrandom [""];
private _weaponsMuzzle = selectrandom [""];
private _headgear = selectrandom ["H_MilCap_dgtl"]
private _faceItems = selectRandom ["", "G_Aviator", "G_Combat", "G_Lady_Red", "G_Lady_Mirror", "G_Lady_Dark", "G_Lady_Blue", "G_Lowprofile", "G_Shades_Black", "G_Shades_Blue", "G_Shades_Green", "G_Shades_Red", "G_Spectacles", "G_Sport_Red", "G_Sport_Blackyellow", "G_Sport_BlackWhite", "G_Sport_Checkered", "G_Sport_Blackred", "G_Sport_Greenblack", "G_Squares_Tinted", "G_Squares", "G_Tactical_Clear", "G_Tactical_Clear", "G_Tactical_Black", "G_Spectacles_Tinted"];
private _rank = param [2, "", [""]];
private _soldier = _group createUnit [_soldierTypes, _position, [], 0, "NONE"];
_soldier addUniform (_uniformTypes);
_soldier addVest (_vestTypes);
if !(_BackpackTypes == "") then
{
	_soldier addBackpack _BackpackTypes;
};
if !(_weaponTypesRifle == "") then
{
	[_soldier, _weaponTypesRifle, 3] call BIS_fnc_addWeapon;
};
if !(_weaponTypesLauncher == "") then
{
	[_soldier, _weaponTypesLauncher, 3] call BIS_fnc_addWeapon;
};

[_soldier, _weaponTypesRifle, 3] call BIS_fnc_addWeapon;
_soldier addItemToUniform "FirstAidKit";
_soldier addWeapon "hgun_Pistol_01_F";
_soldier addItemToVest "HandGrenade";
_soldier addItemToVest "SmokeShell";
_soldier addHeadgear "H_MilCap_gen_F";
if (_rank != "") then
{
	_soldier setRank _rank;
};
_soldier call setMissionSkill;
_soldier triggerDynamicSimulation true;
_soldier addEventHandler ["Killed", server_playerDied];
_soldier
