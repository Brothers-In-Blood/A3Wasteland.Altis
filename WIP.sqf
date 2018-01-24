			//determine already attached locations
			_attachedStatic = _vehicle getVariable ["StaticAttached", false]
			_attached1 = _vehicle getVariable ["Location1_Attached", false];
			_attached2 = _vehicle getVariable ["Location2_Attached", false];
			_attached3 = _vehicle getVariable ["Location3_Attached", false];
			_attached4 = _vehicle getVariable ["Location4_Attached", false];
			_attached5 = _vehicle getVariable ["Location5_Attached", false];
			_attached6 = _vehicle getVariable ["Location6_Attached", false];
			_attached7 = _vehicle getVariable ["Location7_Attached", false];
			_attached8 = _vehicle getVariable ["Location8_Attached", false];
			_attached9 = _vehicle getVariable ["Location9_Attached", false];
			_attached10 = _vehicle getVariable ["Location10_Attached", false];
			_attached_SLD = _vehicle getVariable ["LocationSLD_Attached", false]; //Special Spot for Static laser designator

			//make sure theres an empty spot
			_spotarray = [_attachedStatic+_attached1+_attached2+_attached3+_attached4+_attached5+_attached6+_attached7+_attached8+_attached9+_attached10+_attached_SLD]


//Lets do the thing
	switch (true) do
	{
	//Offroad (unarmed)
		case (_vehicle iskindof "Offroad_01_unarmed_base_F"):
		{
			switch (true) do
			{
			//high GMG and HMG
				case({_static iskindof _x} count
				[
					"GMG_01_high_base_F", "GMG_01_high_base_F"
				]>0):
				{
					//let the player know what's going on 
					titleText ["Attaching to Offroad", "PLAIN"];
					//Attach the static to the vehicle
					_static attachTo [_vehicle, [-0.3,-1.9,0.9]];
					//Set the Statics direction
					_static setdir 180;
					//Set the variables
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
			//Low and autonomous HMG and GMG
				case({_static iskindof _x} count
				[
					"B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_vehicle animateSource ["hideRearDoor",1]; // Hide the tailgate so it isn't in the way
					_static attachTo [_vehicle, [0,-1.9,0.4]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count
				[
					"B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [0.2,-1.8,1.49012e-008]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count
				[
					"AT_01_base_F","AA_01_base_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [1.49012e-008,-1.7,0.3]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count
				[
					"Static_Designator_02_base_F", "Static_Designator_01_base_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [1.49012e-008,0.0999999,0.9]];
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
	//Offroad Repair
		case (_vehicle iskindof "Offroad_01_repair_base_F"):
		{
			switch (true) do
			{
			//high GMG and HMG
				case({_static iskindof _x} count
				[
					"GMG_01_high_base_F", "GMG_01_high_base_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
			//Low and autonomous HMG and GMG
				case({_static iskindof _x} count
				[
					"B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count
				[
					"B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count
				[
					"AT_01_base_F","AA_01_base_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count
				[
					"Static_Designator_02_base_F", "Static_Designator_01_base_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [1.49012e-008,0.0999999,0.9]];
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
	//Ofroad (Armed)
		case (_vehicle iskindof "I_G_Offroad_01_armed_F"):
		{
			switch (true) do
			{
			//high GMG and HMG
				case({_static iskindof _x} count
				[
					"GMG_01_high_base_F", "GMG_01_high_base_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
			//Low and autonomous HMG and GMG
				case({_static iskindof _x} count
				[
					"B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count
				[
					"B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count
				[
					"AT_01_base_F","AA_01_base_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count
				[
					"Static_Designator_02_base_F", "Static_Designator_01_base_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [1.49012e-008,1.9,-0.2]];
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
		case ({_vehicle iskindof _x} count
		[
			"Van_01_transport_base_F"
		]>0):
		{
			switch (true) do
			{
			//high GMG and HMG
				case({_static iskindof _x} count
				[
					"GMG_01_high_base_F", "GMG_01_high_base_F"
				]>0):
				{
					//let the player know what's going on 
					titleText ["Attaching to Offroad", "PLAIN"];
					//Attach the static to the vehicle
					_static attachTo [_vehicle, [-0.2,-2.4,1]];
					//Set the Statics direction
					_static setdir 180;
					//Set the variables
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
			//Low and autonomous HMG and GMG
				case({_static iskindof _x} count
				[
					"B_HMG_01_F","O_HMG_01_F","I_HMG_01_F","B_HMG_01_A_F","O_HMG_01_A_F","I_HMG_01_A_F","B_GMG_01_F","O_GMG_01_F","I_GMG_01_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
				};
				case({_static iskindof _x} count
				[
					"B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [-0.2,-2.4,0.1]];
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count
				[
					"AT_01_base_F","AA_01_base_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [0.1,-2.2,0.3]];
					_static setdir 180;
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
				};
				case({_static iskindof _x} count
				[
					"Static_Designator_02_base_F", "Static_Designator_01_base_F"
				]>0):
				{
					titleText ["Cannot Attach to this Vehicle", "PLAIN"];
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
				case({_static iskindof _x} count
				[
					"Static_Designator_02_base_F", "Static_Designator_01_base_F"
				]>0):
				{
					titleText ["Attaching to Offroad", "PLAIN"];
					_static attachTo [_vehicle, [1.49012e-008,3.2,1.3]];
					_static setVariable ["Attached", true, true];
					_vehicle setVariable ["Attached", true, true];
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
