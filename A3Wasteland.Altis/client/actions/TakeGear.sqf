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

//Target Equipment
_Target = cursorTarget;
_TargetClass = typeOf _Target;
_uniform = uniform _Target;
_uniformItems = uniformItems _target;
_backpack = backpack _Target;
_backpackItems = backpackItems _target;
_vest = vest _Target;
_vestitems = vestItems _Target;
_headgear = headgear _Target;
_goggles = goggles _Target;
_items = assigneditems _Target;
_mags = magazines _Target;

//Player Equipment
_playeruniform = uniform player;
_playerUniformItems = uniformItems player;
_playervest = vest player;
_playervestItems = vestItems player;
_playerheadgear = headgear player;
_playergoggles = goggles player;
_playeritems = assigneditems player;
_playermags = magazines player;
_playerweapons = weapons player;
_time = 15;

if (_target getvariable ["takegear", false]) exitwith 
{
	titletext ["Someone else is taking this gear", "PLAIN DOWN"];
};

mutexScriptInProgress = true;
titleText ["Shoving crap into backpack", "PLAIN DOWN"];
{player addItemToBackpack _x} foreach _playerUniformItems;
{player addItemToBackpack _x} foreach _playervestItems;
player additemtobackpack _playergoggles;
player additemtobackpack _playerheadgear;
player addItemToBackpack _playeruniform;
player action ["PutBag"];
sleep 5;
titleText ["Stripping Corpse", "PLAIN DOWN"];
removeUniform _target;
removevest _target;
removeBackpack _target;
removeHeadgear _target;
removeAllItems _target;
sleep 5;
titletext ["Wearing a deadmans clothes", "PLAIN DOWN"];
player forceAddUniform _uniform;
{player addItemToUniform _x} foreach _uniformItems;
player addVest _vest;
{player addItemToVest _x} foreach _vestitems;
player addBackpack _backpack;
{player addItemToBackpack _x} foreach _backpackItems;
player addHeadgear _headgear;
player addGoggles _goggles;
sleep 5;
// {player additem _x} foreach _mags;
_target setvariable ["takegear", false, true];
titletext ["All done", "PLAIN DOWN"];

mutexScriptInProgress = false;
