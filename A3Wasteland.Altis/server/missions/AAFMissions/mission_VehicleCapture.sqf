// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_VehicleCapture.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, BIB_Monkey
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private ["_vehicle", "_vehicleName", "_vehDeterminer"];

// setupVars must be defined in the top mission file

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_spawnPos = _missionPos;
	_spawnPos set [2, 0.5];
	private _randomDamage = random [0, 0.5, 0.9];
	private _randomFuel = random [0, 0.5, 0.9];
	// Class, Position, Fuel, Ammo, Damage, Special
	_vehicle = [_vehicleClass, _spawnPos] call createMissionVehicle;
	_vehicle setDamage _randomDamage;
	_vehicle setFuel _randomFuel;

	//reload _vehicle;

	_aiGroup = createGroup CIVILIAN;
	switch (true) do
	{
		case ({_vehicleClass isKindOf _x} count ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"] > 0):
		{
			for "_i" from 1 to 5 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
		};
		case ({_vehicleClass isKindOf _x} count ["B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F"] > 0):
		{
			for "_i" from 1 to 7 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			};
			[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
		};
		case (_vehicleClass isKindOf "I_APC_Wheeled_03_cannon_F"):
		{
			for "_i" from 1 to 7 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			};
			[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
		};
		case (_vehicleClass isKindOf "I_APC_tracked_03_cannon_F"):
		{
			for "_i" from 1 to 7 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
			};
		};
		case (_vehicleClass isKindOf "I_MBT_03_cannon_F"):
		{
			for "_i" from 1 to 10 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			};
			for "_i" from 1 to 2 do
			{
				[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
			};
		};	
		case ({_vehicleClass isKindOf _x} count ["I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"] > 0):
		{
			for "_i" from 1 to 10 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
			};
		};
		case (_vehicleClass isKindOf "I_UAV_02_dynamicLoadout_F"):
		{
			for "_i" from 1 to 10 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
			};
		};
		case ({_vehicleClass isKindOf _x} count ["I_Heli_Transport_02_F", "I_Heli_light_03_dynamicLoadout_F", "I_Heli_light_03_unarmed_F"] > 0):
		{
			for "_i" from 1 to 10 do
			{
				[_aiGroup, _missionPos, "AAF", "Rifleman"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "SAW"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "Genedier"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Medic"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "Marksman"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "AT"] call createsoldier;
			};
			for "_i" from 1 to 4 do
			{
				[_aiGroup, _missionPos, "AAF", "AA"] call createsoldier;
			};
			for "_i" from 1 to 3 do
			{
				[_aiGroup, _missionPos, "AAF", "Engineer"] call createsoldier;
			};
		};
	};
	_aiGroup setCombatMode "RED";
	_missionPicture = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleClass >> "displayName");
	
	_vehDeterminer = if ("AEIMO" find (_vehicleName select [0,1]) != -1) then { "An" } else { "A" };

	_missionHintText = format ["%1 <t color='%3'>%2</t> has been immobilized, go get it for your team!", _vehDeterminer, _vehicleName, AAFMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _vehicle};

_failedExec =
{
	// Mission failed
	deleteVehicle _vehicle;
};

_successExec =
{
	// Mission completed
	_vehicle lock 1;
	_vehicle setVariable ["R3F_LOG_disabled", false, true];

	_successHintMessage = format ["The %1 has been captured, well done.", _vehicleName];
};

_this call AAFMissionProcessor;
