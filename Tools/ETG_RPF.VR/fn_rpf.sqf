/*
	Filename:fn_rpf.sqf
	Author: Kellojo
	Description: Main ETG Relative Position Finder logic
*/

_mode = _this select 0;

//hotkeys...
if (_mode == 2) then 
{
	_shift = _this select 2;
	_strg = _this select 3;
	_alt = _this select 4;

	switch (_this select 1) do 
	{

		//Key arrow right
		case 200: 
		{
			_off = if (_strg) then {0.05} else {0.1};
			x1 = x1 + _off;
			
			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};	
		//Key arrow left
		case 203: 
		{
			_off = if (_strg) then {0.05} else {0.1};
			x2 = x2 + _off;

			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};	
		//Key arrow down
		case 208: 
		{
			_off = if (_strg) then {0.05} else {0.1};
			x1 = x1 - _off;

			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};
		//Key arrow up
		case 205: 
		{
			_off = if (_strg) then {0.05} else {0.1};
			x2 = x2 - _off;

			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};
		//Key page up
		case 201: 
		{
			_off = if (_strg) then {0.05} else {0.1};
			x3 = x3 + _off;

			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};
		//Key page down
		case 209: 
		{
			_off = if (_strg) then {0.05} else {0.1};
			x3 = x3 - _off;

			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};
		//Key Home
		case 199: 
		{
			[4] call fn_rpf;
		};
		//Key END
		case 207: 
		{
			[3] call fn_rpf;
		};
		//Key Insert
		case 210: 
		{
			[5] call fn_rpf;
		};
		//Key +
		case 78: 
		{
			[7] call fn_rpf;
		};
		//Key num. 7
		case 71: 
		{
			[8] call fn_rpf;
		};
		//Key num. 8
		case 72: 
		{
			[9] call fn_rpf;
		};
		//Key num. 9
		case 73: 
		{
			[10] call fn_rpf;
		};
		//Key -
		case 74: 
		{
			[11] call fn_rpf;
		};
		//Key delete
		case 211: 
		{
			if (!IsNil {findDisplay 147460}) then 
			{
				createDialog "ETG_RPF_arr_Diag";
			};
		};
		//Next Dummy Object
		case 26: 
		{
			[22] call fn_rpf;
		};
		//Previous DUmmy Object
		case 27: 
		{
			[23] call fn_rpf;
		};
		case 51: 
		{
			dummy_dir = dummy_dir + 1;
			dummy_obj setDir dummy_dir;
			cur_vehicle setPos [position pos_obj select 0,position pos_obj select 1,0];
			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};
		case 52:
		{
			dummy_dir = dummy_dir - 1;
			dummy_obj setDir dummy_dir;
			cur_vehicle setPos [position pos_obj select 0,position pos_obj select 1,0];
			dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
			[0] call fn_rpf;
		};
	};
};

//next veh
if (_mode == 3) then 
{
	If (cur_index + 1 <= count vehicle_list - 1) then 
	{
		cur_index = cur_index + 1;
		if !(IsNil "cur_vehicle") then {deleteVehicle cur_vehicle;};
		cur_vehicle = (vehicle_list select cur_index) createVehicle [position pos_obj select 0,position pos_obj select 1,2];
		cur_vehicle allowDamage false;
		cur_vehicle setDir dummy_dir;
		cur_vehicle setPos [position pos_obj select 0,position pos_obj select 1,0];
		cur_vehicle enableSimulation false;
		dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
		[0] call fn_rpf;
		dummy_obj enableSimulation false;
	};
};

//previous veh
if (_mode == 4) then 
{
	If (cur_index - 1 <= count vehicle_list - 1 && cur_index - 1 >= 0) then {
		cur_index = cur_index - 1;
		if !(IsNil "cur_vehicle") then {deleteVehicle cur_vehicle;};
		cur_vehicle = (vehicle_list select cur_index) createVehicle [position pos_obj select 0,position pos_obj select 1,2];
		cur_vehicle allowDamage false;
		cur_vehicle enableSimulation false;
		cur_vehicle setDir dummy_dir;
		cur_vehicle setPos [position pos_obj select 0,position pos_obj select 1,0];
		dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
		[0] call fn_rpf;
		dummy_obj enableSimulation false;
	};
};

