//	@file Version:
//	@file Name:
//	@file Author: Cael817 Edited By: BIB_Monkey
//	@file Created:

private _manager = cursorObject;
private _lockdown = false;
//Get manager level
private _ManagerLevel = _manager getVariable ["ManagerLevel", 1];
//set default base radius for level 1 manager
private _BaseRadius = 10;
//set base radius based on manager level
switch (_ManagerLevel) do
{
	case (2):
	{
		_BaseRadius = 20;
	};
	case (3):
	{
		_BaseRadius = 30;
	};
	case (4):
	{
		_BaseRadius = 40;
	};
	case (5):
	{
		_BaseRadius = 50;
	};
};

private _managers = nearestObjects [ _manager, ["Land_SatellitePhone_F"], (_BaseRadius * 2), true];
if ( count _managers > 1) then 
{
	private _getmanagerstatus = [{_x getVariable ["Baselockenabled", false]} foreach _managers];
	private _checker = [true];
	private _findlockedmanager = _checker arrayIntersect _getmanagerstatus;
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
	private _baseobjects = nearestObjects [_manager, ["All"], 35];
	{ _x setVariable ["Moveable", false, true]} foreach _baseobjects;
	{ _x setVariable ["Lockeddown", true, true]} foreach _baseobjects;
	_manager setvariable ["Baselockenabled", true, true];
	cursorobject enableSimulationGlobal false;
	hint "Base is now under Lock Down";
};
