/*
Author: BIB_Monkey
FileName: AdjustObjectDown.sqf
Purpose: Adjust an objects position down for base building
*/

//Setup Variable
//Define the Object
_object = cursorTarget;
//Find the objects location
_objpos = getpos _object;
//Isolate X value
_posX = _objpos select 0;
//Isolate Y value
_posY = _objpos select 1;
//Isolate Z value
_posZ = _objpos select 2;

//Adjust object location
_object setPosATL [_posX, _posY, 0];