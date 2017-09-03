/*
Author: BIB_Monkey
FileName: AdjustObjectDown.sqf
Purpose: Adjust an objects direction clockwise
*/

//Setup Variable
//Define the Object
_object = cursorTarget;
//Find the objects location
_direction = getdir _object;

//Adjust object location
_object setDir (_direction - 1);