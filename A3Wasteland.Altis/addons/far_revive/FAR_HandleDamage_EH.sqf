// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: FAR_HandleDamage_EH.sqf
//	@file Author: Farooq, AgentRev

#include "FAR_defines.sqf"
#include "gui_defines.hpp"
params ["_unit", "", "", "_source", "_ammo", "", "_instigator"];

// a critical hit is if this type of selection can trigger death upon suffering damage >= 1 (usually all of them except "hands", "arms", and "legs")
// this is intercepted to prevent engine-triggered death and put the unit in revive mode instead; behavior and selections can change with game updates
_criticalHit = (_selection in ["","body","head","spine1","spine2","spine3","pelvis","neck","face_hub"]);
_fatalHit = (_damage >= 1 && alive _unit && _criticalHit);

// Find suspects
if (_fatalHit && (!isNull _source || !isNull _instigator) && isNil {_unit getVariable "FAR_killerUnit"}) then
{
	[_unit, _source, _ammo, _instigator] call FAR_setKillerInfo;
};

_reviveReady = _unit getVariable ["FAR_reviveModeReady", false];
_skipRevive = false;

if (UNCONSCIOUS(_unit) && !_skipRevive) then
{
	if (!_reviveReady) exitWith { _damage = 0.5 }; // block additional damage while transitioning to revive mode; allowDamage false prevents proper tracking of lethal headshots
	_oldDamage = if (_selection == "") then { damage _unit } else { _unit getHit _selection };
	if (!isNil "_oldDamage") then
	{
		// Apply part of the damage without multiplier when below the stabilization threshold of 50% damage
		if (_criticalHit && {STABILIZED(_unit) && FAR_DamageMultiplier < 1}) then
		{
			_oldDamage = _damage min 0.5;
		};
		_damage = ((_damage - _oldDamage) * FAR_DamageMultiplier) min 0.2 + _oldDamage; // max damage inflicted per hit is capped (via min 0.2) to prevent insta-bleedout - 0.2 is 40% of 0.5
	};
}
else
{
	// Allow revive if unit is dead and not in exploded vehicle
	if (_fatalHit && alive vehicle _unit) then
	{
		if (_unit == player && !isNil "fn_deletePlayerData") then { call fn_deletePlayerData };
		if (!_skipRevive) then
		{
			_unit setVariable ["FAR_isUnconscious", 1, true];
			_unit setFatigue 1;
		};
		terminate (_unit getVariable ["FAR_Player_Unconscious_thread", scriptNull]);
		if (_unit == player) then
		{
			(findDisplay ReviveBlankGUI_IDD) closeDisplay 0;
			(uiNamespace getVariable ["ReviveGUI", displayNull]) closeDisplay 0;
		};
		if (_skipRevive) exitWith {};
		_unit setVariable ["FAR_Player_Unconscious_thread", [_unit, _source] spawn FAR_Player_Unconscious];
		if (_unit == player) then
		{
			true call mf_inventory_list;
		};
		_damage = 0.5;
	};
};