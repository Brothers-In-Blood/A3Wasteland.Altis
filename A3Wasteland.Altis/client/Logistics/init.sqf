/*
Author: BIB_Monkey
Purpose: initialize BIB Logistics System

Variables used by the Logistics System:
	LogisticsEnabled ~ Enables the logistics system for the object
	Moveable ~ Determines whether an objects can be moved by the player or attached to another object
	Towable ~ Determines whether a vehicle can be towed
	CanTow ~ Determines whether a vehicle can tow
	Transportable ~ Determines whether an object can be transported by a vehicle
	Transport ~ Determines whether a vehicle can transport object 
All variables should be applied to the vehicle/object
*/

{[player, _x]  call fn_addManagedAction } forEach
[
	//Attach Static Weapon To Vehicle
	["Attach To Vehicle", "client\Logistics\AttachtoVehicle.sqf", [], -10, false, false, "", "(cursorTarget iskindof 'StaticWeapon' || cursorTarget iskindof 'Reammobox_F') && !(cursorTarget getVariable ['Attached', false])"],
	//Dettach Static Object from Vehicle
	["Dettach From Vehicle", "client\Logistics\DetachFromVehicle.sqf", [], -10, false, false, "", "cursorTarget iskindof 'Car_F' && cursorTarget getVariable ['Attached', false]"],
	//Tow Vehicle
	["tow Vehicle", "client\Logistics\TowVehicle.sqf", [], -10, false, false, "", "cursorTarget iskindof 'Car_F' && cursorTarget getVariable ['Towed', false]"],
	//Pickup Object
	["Pickup Object", "client\Logistics\PickupObject.sqf", [], -10, false, false, "", "({cursorTarget iskindof _x} count ['StaticWeapon', 'Reammobox_F', 'Items_base_F', 'NonStrategic']>0) && cursorTarget getVariable ['Moveable', false] && !(player getVariable ['Carrying', false]) && !(cursorTarget getVariable['Carried', false])"],
	//Drop Object
	["Drop Object", "client\Logistics\DropObject.sqf", [], -10, false, false, "", "player getVariable ['Carrying', false]"],
	//Transport Object
	["Transport Object", "client\Logistics\TransportObject.sqf", [], -10, false, false, "", "cursorTarget iskindof 'All' && !(cursorTarget getVariable ['Attached', false]) && cursorTarget getVariable ['Moveable', false] && cursorTarget getVariable ['Transportable', false]"],
	//Lock Down Object
	["Lock Down Object", "cursorTarget setVariable ['Moveable', false, true]; cursorTarget setvariable ['LogisticsEnabled', true, true]", [], -10, false, false, "", "cursorTarget getvariable ['Moveable', false]"],
	//Unlock Object
	["Unlock Object", "cursorTarget setVariable ['Moveable', true, true]", [], -10, false, false, "", "!(cursorTarget getvariable ['Moveable', false]) && cursorTarget getvariable ['LogisticsEnabled', false]"],
	//Activate Base Mode
	["Switch to Base Building Mode", "player setVariable ['BaseMode', true, true]", [], -99, false, false, "", "!(player getVariable['BaseMode', false])"],
	//De-Activate Base Mode
	["Exit Base Building Mode", "player setVariable ['BaseMode', false, true]", [], -99, false, false, "", "player getVariable['BaseMode', false]"]
];

if (player getVariable ["BaseMode", false]) then
{
	[] execVM "client\Logistics\MoveObject.sqf";
};