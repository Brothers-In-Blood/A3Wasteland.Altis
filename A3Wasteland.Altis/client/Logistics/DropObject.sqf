_object = attachedObjects player;

{detach _x} foreach _object;
player setVariable ["Carrying", false, true];
{_x setVariable ["Carried", false, true] foreach _object};
