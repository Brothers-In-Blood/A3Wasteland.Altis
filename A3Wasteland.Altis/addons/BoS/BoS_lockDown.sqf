//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

private ["_baseobjects", "_manager"];


_manager = cursorObject;
_baseobjects = nearestObjects [_manager, ["All"], 100];
{ _x setVariable ["LockedDown", true, true]} foreach _baseobjects;
_manager setvariable ["Baselockenabled", true, true];
cursorobject enableSimulationGlobal false;
hint "Base is now under Lock Down";
