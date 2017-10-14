//	@file Version:
//	@file Name:
//	@file Author: Cael817 edited by: BIB_Monkey
//	@file Created:


private _manager = cursorObject;
private _lockdown = false;

_managers = nearestObjects [ _manager, ["Land_SatellitePhone_F"], 100, true];
if ( count _managers > 1) then 
{
	_getmanagerstatus = [{_x getVariable ["Baselockenabled", false]} foreach _managers];
	_checker = [true];
	_findlockedmanager = _checker arrayIntersect _getmanagerstatus;
	if (count _findlockedmanager > 0) then 
	{
		_lockdown = true;
	};
} else 
{
	_lockdown = false;
};

if (_lockdown) then 
{
	hint "Base Underlockdown. Action Aborted";
} else 
{
	_baseobjects = nearestObjects [_manager, ["All"], 100];
	{ _x setVariable ["Moveable", true, true]} foreach _baseobjects;
	{ _x setVariable ["lockeddown", false, true]} foreach _baseobjects;
	_manager setvariable ["Baselockenabled", false, true];
	cursorobject enableSimulationGlobal true;
	hint "Released Lock Down";
};