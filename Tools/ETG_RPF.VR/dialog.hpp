/*
	Filename: dialog.hpp
	Author: Kellojo
	Description: Main ETG Relative Dialog
	
#Tatobi
$[
	1.063,
	["array_dialog",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"back_main",[1,"",["0.29375 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.4125 * safezoneW","0.187 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_array",[1,"",["0.298906 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.402187 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2400,"btn_confirm",[1,"Confirm",["0.298906 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.402187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2401,"btn_close",[1,"Close",["0.298906 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.402187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"txt_head",[1,"Enter your classname Array:",["0.29375 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.4125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"edit_dummy",[1,"",["0.298906 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.402187 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"Put your classname for the dummy object in here","-1"],[]]
]
*/


class ETG_RPF_arr_Diag
{
	idd = 147460;

	class controlsBackground 
	{
		class back_main: IGUIBack
		{
			idc = 2200;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.187 * safezoneH;
		};
	};
	class controls
	{
		class edit_array: RscEdit
		{
			idc = 147461;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Allows you to easily set the list of vehicles you want to find positions for(quotes required)"; //--- ToDo: Localize;
		};
		class edit_dummy: RscEdit
		{
			idc = 147462;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Put your classname for the dummy object in here (no quotes required)"; //--- ToDo: Localize;
		};
		class btn_confirm: RscButton
		{
			idc = -1;
			text = "Confirm"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.022 * safezoneH;
			action = "[6] call fn_rpf;";
		};
		class btn_close: RscButton
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.022 * safezoneH;
			action = "closeDialog 0;";
		};
		class txt_head: RscText
		{
			idc = -1;
			colorBackground[] = {0.59,0.98,0.13,0.6};
			text = "Enter your classname Array:"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};


