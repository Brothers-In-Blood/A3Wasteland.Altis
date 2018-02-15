// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Sniper.sqf
//	@file Author: JoSchaap, AgentRev, LouD, BIB_Monkey

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";
private _box1 = "";
private _box2 = "";
private _box3 = "";
private _box4 = "";

_setupVars =
{
	_missionType = "AAF Sniper Nest";
	_locationsArray = SniperMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	private _BoxTypes = 
	[
		"Box_FIA_Ammo_F",
		"Box_IND_Ammo_F",
		"Box_IND_Wps_F",
		"Box_AAF_Equip_F",
		"Box_IND_AmmoOrd_F",
		"Box_IND_Grenades_F",
		"Box_IND_WpsLaunch_F",
		"Box_IND_WpsSpecial_F",
		"Box_IND_Support_F",
		"Box_AAF_Uniforms_F",
		"Box_FIA_Wps_F"
	];
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

	private _box1type = selectrandom _BoxTypes;
	private _box1Loot = selectrandom _loottypes;
	_box1 = createVehicle [_box1type, _missionPos, [], 0, "None"];
	_box1 setVariable ["R3F_LOG_disabled", true, true];
	_box1 setVariable ["moveable", false, true];
	_box1 setDir random 360;
	[_box1, _box1Loot] call fn_refillbox;

	private _box2type = selectrandom _BoxTypes;
	private _box2Loot = selectrandom _loottypes;
	_box2 = createVehicle [_box2type, _missionPos, [], 0, "None"];
	_box2 setVariable ["R3F_LOG_disabled", true, true];
	_box2 setVariable ["moveable", false, true];
	_box2 setDir random 360;
	[_box2, _box2Loot] call fn_refillbox;

	private _box3type = selectrandom _BoxTypes;
	private _box3Loot = selectrandom _loottypes;
	_box3 = createVehicle [_box3type, _missionPos, [], 0, "None"];
	_box3 setVariable ["R3F_LOG_disabled", true, true];
	_box3 setVariable ["moveable", false, true];
	_box3 setDir random 360;
	[_box3, _box3Loot] call fn_refillbox;

	private _box4type = selectrandom _BoxTypes;
	private _box4Loot = selectrandom _loottypes;
	_box4 = createVehicle [_box4type, _missionPos, [], 0, "None"];
	_box4 setVariable ["R3F_LOG_disabled", true, true];
	_box4 setVariable ["moveable", false, true];
	_box4 setDir random 360;
	[_box4, _box4Loot] call fn_refillbox;
	_aiGroup = createGroup CIVILIAN;
	for "_i" from 1 to 10 do
	{
		[_aiGroup, _missionPos] call createAAFRegularSniper;
	};
	for "_i" from 1 to 3 do
	{
		[_aiGroup, _missionPos] call createAAFRegularAA;
	};
	for "_i" from 1 to 3 do
	{
		[_aiGroup, _missionPos] call createAAFRegularAT;
	};
	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	[_aiGroup, _missionPos] call defendArea;

	_missionHintText = format ["A Sniper Nest has been spotted. Head to the marked area and Take them out! Be careful they are fully armed and dangerous!", AAFMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3, _box4];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3, _box4];
	_successHintMessage = format ["The snipers are dead! Well Done!"];
};

_this call AAFMissionProcessor;
