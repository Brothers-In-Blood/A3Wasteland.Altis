//Configuration for Airdrop Assistance
//Author: Apoc

APOC_AA_coolDownTime = 15; //Expressed in sec

APOC_AA_VehOptions =
[ // ["Menu Text",		ItemClassname,				Price,	"Drop Type"]
["Quadbike (Civilian)", "C_Quadbike_01_F", 			1200, 	"vehicle"],
["Motorboat", 			"C_Boat_Civil_01_F",		2000,	"vehicle"],
["SDV Submarine", 		"B_SDV_01_F",	            2000,   "vehicle"],
["Offroad HMG", 		"B_G_Offroad_01_armed_F",	5000, 	"vehicle"],
["MH-9 Hummingbird", 	"B_Heli_Light_01_F", 		15000, 	"vehicle"],
["Hunter HMG", 			"B_MRAP_01_hmg_F", 			70000, 	"vehicle"],
["Strider GMG", 		"B_MRAP_01_hmg_F", 			75000, 	"vehicle"],
["UH-80 Ghost Hawk", 	"B_Heli_Transport_01_F", 	75000, 	"vehicle"],
["IFV-6a Cheetah AA", 	"B_APC_Tracked_01_AA_F", 	230000, "vehicle"],
["T-100 Varsuk", 		"O_MBT_02_cannon_F", 		280000, "vehicle"]

];

APOC_AA_SupOptions =
[// ["stringItemName", 	"Crate Type for fn_refillBox 	,Price," drop type"]
["Launchers", 			"airdrop_Launchers", 			60000,	"supply"],
["Sniper Rifles", 		"airdrop_Snipers", 				50000,	"supply"],
["Rifles", 				"airdrop_Rifles", 				45000,	"supply"],
["LMGs", 				"airdrop_LMGs", 				45000,	"supply"],
["Dive Gear", 			"airdrop_Diving_Gear", 			25000,	"supply"],
["Medical", 			"airdrop_Medical", 				5000,	"supply"],
["Field Engineer",		"airdrop_Field_Engineer", 		5000,	"supply"],
// ["Test",				"mission_USLaunchers",			1,		"supply"],

//"Menu Text",			"Crate Type", 			"Cost", "drop type"
["Food",				"Land_Sacks_goods_F",		5000, 	"picnic"],
["Water",				"Land_BarrelWater_F",		5000, 	"picnic"],
["Fuel", 				"FlexibleTank_01_sand_F",	5000,	"picnic"],
["Vehicle Ammo",		"Box_NATO_AmmoVeh_F",		125000, "picnic"]
];