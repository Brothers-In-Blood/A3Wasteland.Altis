/*
File Name: reinitilizeUAV.sqf
Author: BIB_Monkey
Purpose: Allow player to reactive UAV/Autonomour turret after server restart or being removed from Parking
*/


//Setup Variable
_uav = cursortarget;
_class = typeOf _uav;
_isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);
_playerSide = side player;
_playerID = getPlayerUID player;
_uavOwner = _uav getVariable "ownerUID";

if (_isUAV) then 
{
	if (_uavOwner == _playerID) then 
	{
		_grp = [_uav, _playerSide, true] call fn_createCrewUAV;
	} else {
		hint "No owned UAVs in range";
	};
} else {
	hint "No UAV in range";
};

