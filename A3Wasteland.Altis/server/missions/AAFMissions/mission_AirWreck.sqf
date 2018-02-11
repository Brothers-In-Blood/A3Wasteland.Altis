// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, BIB_Monkey
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf"

private _wreckPos = "";
private _wreck = "";
private _box1 = "" ;
private _box2 = "" ;
private _MissionDifficulty = selectrandom ["Regular"]; // "Veteran", "SpecialForces"
private _loottypes = 
[
	"mission_USLaunchers",
	"mission_USSpecial",
	"Launchers_Tier_2",
	"Diving_Gear",
	"General_supplies",
	"GEVP",
	"Ammo_Drop",
	"mission_AALauncher",
	"mission_CompactLauncher",
	"mission_snipers",
	"mission_RPG",
	"mission_Pistols",
	"mission_AssRifles",
	"mission_SMGs",
	"mission_LMGs",
	"Medical",
	"mission_Field_Engineer"
];

_setupVars =
{
	_missionType = "AAF Aircraft Wreck";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_wreckPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);

	// Class, Position, Fuel, Ammo, Damage, Special
	_wreckTypes = selectrandom ["I_Heli_light_03_dynamicLoadout_F","I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F"];
	_wreck = [_wreckTypes, _wreckPos, 0, 0, 1] call createMissionVehicle;

	_box1 = createVehicle ["Box_NATO_WpsSpecial_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	private _box1Loot = selectrandom _loottypes;
	[_box1, _box1Loot] call fn_refillbox;
	

	_box2 = createVehicle ["Box_East_WpsSpecial_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	private _box2Loot = selectrandom _loottypes;
	[_box2, _box2Loot] call fn_refillbox;

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	_aiGroup = createGroup CIVILIAN;
	for "_i" from 1 to 10 do
	{
		[_aiGroup, _missionPos] call createAAFRegularRifleman;
	};
	

	_missionPicture = getText (configFile >> "CfgVehicles" >> typeOf _wreck >> "picture");
	_missionHintText = "A helicopter has come down under enemy fire!";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _wreck];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	{ _x setVariable ["Moveable", true, true] } forEach [_box1, _box2];
	private _money = ceil (random 10000);
	_box1 setVariable ["cmoney", _money, true];

	_successHintMessage = "The airwreck supplies have been collected, well done.";
};

_this call AAFMissionProcessor;
