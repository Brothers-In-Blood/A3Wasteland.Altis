// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: Outpost1.sqf
//	@file Author: JoSchaap, AgentRev

[
	// Class, Position, Direction, Init (optional)
	["Box_IND_Ammo_F", [2290.88,3578.66,0.358602], 270],
	["Box_T_East_Ammo_F", [2290.87,3579.37,0.423944], 270],
	["Box_East_Ammo_F", [2290.88,3580.11,0.429959], 270],
	["Box_NATO_Ammo_F", [2290.85,3580.84,0.410563], 270],
	["Box_Syndicate_Ammo_F", [2290.86,3581.7,0.384738], 270],
	["Box_IND_Wps_F", [2291.72,3578.75,0.358602], 0],
	["Box_T_East_Wps_F", [2291.72,3579.45,0.358602], 0],
	["Box_East_Wps_F", [2291.73,3580.12,0.358602], 0],
	["Box_T_NATO_Wps_F", [2291.73,3580.81,0.359034], 0],
	["Box_NATO_Wps_F", [2291.73,3581.49,0.358602], 0],
	["Box_Syndicate_Wps_F", [2291.73,3582.15,0], 0],
	["Land_BagBunker_01_large_green_F", [-6.24817, 8.69141, 0]],
	["Land_HBarrier_01_tower_green_F", [2287.06,3594.51,0], 180],
	["Land_HBarrier_01_tower_green_F", [2294.46, 3594.241, 0], 180],
	["Box_AAF_Equip_F", [2294.82,3584.25,0.358602], 0],
	["Box_CSAT_Equip_F", [2293.64,3584.23,0.358602], 0,],
	["Box_NATO_Equip_F", [2294.24,3584.25,0.358602], 0],
	["Box_IED_Exp_F", [2294.54,3583.4,0.358602], 0],
	["Box_IND_AmmoOrd_F", [2292.92,3584.58,0.358602], 270],
	["Box_East_AmmoOrd_F", [2292.19,3584.58,0.358602], 270],
	["Box_NATO_AmmoOrd_F", [2291.44,3584.62,0.358602], 270],
	["Box_FIA_Ammo_F", [2287.21,3592.91,0], 0],
	["Box_FIA_Support_F", [2295.32,3592.51,0], 0],
	["Box_FIA_Wps_F", [2293.41,3592.16,0], 270],
	["Box_IND_Grenades_F", [2290.72,3584.7,0.358602] 270],
	["Box_East_Grenades_F", [2290.01,3584.71,0.358602], 270
	["Box_NATO_Grenades_F", [2289.2,3584.75,0.358602], 270],
	["Land_HBarrier_01_line_5_green_F", [2294.49,3600.09,0.000253677], 0],
	["Land_HBarrier_01_line_5_green_F", [2287.11,3600.15,-0.000641823], 0],
	["Land_HBarrier_01_line_5_green_F", [2277.98,3591.77,0], 270],
	["Land_HBarrier_01_line_5_green_F", [2277.99,3585.99,0], 270],
	["Land_HBarrier_01_line_5_green_F", [2278.01,3580.16,0], 270],
	["Land_HBarrier_01_line_5_green_F", [2303.34,3591.6,0], 90],
	["Land_HBarrier_01_line_5_green_F", [2303.16,3585.84,0], 270],
	["Land_HBarrier_01_line_5_green_F", [2303.09,3580.05,0], 270],
	["Land_HBarrier_01_line_5_green_F", [2288.51,3571.95,0], 0],
	["Land_HBarrier_01_line_5_green_F", [2294.17,3571.92,0], 0],
	["Land_HBarrier_01_line_5_green_F", [2288.52,3572,2.43844], 0],
	["Land_HBarrier_01_line_5_green_F", [2294.17,3571.95,2.44688], 0],
	["Land_HBarrier_01_line_1_green_F", [2292.1,3599.93,1.10048], 0],
	["Land_HBarrier_01_line_1_green_F", [2288.77,3600.03,1.09867], 0],
	["Land_HBarrier_01_wall_corridor_green_F", [2290.47,3603.38,0.00133324], 90],
	["Land_HBarrier_01_big_tower_green_F", [2300.43,3575.16,0], 0],
	["Land_HBarrier_01_big_tower_green_F", [2282.14,3575.74,0], 0],
	["Land_HBarrier_01_big_tower_green_F", [2280.73,3596.28,0.00133324], 180],
	["Land_HBarrier_01_big_tower_green_F", [2300.67,3596.42,0], 180],
	["Box_IND_WpsLaunch_F", [2287.18,3584.11,0.358602], 90],
	["Box_East_WpsLaunch_F", [2287.2,3582.52,0.358602], 90],
	["Box_NATO_WpsLaunch_F", [2287.24,3580.91,0.358602], 90],
	["Box_Syndicate_WpsLaunch_F", [2287.33,3579.44,0.358602], 90],
	["Box_IND_WpsSpecial_F", [2293.03,3578.75,0.359672], 0],
	["Box_T_East_WpsSpecial_F", [2293.04,3579.42,0.358602], 0],
	["Box_East_WpsSpecial_F", [2293.04,3580.11,0.358602], 0],
	["Box_T_NATO_WpsSpecial_F", [2293.04,3580.8,0.358602], 0],
	["Box_NATO_WpsSpecial_F", [2293.05,3581.48,0.358602] 0],
	["Box_AAF_Uniforms_F", [2289.33,3578.58,0.358602], 270],
	["Box_CSAT_Uniforms_F", [2289.31,3579.18,0.358602], 270],
	["Box_NATO_Uniforms_F", [2289.3,3579.79,0.358602], 270],
	["B_HMG_01_high_F", [2300.8,3597.27,2.28029], 90],
	["B_HMG_01_high_F", [2300.28,3574.02,2.28029], 180],
	["B_HMG_01_high_F", [2282.16,3575.01,2.28029], 180],
	["B_HMG_01_high_F", [2280.85,3597.61,2.28293], 0],
	["B_GMG_01_high_F", [2295.33,3596.24,2.78], 0],
	["B_GMG_01_high_F", [2287.94,3596.59,2.77909], 0],
	["B_T_Mortar_01_F", [2286.12,3587.21,5.72205e-006], 0],
	["B_T_Mortar_01_F", [2294.07,3587.14,5.72205e-006], 0],
	["B_T_Static_AA_F", [2295.26,3591.67,2.78], 125.079],
	["B_T_Static_AA_F", [2286.4,3592.04,2.77706], 242.318]
]