/*
Author: BIB_Monkey
Filename: AttachtoVehicle.sqf
Purpose: Attach Static Weapons to Vehicles
*/

//Setup Variables
_static = cursortarget;
_vehicle = nearestObject [_static, "car_F"];
_posstatic = getPos _static;
_posvehicle = getPos _vehicle;
_distance = _posstatic distance _posvehicle;

if (_distance <=10) then
{
	switch (true) do
	{
		//Offroad
		case ({_vehicle iskindof _x} count["C_Offroad_01_F","B_GEN_Offroad_01_gen_F","B_G_Offroad_01_F","C_Offroad_01_repair_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.2,-2.5,1]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.0999999,-2.1,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];

				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-0.1,-2.3,0.0999999]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-0.1,-2.3,0.3]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};

			};
		};
		//Box Truck
		case ({_vehicle iskindof _x} count["C_Van_01_transport_F","B_G_Van_01_transport_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.2,-2.7,1]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058,-2.6,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-0.1,-2.3,0.0999999]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-0.1,-2.5,0.4]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};

				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
			};
		};
		//HEMMT Trackter
		case ({_vehicle iskindof _x} count["B_Truck_01_mover_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F"]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};

				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.0999999,-3,1.6]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.0999999,-3.2,1.6]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.4,-0.2,1.6]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};

			};
		};
		//HEMMT
		case ({_vehicle iskindof _x} count["B_Truck_01_transport_F","B_Truck_01_covered_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.2,-4.2,1.1]];
					_static setdir 180;
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058,-2.6,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-0.1,-2.8,0.2]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058e-008,-4.4,0.4]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};

				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
			};
		};
		// Tempest
		case ({_vehicle iskindof _x} count["O_Truck_03_transport_F","O_Truck_03_covered_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.2,-4.2,1.2]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058,-2.6,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.0999999,-2.1,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058e-008,-4.4,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};

				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
			};
		};
		//Zamak
		case ({_vehicle iskindof _x} count["I_Truck_02_transport_F","I_Truck_02_covered_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.2,-3,0.9]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058,-2.6,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-0.1,-1.9,-7.45058]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058e-008,-3.8,0.2]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};

				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
			};
		};
		//Prowler
		case ({_vehicle iskindof _x} count["B_T_LSV_01_unarmed_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058e-008,-1.6,-0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [-7.45058e-008,-2.1,-0.3]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};

				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
			};
		};
		//UGV Stomper
		case ({_vehicle iskindof _x} count["B_UGV_01_F","I_UGV_01_F","O_UGV_01_F"]>0):
		{
			switch (true) do
			{
				case({_static iskindof _x} count["B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F","B_GMG_01_high_F","O_GMG_01_high_F","I_GMG_01_high_F"]>0):
				{
					titleText ["Cannot Attach", "PLAIN"];
				};
				case({_static iskindof _x} count["B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.6,-1.2,0.5]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.3,-1.8,0.0999999]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count["B_static_AT_F","O_static_AT_F","I_static_AT_F","B_static_AA_F","O_static_AA_F","I_static_AA_F"]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.4,-2,0.3]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};

				case(_static iskindof "B_SAM_System_02_F"):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.4,-0.7,1.2]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case(_static iskindof "B_SAM_System_01_F"):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.4,-0.5,1]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case(_static iskindof "B_AAA_System_01_F"):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1];
					_static attachTo [_vehicle, [0.4,-0.2,1.6]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
			};
		};
	};
} else {
	titleText ["Nothing in range", "PLAIN"];
};
