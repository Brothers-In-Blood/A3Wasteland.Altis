/*
FileName: MoveUp.sqf
Author: BIB_Monkey
Purpose: adjust and objects position
*/

private _object = cursorObject;
private _objectPOS = getPos _object;
private _objectVector = vectorUp _object;
private _posX = _objectPOS select 0;
private _posY = _objectPOS select 1;
private _posZ = _objectPOS select 2;
private _rotX = _objectVector select 0;
private _rotY = _objectVector select 1;
private _rotZ = _objectVector select 2;

{[player, _x]} call fn_addManagedAction
[
	["Move Up", "_object setpos [_posX, _posY, _posZ + 0.1]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Move Down", "_object setpos [_posX, _posY, _posZ - 0.1]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Move East", "_object setpos [_posX + 0.1, _posY, _posZ]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Move West", "_object setpos [_posX - 0.1, _posY, _posZ]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Move North", "_object setpos [_posX, _posY + 0.1, _posZ]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Move South", "_object setpos [_posX, _posY -0.1, _posZ]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Rotate Clockwise", "_object setVectorUp [_rotX, _rotY, _rotZ + 0.1; setpos _objectPOS]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Rotate Counter Clockwise", "_object setVectorUp [_rotX, _rotY, _rotZ - 0.1 setpos _objectPOS]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Roll Left", "_object setVectorUp [_rotX, _rotY + 0.1, _rotZ setpos _objectPOS]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Roll Right", "_object setVectorUp [_rotX, _rotY - 0.1, _rotZ setpos _objectPOS]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Pitch Up", "_object setVectorUp [_rotX + 0.1, _rotY, _rotZ setpos _objectPOS]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"],
	["Pitch Down", "_object setVectorUp [_rotX - 0.1, _rotY, _rotZ setpos _objectPOS]", [], -10, false, false, "", "cursorObject getvariable ['Moveable', false]"]
];
