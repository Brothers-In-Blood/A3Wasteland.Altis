/*
Author: BIB_Monkey
FileName: DetachFromVehicle.sqf
Purpose: Detach Static weapon from attached Vehicle
*/

//Setup Variables
_vehicle = cursorTarget;
_statics = attachedObjects _vehicle;

{detach _x} foreach _statics;
_vehicle setVariable ["Attached", False];
{_x setVariable ["Attached", False]} foreach _statics;