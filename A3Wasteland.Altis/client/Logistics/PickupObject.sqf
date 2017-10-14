/*
Author: BIB_Monkey
FileName: PickupObject.sqf
Purpose: Allow player to move static objects
*/


//Setup Variables
_object = cursorobject;

switch (true) do
{
	case (_object iskindof "StaticWeapon"):
	{
		_object attachTo [player, [-0.1,3,2.1]];
		player setVariable ["Carrying", true, true];
		_object setVariable ["Carried", true, true];
	};
	case (_object isKindOf "Reammobox_F"):
	{
		_object attachTo [player, [0.0999999,1.5,1]];
		player setVariable ["Carrying", true, true];
		_object setVariable ["Carried", true, true];
	};
	case (_object iskindof "Items_base_F"):
	{
		_object attachTo [player, [-7.45058e-008,1,1]];
		player setVariable ["Carrying", true, true];
		_object setVariable ["Carried", true, true];
	};
	case (_object isKindOf "NonStrategic"):
	{
		_object attachTo [player, [1,39.4,5.4]];
		player setVariable ["Carrying", true, true];
		_object setVariable ["Carried", true, true];
	};
};