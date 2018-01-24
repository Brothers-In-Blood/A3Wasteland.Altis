// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: deploy.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Deploy a Spawn Beacon
//@file Argument: [player, player, _action, []] the standard "called by an action" values

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_TOO_CLOSE "Another owned beacon too close"
#define ERR_IN_VEHICLE "Action Failed! You can't do this in a vehicle"

private _PosPlayer = getPos player;
private _uid = getPlayerUID player;
private _CloseBeacons = nearestObjects [player, ["Land_PlasticCase_01_small_F"], 1000, true];
private _TooClose = false;
{
	if (_x getvariable ["ownerUID", ""] == _uid) then {_TooClose = true};
} foreach _CloseBeacons;


private _hasFailed = 
{
	private _progress = _this select 0;
	private _failed = true;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction) :{doCancelAction = false; _text = ERR_CANCELLED;};
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (_TooClose): {_text = ERR_TOO_CLOSE};
		default {
			_text = format["Spawn Beacon %1%2 Deployed", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};
private _success = [MF_ITEMS_SPAWN_BEACON_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {

	// Spawn 2m in front of the player
	private _beacon = createVehicle [MF_ITEMS_SPAWN_BEACON_DEPLOYED_TYPE, [player, [0,2,0]] call relativePos, [], 0, "NONE"];
	_beacon setDir (getDir player + 270);
	_beacon setVariable ["allowDamage", true, true];
	_beacon setVariable ["a3w_spawnBeacon", true, true];
	_beacon setVariable ["R3F_LOG_disabled", true];
	_beacon setVariable ["side", playerSide, true];
	_beacon setVariable ["ownerName", name player, true];
	_beacon setVariable ["ownerUID", _uid, true];
	_beacon setVariable ["packing", false, true];
	_beacon setVariable ["groupOnly", (playerSide == INDEPENDENT), true];
	pvar_spawn_beacons pushBack _beacon;
	publicVariable "pvar_spawn_beacons";
	pvar_manualObjectSave = netId _beacon;
	publicVariableServer "pvar_manualObjectSave";
	["You placed the Spawn Beacon successfully!", 5] call mf_notify_client;
};
_success;

