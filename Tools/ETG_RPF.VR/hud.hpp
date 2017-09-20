/*
	Filename: hud.hpp
	Author: Kellojo
	Description: Main ETG Relative Hud

#Cefodi
$[
	1.063,
	["RPF_HUD",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"background_1",[1,"",["0.0101562 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.185625 * safezoneW","0.143 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"txt_prog",[1,"Progress :",["0.0153125 * safezoneW + safezoneX","0.412 * safezoneH + safezoneY","0.061875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"txt_name",[1,"Name :",["0.0153125 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.061875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"txt_Class",[1,"Classname :",["0.0153125 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.061875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"txt_offset",[1,"Offset :",["0.0153125 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.061875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"txt_progress_var",[1,"-progress-",["0.0823437 * safezoneW + safezoneX","0.412 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"txt_name_var",[1,"-name-",["0.0823437 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"txt_classname_var",[1,"-classname-",["0.0823437 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"txt_offset_var",[1,"-offset-",["0.0823437 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1008,"txt_cont",[1,"Controls:",["0.0101562 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.185625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1009,"txt_contr_l_r",[1,"Left/Right :",["0.0153125 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1010,"txt_cont_f_b",[1,"Forward/Backwards :",["0.0153125 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1011,"txt_cont_u_d",[1,"Up/Down :",["0.0153125 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1013,"txt_forwards_backwards",[1,"Arrow up/down",["0.102969 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1014,"txt_left_right",[1,"Arrow left/right",["0.102969 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1015,"txt_up_down",[1,"Pic up/down",["0.102969 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1012,"txt_save",[1,"Save Offset :",["0.0153125 * safezoneW + safezoneX","0.753 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1016,"txt_save_var",[1,"Enter",["0.102969 * safezoneW + safezoneX","0.753 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1017,"txt_alt",[1,"Different speed : ",["0.0153125 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1018,"txt_alt_speed",[1,"Right CTRL",["0.102969 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2201,"backgtound_2",[1,"",["0.0101562 * safezoneW + safezoneX","0.577 * safezoneH + safezoneY","0.185625 * safezoneW","0.407 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1019,"txt_head",[1,"ETG Relavite Position Finder",["0.0101562 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.185625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1022,"",[1,"Create Cam : ",["0.0153125 * safezoneW + safezoneX","0.819 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1023,"",[1,"+",["0.102969 * safezoneW + safezoneX","0.819 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1024,"",[1,"Top view :",["0.0153125 * safezoneW + safezoneX","0.852 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1025,"",[1,"Side view  1 :",["0.0153125 * safezoneW + safezoneX","0.885 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1026,"",[1,"Side view  2 :",["0.0153125 * safezoneW + safezoneX","0.918 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1027,"",[1,"Num. 7",["0.102969 * safezoneW + safezoneX","0.852 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1028,"",[1,"Num. 8",["0.102969 * safezoneW + safezoneX","0.885 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1029,"",[1,"Num. 9",["0.102969 * safezoneW + safezoneX","0.918 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1030,"",[1,"Camera destroy :",["0.0153125 * safezoneW + safezoneX","0.951 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1031,"",[1,"-",["0.102969 * safezoneW + safezoneX","0.951 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1020,"txt_setup",[1,"Setup :",["0.0153125 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1021,"txt_setup_var",[1,"xyz",["0.102969 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1032,"",[1,"Alt. Speed :",["0.0153125 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1033,"",[1,"Right CTRL",["0.102969 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class ETG_RPF_HUD
{
	idd = 147430;
	fadeout=0;
	fadein=0;
	duration = 100000000;
	onLoad = "uiNamespace setVariable ['ETG_RPF_HUD', _this select 0];[3] call fn_rpf;";

	class controlsBackground 
	{
		class background_1: IGUIBack
		{
			idc = 2200;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.143 * safezoneH;
		};
		class backgtound_2: IGUIBack
		{
			idc = 2201;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.407 * safezoneH;
		};
	};
	class controls
	{
		class txt_prog: RscText
		{
			idc = 1000;
			text = "Progress :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_name: RscText
		{
			idc = 1001;
			text = "Name :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_Class: RscText
		{
			idc = 1002;
			text = "Classname :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_offset: RscText
		{
			idc = 1003;
			text = "Offset :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_progress_var: RscText
		{
			idc = 1004;
			text = "-progress-"; //--- ToDo: Localize;
			x = 0.0823437 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_name_var: RscText
		{
			idc = 1005;
			text = "-name-"; //--- ToDo: Localize;
			x = 0.0823437 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_classname_var: RscText
		{
			idc = 1006;
			text = "-classname-"; //--- ToDo: Localize;
			x = 0.0823437 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_offset_var: RscText
		{
			idc = 1007;
			text = "-offset-"; //--- ToDo: Localize;
			x = 0.0823437 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_cont: RscText
		{
			idc = 1008;
			text = "Controls:"; //--- ToDo: Localize;
			colorBackground[] = {0.59,0.98,0.13,0.6};
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_contr_l_r: RscText
		{
			idc = 1009;
			text = "Left/Right :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_cont_f_b: RscText
		{
			idc = 1010;
			text = "Forward/Backwards :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_cont_u_d: RscText
		{
			idc = 1011;
			text = "Up/Down :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_forwards_backwards: RscText
		{
			idc = 1013;
			text = "Arrow up/down"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_left_right: RscText
		{
			idc = 1014;
			text = "Arrow left/right"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_up_down: RscText
		{
			idc = 1015;
			text = "Pic up/down"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_save: RscText
		{
			idc = 1012;
			text = "Save Offset :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_save_var: RscText
		{
			idc = 1016;
			text = "Enter"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_alt: RscText
		{
			idc = 1017;
			text = "Different speed : "; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_alt_speed: RscText
		{
			idc = 1018;
			text = "Right CTRL"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_head: RscText
		{
			idc = 1019;
			text = "ETG Relavite Position Finder"; //--- ToDo: Localize;
			colorBackground[] = {0.59,0.98,0.13,0.6};
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1022: RscText
		{
			idc = 1022;
			text = "Create Cam : "; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.819 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1023: RscText
		{
			idc = 1023;
			text = "+"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.819 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1024: RscText
		{
			idc = 1024;
			text = "Top view :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.852 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1025: RscText
		{
			idc = 1025;
			text = "Side view  1 :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.885 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1026: RscText
		{
			idc = 1026;
			text = "Side view  2 :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.918 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1027: RscText
		{
			idc = 1027;
			text = "Num. 7"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.852 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1028: RscText
		{
			idc = 1028;
			text = "Num. 8"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.885 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1029: RscText
		{
			idc = 1029;
			text = "Num. 9"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.918 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1030: RscText
		{
			idc = 1030;
			text = "Camera destroy :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1031: RscText
		{
			idc = 1031;
			text = "-"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_setup: RscText
		{
			idc = 1020;
			text = "Setup :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txt_setup_var: RscText
		{
			idc = 1021;
			text = "INSERT"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1032: RscText
		{
			idc = 1032;
			text = "Alt. Speed :"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1033: RscText
		{
			idc = 1033;
			text = "Right CTRL"; //--- ToDo: Localize;
			x = 0.102969 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};






