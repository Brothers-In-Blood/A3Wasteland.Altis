//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

private ["_baseobjects", "_manager"];

_manager = cursorObject;

_managers = nearestObjects [ _manager, ["Land_SatellitePhone_F"], 100];
if ( count _managers > 0) then {
	_getmanagerstatus = {_x getVariable ["Baselockenabled", true]} foreach _managers;
	_checker = [true];
	_findlockedmanager = _checker arrayIntersect _getmanagerstatus;
	if (count _findlockedmanager > 0) then {
		_lockdown = true;
	};
} else {
	_lockdown = false;
};

if (_lockdown) then {
	hint "Base Underlockdown. Action Aborted";
} else {
	_baseobjects = nearestObjects [_manager, ["All"], 100];
	{ _x setVariable ["LockedDown", false, true]} foreach _baseobjects;
	_manager setvariable ["Baselockenabled", false, true];
	cursorobject enableSimulationGlobal true;
	hint "Released Lock Down";
};



