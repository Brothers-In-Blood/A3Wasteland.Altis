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
_TargetClass = typeOf _TargetClass;
_uniform =  uniform _Target;
_backpack = backpack _Target;
_vest = vest _Target;
_headgear = headgear _Target;
_goggles = goggles _Target;
_items = assigneditems _Target;
_mags = magazines _Target;

//Player Equipment
_playeruniform =  uniform player;
_playerbackpack = backpack player;
_playervest = vest player;
_playerheadgear = headgear player;
_playergoggles = goggles player;
_playeritems = assigneditems player;
_playermags = magazines player;
_playerweapons = weapons player;




if (isNull _Target) exitWith {};

_checks =
{
  private ["_progress", "_object", "_failed", "_text"];
  _progress = _this select 0;
  _object = _this select 1;
  _failed = true;

  switch (true) do
  {
    case (!alive player): { _text = "" };
    case (vehicle player != player): { _text = "Action failed! You can't do this in a vehicle" };
    case (player distance _object > (sizeOf typeOf _object / 3) max 2): { _text = "Action failed! You are too far away from the body" };
    case (isNull _object): { _text = "The body no longer exists" };
    case (alive _object || {alive _x} count crew _object > 0): { _text = "You Can't do that" };
    case (doCancelAction): { doCancelAction = false; _text = "Takig gear cancelled" };
    default
    {
      _failed = false;
      _text = format ["Taking gear %1%2 complete", floor (_progress * 100), "%"];
    };
  };

  [_failed, _text];
};

_firstCheck = [0, _Target] call _checks;

if (_firstCheck select 0) exitWith
{
  [_firstCheck select 1, 5] call mf_notify_client;
};

mutexScriptInProgress = true;

// Salvage time and default money reward according to vehicle type
switch (true) do
{
  case (_TargetClass isKindOf "Man"):
  {
    _time = 15;
    player forceAddUniform _uniform;
    removeAllWeapons _Target;
    removeAllAssignedItems _Target;*/
    removeUniform _Target;
    removeVest _Target;
    removeBackpack _Target;
    removeGoggles _Target;
    removeHeadgear _Target;
    _ground = "GroundWeaponHolder" createVehicle position player;
    player action ["PutBag"];
    player action ["DropWeapon", _ground, _x] forEach _playerweapons;
    player action ["DropMagazine", _ground, _x] forEach _playermags;
  };
  default  {}; // Everything else
};

mutexScriptInProgress = true;

_success = [_time, format ["AinvPknlMstpSlayW%1Dnon_medic", [player, true] call getMoveWeapon], _checks, [_Target]] call a3w_actions_start;

mutexScriptInProgress = false;

if (_success) then
{
  /*[format ["Finished Taking Gear"]] call mf_notify_client;*/
};
