//	@file Name: teamBalance.sqf

// Teambalancer
_uid = getPlayerUID player;
if (playerSide in [BLUFOR,OPFOR]) then{
	private ["_justPlayers", "_serverCount", "_sideCount"];
	_justPlayers = allPlayers - entities "HeadlessClient_F";
	_serverCount = count _justPlayers;
	_sideCount = playerSide countSide _justPlayers;
	_opposingSide = [BLUFOR, OPFOR] select (playerSide==BLUFOR);
	_opposingCount = _opposingSide countSide _justPlayers;
	if ((abs (_sideCount-_opposingCount)) > 3 ) then{
		if !(_uid call isAdmin) then {
			["TeamBalance",false,1] call BIS_fnc_endMission;
		} else {
			cutText ["You have used your admin to join a stacked team. Only do this for admin duties.", "PLAIN DOWN", 1];
		};
	};
};
