/*
Author: BIB_Monkey
Filename: TipObjectXpos.sqf
Purpose: Align object straight up
*/

//Define Object
_object = cursorObject;

//Do the thing
_object setVectorUp surfaceNormal position _object;