//	@file Version:
//	@file Name:
//	@file Author: Cael817 based on objectSearchinteraction.sqf from A3W Edited by: BIB_Monkey
//	@file Created:



private _maxLifetime = ["A3W_objectLifetime", 0] call getPublicVar;
private _manager = nearestObject [player, "Land_SatellitePhone_F"];
private _ManagerPosition = getpos _manager;
private _objects = nearestObjects [_ManagerPosition, ["thingX", "Building", "ReammoBox_F"], _BaseRadius, true];
private _ownedObjects = {typeName _x == "OBJECT" && {!(isNil {_x getVariable "ownerUID"})} && {_x getVariable "objectLocked"}} count _objects;
private _playerMoney = player getVariable "cmoney";
private _price = _ownedObjects * 500;
private _playerMoney = player getVariable "cmoney";
//Get manager level
private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
//set default base radius for level 1 manager
private _BaseRadius = 10;
//set base radius based on manager level
switch (_ManagerLevel) do
{
	case (2):
	{
		_BaseRadius = 20;
	};
	case (3):
	{
		_BaseRadius = 30;
	};
	case (4):
	{
		_BaseRadius = 40;
	};
	case (5):
	{
		_BaseRadius = 50;
	};
};


if (isNil "reLockedObjectMapMarkers") then {
	// This is the global we use to keep track of map markers
	reLockedObjectMapMarkers = [];
};

if (count reLockedObjectMapMarkers > 0) then {
	{
		deleteMarkerLocal _x;
	} forEach reLockedObjectMapMarkers;
	reLockedObjectMapMarkers = [];
	["Map cleared of previous markers", 5] call mf_notify_client;
};

if (!isNil "_price") then 
{
	// Add total sell value to confirm message
	_confirmMsg = format ["Re locking %1 baseparts/objects will cost you $%2<br/>Range is %3 meters, all relocked objects will be marked on map", _ownedObjects, _price, _BaseRadius, _maxLifetime];

	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "OK", true] call BIS_fnc_guiMessage) then
	{	
		// Ensure the player has enough money

		if (_price > _playerMoney) exitWith
		{
			hint format ["You need $%1 to Re Lock %2 objects",  _price, _ownedObjects];
			playSound "FD_CP_Not_Clear_F";
		};
		
		player setVariable["cmoney",(player getVariable "cmoney")-_price,true];
		
		reLockedObjectMapMarkers = [];
		{
		//if(_x getVariable "ownerUID" == getplayerUID player) then 
		if !(isNil {_x getVariable "ownerUID"}) then // Changed so also non owned objects are relocked
		{
		private ["_name","_objPos","_name","_marker"];
		_x setVariable ["baseSaving_hoursAlive", nil, true];
		_x setVariable ["baseSaving_spawningTime", nil, true];
		_x setVariable ["objectLocked",true,true];
		pvar_manualObjectSave = netId _x;
		publicVariableServer "pvar_manualObjectSave";
		//trackObject = _x;
		//publicVariableServer "trackObject";
		//_x setVariable ["ownerUID", getPlayerUID player, true]; //possibly set new owner?
		//_x setVariable ["ownerN", name player, true]; // set this here if not set in R3F?
		_name = gettext(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
		_objPos = getPosATL _x;
		_marker = "reLockedObjectMapMarkers" + (str _forEachIndex);
		_marker = createMarkerLocal [_marker, _objPos];
		_marker setMarkerTypeLocal "waypoint";
		_marker setMarkerPosLocal _objPos;
		_marker setMarkerTextLocal _name;
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTextLocal _name;
	reLockedObjectMapMarkers pushBack _marker;
	};
	_x setDamage 0;
} forEach _objects;


if (count reLockedObjectMapMarkers > 0) then {

	["Added Markers for the locked objects, they will be removed in 30 seconds", 5] call mf_notify_client;
	
	}else{
	//["No owned objects found within the set radius", 5] call mf_notify_client;
	[format ["No owned objects found within %1m",_BaseRadius], 5] call mf_notify_client;	
};
	
sleep 30;

if (count reLockedObjectMapMarkers > 0) then
{
	{
		deleteMarkerLocal _x;
	} forEach reLockedObjectMapMarkers;
	reLockedObjectMapMarkers = [];
	["Map cleared", 5] call mf_notify_client;
};

};
};