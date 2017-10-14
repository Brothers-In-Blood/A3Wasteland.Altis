// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev, BIB_Monkey
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	//Emergency Eject
	[format ["<t color='#FF0000'>Emergency eject (Ctrl+%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]],	{ [[], fn_emergencyEject] execFSM "call.fsm" }, [], 99, false, true, "", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
	//Open Magic Parachute
	[format ["<t color='#FF00FF'>Open magic parachute (%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]], A3W_fnc_openParachute, [], 99, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"],
	//Heal Self
	["Heal self", "client\actions\healSelf.sqf",0,2,false,false,"","(damage player)>0.01 && 'Medikit' in (items player)"],
	//Hide Body
	["<img image='client\icons\cancel.paa'/> Hide Body", "client\actions\hide.sqf", [], 1, false, false, "", "!isNull cursorObject && !alive cursorObject && {cursorObject isKindOf 'Man' && player distance cursorObject <= (sizeOf typeOf cursorObject / 3) max 2}"],
	//Take Gear
	["<img image='client\icons\cancel.paa'/> Take Gear", "client\actions\TakeGear.sqf", [], 1, false, false, "", "!isNull cursorObject && !alive cursorObject && {cursorObject isKindOf 'Man' && player distance cursorObject <= (sizeOf typeOf cursorObject / 3) max 2}"],
	//Re-initialize UAV
	["Re-Initilize UAV", "client\actions\reinitializeUAV.sqf", [], 1, false, false, "", "{_x in ['B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0 && {cursorTarget iskindof _x} count ['UAV_02_base_F', 'UAV_04_base_F', 'UAV_03_base_F', 'UGV_01_base_F', 'StaticWeapon'] >0"],
	//Disable UAV
	["Disable UAV", "client\actions\disableUAV.sqf", [], 1, false, false, "", "{_x in ['B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0 && {cursorTarget iskindof _x} count ['UAV_02_base_F', 'UAV_04_base_F', 'UAV_03_base_F', 'UGV_01_base_F', 'StaticWeapon'] >0"],
	//Disable UAV IFF
	//["Disable UAV IFF", "client\actions\disableUAVIFF.sqf", [], 1, false, false, "", "{_x in ['B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0 && {cursorTarget iskindof _x} count ['UAV_02_base_F', 'UAV_04_base_F', 'UAV_03_base_F', 'UGV_01_base_F', 'StaticWeapon'] >0"],
	//Attach Static Weapon To Vehicle
	["Attach To Vehicle", "client\actions\AttachtoVehicle.sqf", [], -10, false, false, "", "(cursorTarget iskindof 'StaticWeapon' || cursorTarget iskindof 'Reammobox_F')&& !(cursorTarget getVariable ['Attached', false])"],
	// //Dettach Static Object To Vehicle
	["Dettach From Vehicle", "client\actions\DetachFromVehicle.sqf", [], -10, false, false, "", "cursorTarget iskindof 'Car_F' && cursorTarget getVariable ['Attached', false]"],
	// //Tow Vehicle
	// ["tow Vehicle", "client\actions\TowVehicle.sqf", [], -10, false, false, "", "cursorTarget iskindof 'Car_F' && cursorTarget getVariable ['Attached', false]"],
	// //Pickup Object
	// ["Pickup Object", "client\actions\PickupObject.sqf", [], -10, false, false, "", "({cursorTarget iskindof _x} count ['StaticWeapon', 'Reammobox_F', 'Items_base_F', 'NonStrategic']>0) && cursorTarget getVariable ['Moveable', false] && !(player getVariable ['Carrying', false])"],
	// //Drop Object
	// ["Drop Object", "client\actions\DropObject.sqf", [], -10, false, false, "", "player getVariable ['Carrying', false]"],
	// //Transport Object
	// ["Attach To Vehicle", "client\actions\TransportObject.sqf", [], -10, false, false, "", "cursorTarget iskindof 'All' && !(cursorTarget getVariable ['Attached', false]) && cursorTarget getVariable ['Moveable', false]"],
	// //Lock Down Object
	// ["Lock Down Object", "cursorTarget setVariable ['Moveable', false, true]", [], -10, false, false, "", "cursorTarget getvariable ['Moveable', false]"],
	// //Unlock Object
	// ["Unlock Object", "cursorTarget setVariable ['Moveable', true, true]", [], -10, false, false, "", "!(cursorTarget getvariable ['Moveable', false])"],
	// //Open Logistics Menu
	// ["Open Logistic Menu", "addons\BIB_Logisitcs\BIB_LogisticsMenu.sqf", [], -10, false, false, "", "cursorTarget getvariable ['Moveable', false]"],
	//Push Land Vehicle
	["Push vehicle", "server\functions\pushVehicle.sqf", [2.5, true], 1, false, false, "", "[2.5] call canPushVehicleOnFoot"],
	// Push Water Vehicle
	["Push vehicle forward", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["Push vehicle backward", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],
	//TakeOwnership
	["<img image='client\icons\r3f_unlock.paa'/> Acquire Vehicle Ownership", "client\actions\takeOwnership.sqf", [cursorObject], 1, false, false, "", "alive cursorObject && player distance cursorObject <= (sizeOf typeOf cursorObject / 3) max 3 && {{cursorObject isKindOf _x} count ['LandVehicle','Ship','Air'] > 0 && {locked cursorObject < 2 && !(cursorObject getVariable ['objectLocked',false]) && cursorObject getVariable ['ownerUID','0'] != getPlayerUID player && 'ToolKit' in items player}}"],
	//Picku Money
	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],
	//Holster Weapon
	["Holster Weapon", { player action ["SwitchWeapon", player, player, 100] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player != '' && (stance player != 'CROUCH' || currentWeapon player != handgunWeapon player)"],
	//Remote Base Access
	["Acess Remote Base Management", "client\actions\BaseManegement.sqf", [], -98, false, true, "","{_x in ['B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0"],
	//Open Player Menu
	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[</t>Player Menu<t color='%1'>]</t>", "#FF8000"], "client\systems\playerMenu\init.sqf", [], -99, false],
	//Cancel Action
	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", { doCancelAction = true }, [], 1, false, false, "", "mutexScriptInProgress"],
	//Salvage Vehicle
	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorObject && !alive cursorObject && {cursorObject isKindOf 'AllVehicles' && !(cursorObject isKindOf 'Man') && player distance cursorObject <= (sizeOf typeOf cursorObject / 3) max 3}"],
	//Push Plain
	["[0]"] call getPushPlaneAction,
	//Mark Owned Objects on Map
 	["<t color='#FFE496'><img image='client\icons\search.paa'/> Mark your stuff on the map</t>", "addons\scripts\markOwned.sqf", [], -95,false,false,"","{_x in ['ItemGPS','B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0"],
	//Airdrop
	[format ["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa' color='%1'/> <t color='%1'>[</t>Airdrop Menu<t color='%1'>]</t>", "#FF0000"],"addons\APOC_Airdrop_Assistance\APOC_cli_menu.sqf",[], 1, false, false],
	//Detect Beacons
	["Track Beacons", "addons\beacondetector\beacondetector.sqf",0,-10,false,false,"","('MineDetector' in (items player)) && !BeaconScanInProgress"],
	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel tracking.</t>", "Beaconscanstop = true",0,-10,false,false,"","BeaconScanInProgress"]
];

if (["A3W_vehicleLocking"] call isConfigOn) then
{
	[player, ["<img image='client\icons\r3f_unlock.paa'/> Pick Lock", "addons\scripts\lockPick.sqf", [cursorObject], 1, false, false, "", "alive cursorObject && player distance cursorObject <= (sizeOf typeOf cursorObject / 3) max 3 && {{cursorObject isKindOf _x} count ['LandVehicle','Ship','Air'] > 0 && {locked cursorObject == 2 && !(cursorObject getVariable ['A3W_lockpickDisabled',false]) && cursorObject getVariable ['ownerUID','0'] != getPlayerUID player && 'ToolKit' in items player}}"]] call fn_addManagedAction;
};


if !(288520 in getDLCs 1) then
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 99, true, true, "", "cursorObject isKindOf 'Kart_01_Base_F' && player distance cursorObject < 3.4 && isNull driver cursorObject"]] call fn_addManagedAction;
};

if (["A3W_savingMethod", "profile"] call getPublicVar == "extDB") then
{
	if (["A3W_vehicleSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Vehicle", { cursorObject call fn_forceSaveVehicle }, [], -9.5, false, true, "", "call canForceSaveVehicle"]] call fn_addManagedAction;
	};
};
