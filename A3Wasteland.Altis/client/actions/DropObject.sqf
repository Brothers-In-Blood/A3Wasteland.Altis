_object = attachedObject player;

detach _object;
player setVariable ["Carrying", false, true];
_object setVariable ["Carried", false, true];
