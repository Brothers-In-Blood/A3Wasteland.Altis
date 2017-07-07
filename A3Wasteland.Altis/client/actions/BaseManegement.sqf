_NearestManager = nearestObject [player, "Land_SatellitePhone_F"];
_playerUID = getPlayerUID player;
_ManagerOwner = _NearestManager getvariable "ownerUID";
_Nearmanagers = player nearObjects ["Land_SatallitePhone_F", 50];
_lockdown = { _x getVariable ["lockdown", false]} forEach _Nearmanagers;

if (_lockdown) then
{
  hint "Interferance from lockedown base prevents access"; // Improve this line
} else {
  If ((player distance _NearestManager) < 50) then {
    If (_playerUID == _ManagerOwner) then {
      execVM "addons\BoS\BoS_remote_ownerMenu.sqf";
      hint "Welcome Owner";
      } else {
        execVM "addons\BoS\remote_password_enter.sqf";
        hint "Welcome";
    } else {
      hint "No Base Manager in Range";
    };
  };
};
