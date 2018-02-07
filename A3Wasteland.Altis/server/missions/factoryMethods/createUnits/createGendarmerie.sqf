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

private _soldierTypes = selectrandom ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
private _uniformTypes = selectrandom ["U_B_GEN_Soldier_F"];
private _vestTypes = selectrandom ["V_TacVest_gen_F"];
private _weaponTypes = selectrandom ["SMG_05_F"];
private _weaponitem = selectrandom ["optic_ACO_grn"];
private _face  = selectrandom ["TanoanHead_A3_03", "TanoanHead_A3_07", "TanoanHead_A3_06", "TanoanHead_A3_05", "TanoanHead_A3_06", "TanoanHead_A3_02"];
private _voice = selectrandom ["Male02FRE", "Male01FRE", "Male02ENGFRE", "Male01ENGFRE"];

private _group = _this select 0;
private _position = _this select 1;
private _rank = param [2, "", [""]];

private _soldier = _group createUnit [_soldierTypes, _position, [], 0, "NONE"];
_soldier addUniform (_uniformTypes);
_soldier addVest (_vestTypes);
[_soldier, _weaponTypes, 3] call BIS_fnc_addWeapon;
_soldier addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_soldier addItemToUniform "30Rnd_9x21_Mag_SMG_02";};
for "_i" from 1 to 3 do {_soldier addItemToVest "30Rnd_9x21_Mag_SMG_02";};
for "_i" from 1 to 2 do {_soldier addItemToVest "16Rnd_9x21_Mag";};
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
