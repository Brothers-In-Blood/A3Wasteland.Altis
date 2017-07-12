// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: basePartSetup.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

private "_obj";
_obj = _this select 0;

_obj setVariable [call vChecksum, true];
//Make base objects much harder to kill
_obj addMPEventHandler ["HandleDamage", {false}];
_obj addMPEventHandler ["Hit", {_obj setDamage 0}];
