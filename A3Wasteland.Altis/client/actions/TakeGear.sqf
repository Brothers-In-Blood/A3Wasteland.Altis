/***************************
File Name: TakeGear.sqf
File Author: BIB_Monkey
File Created: 18 MAR 2017
File Description: Removes Gear from corpse and adds it to player
***************************/

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith
{
	["You are already performing another action.", 5] call mf_notify_client;
};

private ["_Target", "_TargetClass", "_checks", "_firstCheck", "_time", "_money", "_success", "_loudout"];

//Target Equipment
_Target = cursorTarget;
_TargetClass = typeOf _Target;
_uniform = uniform _Target;
_backpack = backpack _Target;
_vest = vest _Target;
_headgear = headgear _Target;
_goggles = goggles _Target;
_items = assigneditems _Target;
_mags = magazines _Target;

//Player Equipment
_playeruniform = uniform player;
_playerbackpack = backpack player;
_playervest = vest player;
_playerheadgear = headgear player;
_playergoggles = goggles player;
_playeritems = assigneditems player;
_playermags = magazines player;
_playerweapons = weapons player;

if (_target getvariable ["takegear", false]) exitwith 
{
	titletext ["Someone else is taking this gear", "PLAINDOWN"];
};

switch (true) do
{
	case (_TargetClass isKindOf "Man"):
	{
		_time = 15;
		_target setvariable ["takegear", true, true];
	};
	default	{}; // Everything else
};

mutexScriptInProgress = true;

_success = [_time, format ["AinvPknlMstpSlayW%1Dnon_medic", [player, true] call getMoveWeapon], _checks, [_Target]] call a3w_actions_start;


mutexScriptInProgress = false;

if (_success) then
{
	player action ["PutBag"];
	removeUniform _target;
	removevest _target;
	removeBackpack _target;
	{_target removeItem _x} foreach _items;
	{_target removeItem _x} foreach _mags;
	player forceAddUniform _uniform;
	player assignItem _vest;
	player assignitem _backpack;
	player assignitem _headgear;
	player assignitem _goggles;
	{player assignitem _x} foreach _items;
	{player additem _x} foreach _mags;
};
