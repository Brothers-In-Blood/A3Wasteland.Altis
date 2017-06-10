// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Bobcat Crater Cleaner
// Version 1.2
// Date: 2014.11.04
// Author: Lala14
// // // // // // // // // // // // // // // // // // // // // // // // // // // // //

// init line:
// null = [] execVM "cratercleaner.sqf";
/*Definable Start*/
CCAbleToRepair = 1; 			//Allow the bobcat to repair destroyed vehicles, 1 = Yes, 0 = No
CCTimeToFixMultiplier = 1;	//Requires CCAbleToRepair = 1, Sleep Each second during repairs, default = 1
CCRepairMultipler = 0.1;		//Requires CCAbleToRepair = 1, CCTimeToFixMulitplier Second repair level, default = 0.1
CCRepairLimit = 0.4;			//Requires CCAbleToRepair = 1, Limit the Repair level to this, default = 0
/*Definable End*/

/*Script Start*/

if (isDedicated) exitWith {};

waitUntil {!isNull player};

LALA_fnc_Crater_Check = {
	_unit = _this select 0;
	_veh = vehicle _unit;
	if !(_veh isKindOf "B_APC_Tracked_01_CRV_F") exitWith {false;};

	_crater = nearestObjects [_veh,["CraterLong"],30];

	_return = (count _crater > 0);
	_return;

};

Lala_fnc_Dead_Vehicle_Check = {
	_unit = _this select 0;
	_veh = vehicle _unit;

	if !(_veh isKindOf "B_APC_Tracked_01_CRV_F") exitWith {false;};

	_nearvehicles = nearestObjects [_veh,["LandVehicle","Air"],30];
	_nearvehicles = _nearvehicles - [_veh];
	_nearestvehicle = _nearvehicles select 0;

	_return;
};

Lala_fnc_Crater_Remover = {
	_unit = _this select 0;
	_veh = vehicle _unit;

	if (_veh == _unit) exitWith {hint "Get into a Bobcat!";};

	_crater = nearestObjects [_veh,["CraterLong"],10];

	{
		deleteVehicle _x;
		_veh vehicleChat format ["Removing %1",getText (configFile >> 'cfgVehicles' >> typeOf _x >> 'displayName')];
		sleep 0.1;
	}forEach _crater;
};

Lala_fnc_Dead_Vehicle_Remover = {
	_unit = _this select 0;
	_veh = vehicle _unit;

	if (_veh == _unit) exitWith {hint "Get into a Bobcat!";};

	_nearvehicles = nearestObjects [_veh,["LandVehicle","Air"],30];
	_nearvehicles = _nearvehicles - [_veh];
	_nearestvehicle = _nearvehicles select 0;

	if (!alive _nearestvehicle OR damage _nearestvehicle >= 1) then {
		deleteVehicle _nearestvehicle;
		_veh vehicleChat format ["Removing Destroyed %1",getText (configFile >> 'cfgVehicles' >> typeOf _nearestvehicle >> 'displayName')];
	};
};

Lala_fnc_Fix_Dead_Vehicle = {
	_unit = _this select 0;
	_veh = vehicle _unit;

	if (_veh == _unit) exitWith {hint "Get into a Bobcat!";};

	_nearvehicles = nearestObjects [_veh,["LandVehicle","Air"],30];
	_nearvehicles = _nearvehicles - [_veh];
	_nearestvehicle = _nearvehicles select 0;
	_oldname = name _nearestvehicle;
	_oldvarname = vehicleVarName _nearestvehicle;
	_oldpos = getPosATLVisual _nearestvehicle;
	_oldtype = typeof _nearestvehicle;
	_olddir = getDir _nearestvehicle;
	if (_oldname isEqualTo "Error: No vehicle") then {_oldname = _oldveh};
	deleteVehicle _nearestvehicle;
	sleep 0.5;
	_oldname =	_oldtype createVehicle _oldpos;
  _oldname allowdamage false;
	if (!isNil {_oldvarname}) then { _oldname setVehicleVarName _oldvarname; };
	_oldname setDamage 0.5;
	_oldname setVehicleAmmo 0.0;

	for [{_x=0.95},{_x>=CCRepairLimit},{_x=_x-CCRepairMultipler}] do {
		_oldname setDamage _x;
		_veh vehicleChat format ["Repairing %1 - %2%3",getText (configFile >> 'cfgVehicles' >> typeOf _oldname >> 'displayName'),damage _oldname * 100,'%'];
    _oldname allowdamage true;
		sleep CCTimeToFixMultiplier;
	};
	if (CCRepairLimit == 0) then {_oldname setDamage 0;};
	_oldname setFuel 0;
	_veh vehicleChat format ["Repairing %1 - %2%3",getText (configFile >> 'cfgVehicles' >> typeOf _oldname >> 'displayName'),damage _oldname * 100,'%'];
	_veh vehicleChat format ["Repairs complete on %1",getText (configFile >> 'cfgVehicles' >> typeOf _oldname >> 'displayName')];
};

LALA_fnc_AddAction_Crater_Cleaner = {
	_player = player;
	_repairobjectnear = 0;
	_repairObject = ["B_Slingload_01_Repair_F", "B_Truck_01_Repair_F"];
	_objectnar = nearestObjects [player, "all", 50];
	_repairobjectcheck = _repairObject arrayIntersect _objectnear;
	if (count _repairobjectcheck >0) then {
			_repairobjectnear = 1;
	};
	if (isNil {_player getVariable "CraterActionAdded"}) then {
		_player addAction ["<t color ='#FF0000'>Remove Crater/s</t>",{[(_this select 0)] spawn LALA_fnc_Crater_Remover},"",7,false,true,"",'[_this] call LALA_fnc_Crater_Check'];
		_player addAction ["<t color ='#FF0000'>Remove Destroyed Vehicle</t>",Lala_fnc_Dead_Vehicle_Remover,"",7,false,true,"",'[_this] call Lala_fnc_Dead_Vehicle_Check'];
		_player addAction ["<t color ='#FF0000'>Restore Destroyed Vehicle</t>",Lala_fnc_Dead_Vehicle_Remover,"",7,false,true,"",'[_this] call Lala_fnc_Dead_Vehicle_Check && _repairobjectnear > 0'];
		_player setVariable ["CraterActionAdded",true,true];
		_player addEventHandler ["Respawn",{(_this select 0) setVariable ["CraterActionAdded",nil,true]; [] spawn LALA_fnc_AddAction_Crater_Cleaner;}];
	};
};

systemChat "Crater Cleaner: Initialized";

[] spawn LALA_fnc_AddAction_Crater_Cleaner;
