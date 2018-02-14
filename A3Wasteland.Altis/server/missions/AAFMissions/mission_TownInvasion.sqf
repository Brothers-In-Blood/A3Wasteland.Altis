// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, Zenophon
//  @file Information: JoSchaap's Lite version of 'Infantry Occupy House' Original was made by: Zenophon

if (!isServer) exitwith {};

#include "AAFMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_tent1", "_chair1", "_chair2", "_cFire1"];

_setupVars =
{
	_missionType = "Town Invasion";
	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};

_setupObjects =
{
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

	// spawn some crates in the middle of town (Town marker position)
	_box1type = selectrandom _BoxTypes;
	_box1Loot = selectrandom _loottypes;
	_box1 = createVehicle [_box1type, _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _box1Loot] call fn_refillbox;
	
	_box2type = selectrandom _BoxTypes;
	_box2Loot = selectrandom _loottypes;
	_box2 = createVehicle [_box2type, _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, _box2Loot] call fn_refillbox;
	
	_box3type = selectrandom _BoxTypes;
	_box3Loot = selectrandom _loottypes;
	_box3 = createVehicle [_box3type, _missionPos, [], 5, "None"];
	_box3 setDir random 360;
	[_box3, _box3Loot] call fn_refillbox;

	_box4type = selectrandom _BoxTypes;
	_box4Loot = selectrandom _loottypes;
	_box4 = createVehicle [_box4type, _missionPos, [], 5, "None"];
	_box4 setDir random 360;
	[_box4, _box4Loot] call fn_refillbox;

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_cFire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"];


	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2, _box3, _box4];

	// spawn some rebels/enemies :)
	_aiGroup = createGroup CIVILIAN;
	for "_i" from 1 to 30 do
	{
		private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
		switch (_soldierType) do
		{
			case "Rifleman": {[_aiGroup, _missionPos] call createAAFRegularRifleman};
			case "AT": {[_aiGroup, _missionPos] call createAAFRegularAT};
			case "AA": {[_aiGroup, _missionPos] call createAAFRegularAA};
			case "SAW": {[_aiGroup, _missionPos] call createAAFRegularSAW};
			case "Engineer": {[_aiGroup, _missionPos] call createAAFRegularEngineer};
			case "Medic": {[_aiGroup, _missionPos] call createAAFRegularMedic};
			case "Grenedier": {[_aiGroup, _missionPos] call createAAFRegularGrenedier};
			case "Marksman": {[_aiGroup, _missionPos] call createAAFRegularMarksman};
		};

	// move them into buildings
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;
	_aiGroup setCombatMode "RED";
	_missionHintText = format ["Hostiles have taken over <br/><t size='1.25' color='%1'>%2</t><br/><br/>There seem to be <t color='%1'>%3 enemies</t> hiding inside or on top of buildings. Get rid of them all, and take their supplies!<br/>Watch out for those windows!", AAFMissionColor, _townName, _nbUnits];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3, _box4, _tent1, _chair1, _chair2, _cFire1];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3, _box4];
	_money = ceil random 50000;
	_box1 setVariable ["cmoney", _money, true];

	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings are now yours to take!", AAFMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _cFire1];
};

_this call AAFMissionProcessor;
