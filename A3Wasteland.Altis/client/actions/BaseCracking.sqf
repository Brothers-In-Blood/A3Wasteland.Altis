/*
Author: BIB_Monkey
Filename: BaseCraking.sqf
Purpose: Allow player to hack into enemy base manager remotely
*/

//Setup Variables
//Establish Base Cracker Vehicle
_cracker = nearestObject [player, "O_Truck_03_device_F"];
//Figure out where the Base Cracker is
_crackerpos = getpos _cracker;
//Make sure the player is a passanger in the vehicle
_operatorcheck = _cracker getCargoIndex player;
//Find the closest base manager
_manager = nearestObject [player, "Land_SatellitePhone_F"];
_managerpos = getpos _manager;
//Figure out who own the base manager
_managerOwner = _manager getVariable "OwnerUID";
//Get the players UID for owner check
_playerUID = getPlayerUID player;
//Time in seconds it takes to crack the base
_time = 60*60*1.5; //Should take 1.5 hours to crack a base


mutexScriptInProgress = false;
//Make sure that the action cancels if the player exits the vehicle
while {_operatorcheck => 0} do
{
	//Make sure the player doesn't own the Base manager
	if (_managerOwner != _playerUID) then
	{
		//Start doing the action
		mutexScriptInProgress = true;
		_success = [_time, "", "", []] call a3w_actions_start;
		mutexScriptInProgress = false;
		//What happens if successfull
		if (_success) then
		{
			_manager setVariable ["Password", "1234"];
			titleText ["Base Manager hacked, password reset to 1234", "PLAIN DOWN"];
			_completed = true;
		//What happens if aborted/failed
		} else
		{
			titletext ["Hack Attempt Failed. Operation interupted", "PLAIN DOWN"];
		};
	//What happens if player owns base manager
	} else
	{
		titleText ["User ID accepted, System Shutting Down","PLAIN DOWN"];
	};
	//Jane get me off of this crazy thing!
	exitwith {};
};
//makesure mutex exits if action aborted by vehicle exit
mutexScriptInProgress = false;

