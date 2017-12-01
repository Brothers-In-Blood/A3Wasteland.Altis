/*
Author: BIB_Monkey
Filename: BaseCraking.sqf
Purpose: Allow player to hack into enemy base manager remotely
*/
// Config Settings
	// What vehicle is to be used
	#define crackervehicle "O_Truck_03_device_F"
	// How long should it take in seconds
	#define hacktime  (60*60*2)
	// Hack Range in meters. Should be more half the radius of the base manager
	#define range 15
	//what to tell the player if they exit the vehile
	#define failtext titletext ["Hack Aborted, No User Input", "PLAIN DOWN"]
// Setup Variables
	//Establish Base Cracker Vehicle
	private _cracker = vehicle player;
	//Figure out where the Base Cracker is
	private _crackerpos = getpos _cracker;
	//Make sure the player is a passanger in the vehicle
	private _operatorcheck = _cracker getCargoIndex player;
	//Find the closest base manager
	private _manager = nearestObject [player, "Land_SatellitePhone_F"];
	private _managerpos = getpos _manager;
	//Get the distance to the base Manager
	private _distance = _cracker distance2D _manager;
	//Figure out who own the base manager
	private _managerOwner = _manager getVariable "OwnerUID";
	//Get the players UID for owner check
	private _playerUID = getPlayerUID player;
	//Extablish Mutex Script no in progress
	mutexScriptInProgress = false;
// Start Hack Action
	//Make sure player is in correct vehicle type
	if (_cracker iskindof crackervehicle) then
	{
		//Make sure player is in correct seat
		if (_operatorcheck == 0) then
		{
			//Make sure there's a base manager in range
			if (_distance <= range) then
			{
				if (_playerUID == _managerOwner) then
				{
					titletext ["Closest Base manager owned by operator, hack cancelled", "PLAIN DOWN"];
				} else
				{
					//Switch Mutex to true to prevent player from doing multiple actions
					mutexScriptInProgress = true;
					//stuff to let the player know the hack is still working
					titletext ["Begining hack", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Probing Firewall for weaknesses","PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Firewall bypassed, Second firewall encountered", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Second Firewall bypassed, Scanning system", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["System Scan complete, Overwriting Security protocols", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Security Protocols overwritten, Gaining access to root files", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Scanning files for base manager controls", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Base manager control files located, Gaining Access", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Overwritting Base Manager controlls", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Base Manager control overwritting, applying changes", "PLAIN DOWN"];
					sleep (hacktime/10);
					if !((vehicle player) iskindof 'O_Truck_03_device_F') exitwith {failtext};
					titletext ["Hack Successfull, password reset to 1234", "PLAIN DOWN"];
					_manager setVariable ["Password", "1234"];
				};
			// inform the player there's no base manager in range
			} else
			{
				titletext ["No base manager in range", "PLAIN DOWN"]
			};
		// Let the player know they're in the wrong seat
		} else
		{
			titletext ["You must be in the passanger seat to operate base hacking system", "PLAIN DOWN"];
		};
	// Let the player know they're no in the correct vehicle
	}else
	{
		titletext ["This vehicle doesn't contain base hacking systems", "PLAIN DOWN"];
	};
//makesure mutex exits if action aborted by vehicle exit and script complete
mutexScriptInProgress = false;