//next dummy
if (_mode == 23) then 
{
	If (dummy_index + 1 <= count dummy_LIST - 1) then 
	{
		dummy_index = dummy_index + 1;
		if !(IsNil "dummy_obj") then {deleteVehicle dummy_obj;};
		dummy_obj = (dummy_LIST select dummy_index) createVehicle [position pos_obj select 0,position pos_obj select 1,2];
		dummy_obj allowDamage false;
		dummy_obj setDir dummy_dir;
		dummy_obj setPos [position pos_obj select 0,position pos_obj select 1,0];
		dummy_obj enableSimulation false;
		dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
		[0] call fn_rpf;
		dummy_obj enableSimulation false;
	};
};

//previous dummy
if (_mode == 22) then 
{
	If (dummy_index - 1 <= count dummy_LIST - 1 && dummy_index - 1 >= 0) then 
	{
		dummy_index = dummy_index - 1;
		if !(IsNil "dummy_obj") then {deleteVehicle dummy_obj;};
		dummy_obj = (dummy_LIST select dummy_index) createVehicle [position pos_obj select 0,position pos_obj select 1,2];
		dummy_obj allowDamage false;
		dummy_obj enableSimulation false;
		dummy_obj setDir dummy_dir;
		dummy_obj setPos [position pos_obj select 0,position pos_obj select 1,0];
		dummy_obj attachTo [cur_vehicle,[x1,x2,x3]];
		[0] call fn_rpf;
		dummy_obj enableSimulation false;
	};
};

//save current pos and vehicle
if (_mode == 5) then 
{
	hint "Saving current offset and vehicle...";
	
		//Pos_Array = [typeof dummy_obj, typeOf cur_vehicle,[x1,x2,x3], getDir dummy_obj];
		Pos_Array = [x1,x2,x3];
		hint "Positions were copied to the clipboard (STRG + V)";
		copytoclipboard str Pos_Array;
};

//set new vehicle list
if (_mode == 6) then 
{
	//check vehicle list for updates
	if ((ctrlText 147461) != "") then 
	{
		str_to_var = compile format ["vehicle_list = [%1]",ctrlText 147461];
		[] call str_to_var;
	};
	//check dummy obj. for updates
	if ((ctrlText 147462) != "") then 
	{
		_pos = position dummy_obj;
		deleteVehicle dummy_obj;
		dummy_obj = (ctrlText 147462) createVehicle _pos;
	};
	//Close dialog
	while {!IsNil {findDisplay 147460}} do 
	{
		closeDialog 0;
	};
};

//create cam
if (_mode == 7) then 
{
	_camera = "camera" camCreate [position player select 0,position player select 1,3];
	_camera cameraEffect ["internal","back"];
	_camera camSetFOV 0.700;
	_camera camCommit 0;
	camera = _camera;
};

//cam pos 1
if (_mode == 8) then 
{
	_camera = camera;
	_camera camSetTarget cur_vehicle;
	_camera camSetRelPos [0,0,5];
	_camera camCommit 0;
};

//cam pos 2
if (_mode == 9) then 
{
	_camera = camera;
	_camera camSetTarget cur_vehicle;
	_camera camSetRelPos [0,3,0.6];
	_camera camCommit 0;
};

//cam pos 3
if (_mode == 10) then 
{
	_camera = camera;
	_camera camSetTarget cur_vehicle;
	_camera camSetRelPos [-3,0,0.6];;
	_camera camCommit 0;
};

//del cam
if (_mode == 11) then 
{
	camera cameraEffect ["terminate","back"];
	camDestroy camera;
};

//setup Dialog
if (_mode == 0) then 
{
	disableSerialization;
	_ctrl = uiNamespace getVariable "ETG_RPF_HUD";
	_offset = cur_vehicle worldToModel position dummy_obj;

	//Round x1/x2/x3
	_x1 = round ((_offset select 0) * (10 ^ 3)) / (10 ^ 3);
	_x2 = round ((_offset select 1) * (10 ^ 3)) / (10 ^ 3);
	_x3 = round ((_offset select 2) * (10 ^ 3)) / (10 ^ 3);

	//Update HUD
	(_ctrl displayCtrl 1004) ctrlSetText	format ["%2/%1",count vehicle_list,cur_index + 1];
	(_ctrl displayCtrl 1007) ctrlSetText str ([_x1,_x2,_x3]);
	(_ctrl displayCtrl 1005) ctrlSetText format ["%1",getText (configfile >> "CfgVehicles" >> (typeOf cur_vehicle) >> "displayName")];
	(_ctrl displayCtrl 1006) ctrlSetText str (vehicle_list select cur_index);
};
