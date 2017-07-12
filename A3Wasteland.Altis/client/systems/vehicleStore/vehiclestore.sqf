private ["_vehicletypeselectoptions", "_vehicleselectoptions", "_camoselectoptions", "_armamentselect1options", "_pylonselectleft1options", "_pylonselectcenter1options", "_pylonselectright1options"];
_vehicleSelection = (findDisplay 2733) displayCtrl IDC_DYNAMICVEHICLESTORE_VEHICLESELECT;
_addThisToListBox = "Option";
_vehicleSelection lbAdd _addThisToListBox;

_start = createDialog "DynamicVicStore";
