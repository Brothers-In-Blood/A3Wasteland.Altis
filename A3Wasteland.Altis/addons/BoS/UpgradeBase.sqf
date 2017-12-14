/*
filename: UpgradeBase.sqf
Author: BIB_Monkey
Purpos: Allow player to upgrade their base manager, for now just base radius
*/

//Find the players base manager
private _Manager = nearestObject [player, "Land_SatellitePhone_F"];
//Get the current level
private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
//Get player money
private _money = player getvariable ["cmoney", 0];
//Initialize upgrade price variable
private _UpgradePrice = 0;
//Set upgrade price based on current manager level
switch (_ManagerLevel) do
{
	case (1):
	{
		_UpgradePrice = 1000000;
	};
	case (2):
	{
		_UpgradePrice = 2000000;
	};
	case (3):
	{
		_UpgradePrice = 4000000;
	};
	case (4):
	{
		_UpgradePrice = 8000000;
	};
};
private _nearmanagers = nearestObjects [ _manager, ["Land_SatellitePhone_F"], 100, true];
{
	//Prompt player to confirm cost
	_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to the next level", _UpgradePrice], "Do you want to proceed?"];
	if ([_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage) then
	{
		//Make sure the player has enough money
		if (_money >= _UpgradePrice) then
		{
			//Subtract cost from player money
			player setVariable ["bmoney", (player getVariable ["bmoney",0]) - _UpgradePrice, true];
			//Upgrade the manager to the next level and make sure another base isn't too close
			switch (_ManagerLevel) do
			{
				case (1):
				{
					_upgrade = true;
					{
						_nearmanager = _x
						private _distance = _manager distance2D _nearmanagers
						if (_distance is < 40) then
						{
							_upgrage = false;
						};
					} foreach _nearmanagers;
					if (_upgrade) then
					{
						_manager setVariable ["ManagerLevel", 2, true];
					} else
					{
						titletext ["Another base is too close. Relocate to upgrade", "PLAIN DOWN"];
					};
				};
				case (2):
				{
					_upgrade = true;
					{
						_nearmanager = _x
						private _distance = _manager distance2D _nearmanagers
						if (_distance is < 60) then
						{
							_upgrage = false;
						};
					} foreach _nearmanagers;
					if (_upgrade) then
					{
						_manager setVariable ["ManagerLevel", 3, true];
					} else
					{
						titletext ["Another base is too close. Relocate to upgrade", "PLAIN DOWN"];
					};
				};
				case (3):
				{
					_upgrade = true;
					{
						_nearmanager = _x
						private _distance = _manager distance2D _nearmanagers
						if (_distance is < 80) then
						{
							_upgrage = false;
						};
					} foreach _nearmanagers;
					if (_upgrade) then
					{
						_manager setVariable ["ManagerLevel", 4, true];
					} else
					{
						titletext ["Another base is too close. Relocate to upgrade", "PLAIN DOWN"];
					};
				};
				case (4):
				{
					_upgrade = true;
					{
						_nearmanager = _x
						private _distance = _manager distance2D _nearmanagers
						if (_distance is < 100) then
						{
							_upgrage = false;
						};
					} foreach _nearmanagers;
					if (_upgrade) then
					{
						_manager setVariable ["ManagerLevel", 5, true];
					} else
					{
						titletext ["Another base is too close. Relocate to upgrade", "PLAIN DOWN"];
					};
				};
			};
		} else
		{
			titleText ["You don't have enough money, %1 costs %2 to resupply", "PLAIN DOWN"];
		}
	};
} else
{
	titletext ["Your base manager is already at maximum level", "PLAIN DOWN"];
};