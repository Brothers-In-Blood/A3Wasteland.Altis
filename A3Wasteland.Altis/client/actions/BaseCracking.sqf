/*
Author: BIB_Monkey
Filename: BaseCraking.sqf
Purpose: Allow player to hack into enemy base manager remotely
*/

//Setup Variables
_cracker = nearestObject [player, "O_Truck_03_device_F"];
_crackerpos = getpos _cracker;
_operatorcheck = _cracker getCargoIndex player;
_manager = nearestObject [player, "Land_SatellitePhone_F"];
_managerpos = getpos _manager;
_managerOwner = getVariable "OwnerUID";

_isoperator = false
if (_operatorcheck => 0) then [_isoperator = true];

while (_isoperator)
