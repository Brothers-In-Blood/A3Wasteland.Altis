/*
Author: BIB_Monkey
FileName: DetachFromVehicle.sqf
Purpose: Detach Static Objects from attached Vehicle
*/

//Setup Variables
_vehicle = cursorTarget;  
_attached = attachedObjects _vehicle;
_vehLocation = getPosATL _vehicle

{
	if (_x getVariable ["Towed", false]) then {} else
	{
		detach _x;
		_detachpos = [_vehLocation,5,15,3,1,0,0] call findSafePos;
		_x setPosATL _detachpos;
		_x setVariable ["Towed", false, true];
		_vehicle setVariable ["Towing", false, true];
	};
} foreach _attached;

{
	_variables = 
	[
		"_attachedStatic",
		"_attachedSLD",
		"_Attached1",
		"_Attached2",
		"_Attached3",
		"_attached4",
		"_attached5",
		"_attached6",
		"_attached7",
		"_attached8",
		"_attached9",
		"_attached10"
	];
	if (_x getVariable ["Attached", false]) then {} else
	{
		detach _x;
		_detachpos = [_vehLocation,5,15,3,1,0,0] call findSafePos;
		_x setPosATL _detachpos;
		_x setVariable ["Attached", false, true];
		_vehicle setVariable ["Attached", false, true];
		_x setvariable {[_x, false, true]} forEach _variables;
	};
} foreach _attached;

