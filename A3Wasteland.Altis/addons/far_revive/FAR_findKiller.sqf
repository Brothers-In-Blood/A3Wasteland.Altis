// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: FAR_findKiller.sqf
//	@file Author: AgentRev

private _target = _this;
private _killer = _target getVariable ["FAR_killerUnit", objNull];

if (_killer == _target) exitWith { objNull }; // Suicide
if (_killer isKindOf "Man") exitWith { _killer }; // Killed by infantry
if (_killer == _target) exitWith { objNull }; // Indirect suicide
_killer
