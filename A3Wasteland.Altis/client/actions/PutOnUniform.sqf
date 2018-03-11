/*
filename: PutOnUniform.sqf
Author: BIB_Monkey
Purpose: Allow player to wear cross faction uniform, when placed on the ground
*/

private _target = cursorObject;
private _groundUni = typeof _target;
private _uniform = [_groundUni, 5] call BIS_fnc_trimString;
player globalchat _uniform;
_isUniform = false;
{
	_check = _x select 1;
	if (_uniform == _check) then
	{
		_isUniform = true;
	};
} foreach call uniformArray;
if (_isUniform) then
{
	deleteVehicle _target;
	private _playerUniformItems = uniformItems player;
	player forceAddUniform _uniform;
	{player addItemToUniform _x} foreach _playerUniformItems;
}
else
{
	titleText ["That's not a uniform silly!", "PLAIN DOWN"];
};