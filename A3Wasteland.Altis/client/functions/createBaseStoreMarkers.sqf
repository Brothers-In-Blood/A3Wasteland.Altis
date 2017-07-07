// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: createBaseStoreMarkers.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, BIB_Monkey
//	@file Args:

//Creates the markers around Base Parts stores.
{
	if (!isPlayer _x && {(vehicleVarName _x) select [0,8] == "BaseStore"}) then
	{
		_npcPos = getPosATL _x;

		// Base store title
		_markerName = format["marker_shop_title_%1",_x];
		deleteMarkerLocal _markerName;
		_marker = createMarkerLocal [_markerName, _npcPos];
		_markerName setMarkerShapeLocal "ICON";
		_markerName setMarkerTypeLocal "mil_dot";
		_markerName setMarkerColorLocal "ColorRed";
		_markerName setMarkerSizeLocal [1,1];
		_markerName setMarkerTextLocal "BS";
	};
} forEach entities "CAManBase";
