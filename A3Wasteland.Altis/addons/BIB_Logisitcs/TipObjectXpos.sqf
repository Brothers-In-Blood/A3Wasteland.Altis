/*
Author: BIB_Monkey
Filename: TipObjectXpos.sqf
Purpose: Rotate object one X axis in positive direction
*/

//Define Object
_object = cursorObject;
//Find objects vector
_objectVector = vectorUp _object;
//Isolate X Vector
_VectorX = _objectVector select 0;
//Isolate Y Vector
_VectorY = _objectVector select 1;
//Isalate Z vector
_VectorZ = _objectVector select 2;

//Do the thing
_object setVectorUp [(_VectorX + 1), _VectorY, _VectorZ];