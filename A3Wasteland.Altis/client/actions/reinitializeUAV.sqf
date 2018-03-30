/*
File Name: reinitilizeUAV.sqf
Author: BIB_Monkey
Purpose: Allow player to reactive UAV/Autonomour turret after server restart or being removed from Parking
*/


//Setup Variable
_mode = _this select 3 select 0;
_uav = cursortarget;
_class = typeOf _uav;
_isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);
_playerSide = side player;
_playerID = getPlayerUID player;
_uavOwner = _uav getVariable ["ownerUID", ""];

if (_isUAV) then 
{
	if (_uavOwner == _playerID) then 
	{
		switch (_mode) do
		{
			case "Re-Initilize":{_grp = [_uav, _playerSide, true] call fn_createCrewUAV};
			case "Sentry":{_grp = [_uav] call fn_createCrewUAV};
			default {player globalChat "Something has gone awry"};
		};
	} else 
	{
		hint "No owned UAVs in range";
	};
} else 
{
	hint "No UAV in range";
};

