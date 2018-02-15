// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_refillbox.sqf  "fn_refillbox"
//	@file Author: [404] Pulse , [404] Costlyy , [404] Deadbeat, AgentRev, BIB_Monkey
//	@file Created: 22/1/2012 00:00
//	@file Args: [OBJECT (Weapons box that needs filling), STRING (Name of the fill to give to object)]

if (!isServer) exitWith {};

#define RANDOM_BETWEEN(START,END) ((START) + floor random ((END) - (START) + 1))
#define RANDOM_ODDS(ODDS) ([0,1] select (random 1 < (ODDS))) // between 0.0 and 1.0

private ["_box", "_boxType", "_boxItems", "_item", "_qty", "_mag"];
_box = _this select 0;
_boxType = _this select 1;

_box setVariable [call vChecksum, true];

_box allowDamage false; // No more fucking busted crates
_box setVariable ["allowDamage", false, true];
_box setVariable ["A3W_inventoryLockR3F", true, true];

// Clear pre-existing cargo first
//clearBackpackCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
switch (_boxType) do
{
	//Mission Crates
		//Tier 1 crates
			case "Mission_PMPistol":
			{
				_boxItems =
				[
					["wep", "hgun_Pistol_01_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_P07Pistol":
			{
				_boxItems =
				[
					["wep", ["hgun_P07_F","hgun_P07_khk_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_ZuberPistol":
			{
				_boxItems =
				[
					["wep", "hgun_Pistol_heavy_02_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_RookPistol":
			{
				_boxItems =
				[
					["wep", "hgun_Rook40_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_PDW":
			{
				_boxItems =
				[
					["wep", "hgun_PDW2000_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_aco_smg","optic_ACO_grn_smg"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_45Pistol":
			{
				_boxItems =
				[
					["wep", "hgun_Pistol_heavy_01_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", "optic_MRD", RANDOM_BETWEEN(0,4)],
					["itm", "muzzle_snds_acp", RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_ZuberPistol":
			{
				_boxItems =
				[
					["wep", "hgun_Pistol_heavy_02_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", "optic_Yorris", RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Sting":
			{
				_boxItems =
				[
					["wep", "SMG_02_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_aco_smg","optic_ACO_grn_smg"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Vermin":
			{
				_boxItems =
				[
					["wep", "SMG_01_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_aco_smg","optic_ACO_grn_smg"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Protector":
			{
				_boxItems =
				[
					["wep", "SMG_05_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_aco_smg","optic_ACO_grn_smg"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_SDAR":
			{
				_boxItems =
				[
					["wep", "arifle_SDAR_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_Mk20":
			{
				_boxItems =
				[
						["wep", ["arifle_Mk20C_plain_F","arifle_Mk20C_F","arifle_Mk20_plain_F","arifle_Mk20_F","arifle_Mk20_GL_plain_F","arifle_Mk20_GL_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_TRG":
			{
				_boxItems =
				[
					["wep", ["arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Katiba":
			{
				_boxItems =
				[
					["wep", ["arifle_Katiba_C_F","arifle_Katiba_F","arifle_Katiba_GL_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_MX":
			{
				_boxItems =
				[
					["wep", ["arifle_MXC_F","arifle_MXC_Black_F","arifle_MXC_khk_F","arifle_MX_F","arifle_MX_Black_F","arifle_MX_khk_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_MX_GL_khk_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_SPAR16":
			{
				_boxItems =
				[
					["wep", ["arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_CAR95":
			{
				_boxItems =
				[
					["wep", ["arifle_CTAR_blk_F","arifle_CTAR_hex_F","arifle_CTAR_ghex_F","arifle_CTAR_GL_blk_F","arifle_CTAR_GL_hex_F","arifle_CTAR_GL_ghex_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_MXSW":
			{
				_boxItems =
				[
					["wep", ["arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Mk200":
			{
				_boxItems =
				[
					["wep", "LMG_Mk200_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_SPAR16S":
			{
				_boxItems =
				[
					["wep", ["arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_CAR951":
			{
				_boxItems =
				[
					["wep", ["arifle_CTARS_blk_F","arifle_CTARS_hex_F","arifle_CTARS_ghex_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_LIM":
			{
				_boxItems =
				[
					["wep", "LMG_03_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
		//Tier 2 crates
			case "Mission_AK":
			{
				_boxItems =
				[
					["wep", ["arifle_AKS_F","arifle_AKM_F","arifle_AK12_F","arifle_AK12_GL_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_Aco","optic_Aco_grn","optic_Holosight_smg","optic_Holosight","optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_MXM":
			{
				_boxItems =
				[
					["wep", ["arifle_MXM_F","arifle_MXM_Black_F","arifle_MXM_khk_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Mk18":
			{
				_boxItems =
				[
					["wep", "srifle_EBR_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_CMR76":
			{
				_boxItems =
				[
					["wep", ["srifle_DMR_07_blk_F","srifle_DMR_07_hex_F","srifle_DMR_07_ghex_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_SPAR17":
			{
				_boxItems =
				[
					["wep", ["arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_MK14":
			{
				_boxItems =
				[
					["wep", ["srifle_DMR_06_camo_F","srifle_DMR_06_olive_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_MK1":
			{
				_boxItems =
				[
					["wep", ["srifle_DMR_03_F","srifle_DMR_03_multicam_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_MAR10":
			{
				_boxItems =
				[
					["wep", ["srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Syrus":
			{
				_boxItems =
				[
					["wep", ["srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_M320":
			{
				_boxItems =
				[
					["wep", ["srifle_LRR_LRPS_F","srifle_LRR_camo_LRPS_F","srifle_LRR_tna_LRPS_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Lynx":
			{
				_boxItems =
				[
					["wep", ["srifle_GM6_LRPS_F","srifle_GM6_camo_LRPS_F","srifle_GM6_ghex_LRPS_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_ASP":
			{
				_boxItems =
				[
					["wep", ["srifle_DMR_04_F","srifle_DMR_04_tan_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_Zafir":
			{
				_boxItems =
				[
					["wep", "LMG_Zafir_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_SPMG":
			{
				_boxItems =
				[
					["wep", ["MMG_02_sand_F","MMG_02_camo_F","MMG_02_black_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_NAVID":
			{
				_boxItems =
				[
					["wep", ["MMG_01_tan_F","MMG_01_hex_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)],
					["itm", ["optic_MRCO","optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F","optic_Arco","optic_Arco_blk_F","optic_Arco_ghex_F","optic_Hamr","optic_Hamr_khk_F","optic_SOS","optic_SOS_khk_F","optic_DMS","optic_DMS_ghex_F","optic_KHS_old","optic_KHS_blk","optic_KHS_hex","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_LRPS","optic_LRPS_ghex_F","optic_LRPS_tna_F","optic_NVS"], RANDOM_BETWEEN(0,4)]
				];
			};
			case "Mission_RPG7":
			{
				_boxItems =
				[
					["wep", "launch_RPG7_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(5,10)]
				];
			};
			case "Mission_RPG42":
			{
				_boxItems =
				[
					["wep", ["launch_RPG32_F","launch_RPG32_ghex_F"], RANDOM_BETWEEN(2,4),0],
					["mag", ["RPG32_F","RPG32_HE_F"], RANDOM_BETWEEN(5,10)]
				];
			};
			case "Mission_PCML":
			{
				_boxItems =
				[
					["wep", "launch_NLAW_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
		//Tier 3 crates
			case "Mission_AAF_TitanAA":
			{
				_boxItems =
				[
					["wep", "launch_I_Titan_F", RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_AAF_TitanAT":
			{
				_boxItems =
				[
					["wep", "launch_I_Titan_short_F", RANDOM_BETWEEN(1,2), 0],
					["mag", ["Titan_AT","Titan_AP"], RANDOM_BETWEEN(2,4)]
				];
			};
			case "Mission_NATO_TitanAA":
			{
				_boxItems =
				[
					["wep", ["launch_Titan_F","launch_B_Titan_tna_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_NATO_TitanAT":
			{
				_boxItems =
				[
					["wep", ["launch_Titan_short_F","launch_B_Titan_short_tna_F"], RANDOM_BETWEEN(1,2), 0],
					["mag", ["Titan_AT","Titan_AP"], RANDOM_BETWEEN(2,4)]
				];
			};
			case "Mission_CSAT_TitanAA":
			{
				_boxItems =
				[
					["wep", ["launch_O_Titan_F","launch_O_Titan_ghex_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(8,16)]
				];
			};
			case "Mission_CSAT_TitanAT":
			{
				_boxItems =
				[
					["wep", ["launch_O_Titan_short_F","launch_O_Titan_short_ghex_F"], RANDOM_BETWEEN(1,2), 0],
					["mag", ["Titan_AT","Titan_AP"], RANDOM_BETWEEN(2,4)]
				];
			};







/*
	case "mission_USLaunchers": // default wasteland launchers loot crate
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			//Weapons
			["wep", ["launch_RPG32_F", "launch_NLAW_F", "launch_Titan_short_F"], RANDOM_BETWEEN(3,5), RANDOM_BETWEEN(1,2)],
			["wep", "launch_Titan_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			//Mags
			["mag", ["ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(3,8)]
		];
	};
	case "mission_USSpecial": //default wasteland generic loot crate
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			//Weapons
			["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(1,5)],
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_MRD_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_Yorris_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,5)],
			["wep", ["arifle_MXM_F", "srifle_EBR_F", "srifle_DMR_01_DMS_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["LMG_Mk200_F", "LMG_Zafir_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)],
			//Items
			["itm", "Medikit", RANDOM_BETWEEN(0,3)],
			["itm", "Toolkit", RANDOM_BETWEEN(0,3)],
			["itm", ["optic_MRCO", "optic_Arco", "optic_Hamr", "optic_SOS"], RANDOM_BETWEEN(0,2)],
			["itm", ["muzzle_snds_M", "muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B", "muzzle_snds_acp"], RANDOM_BETWEEN(0,3)],
			//Mags
			["mag", "30Rnd_556x45_Stanag", RANDOM_BETWEEN(4,8)],
			["mag", "30Rnd_65x39_caseless_mag", RANDOM_BETWEEN(4,8)],
			["mag", "30Rnd_65x39_caseless_green", RANDOM_BETWEEN(4,8)],
			["mag", "9Rnd_45ACP_Mag", RANDOM_BETWEEN(1,5)]
		];
	};
	case "Launchers_Tier_2":
	{
		_boxItems =
		[
			//Weapons
			["wep", "launch_RPG32_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(3,4)],
			["wep", "launch_NLAW_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(3,4)],
			["wep", "launch_Titan_short_F", RANDOM_BETWEEN(2,3), RANDOM_BETWEEN(3,4)],
			["wep", "launch_Titan_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(3,4)],
			//Items
			["bac", ["B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_oli", "B_Carryall_mcamo", "B_Carryall_oucamo"], RANDOM_BETWEEN(1,3)]
			//["bac", ["B_Bergen_dgtl_F", "B_Bergen_hex_F", "B_Bergen_mcamo_F", "B_Bergen_tna_F"], RANDOM_BETWEEN(0,3)]

		];

	};
	case "Diving_Gear":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			//Weapons
			["wep", "arifle_SDAR_F", 2, RANDOM_BETWEEN(4,6)],
			//Items
			["itm", "V_RebreatherB", 2],
			["itm", "V_RebreatherIR", 2],
			["itm", "V_RebreatherIA", 2],
			["itm", "G_Diving", 2],
			["itm", "U_B_Wetsuit", 2],
			["itm", "U_O_Wetsuit", 2],
			["itm", "U_I_Wetsuit", 2],
			["itm", ["Chemlight_red", "Chemlight_green", "Chemlight_yellow", "Chemlight_blue"], RANDOM_BETWEEN(6,9)],
			["bac", ["B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_oli", "B_Carryall_mcamo", "B_Carryall_oucamo"], RANDOM_BETWEEN(3,5)],
			//Mags
			["mag", ["SmokeShell", "SmokeShellRed", "SmokeShellgreen"], RANDOM_BETWEEN(5,9)]

		];
	};
	case "General_supplies":
	{
	_boxitems =
		[
			//first aid, medkit, tookit, gps, rangefinder, etc
			// Item type, Item class(es), # of items, # of magazines per weapon
			["itm", "FirstAidKit", RANDOM_BETWEEN(5,6)],
			["wep", ["Rangefinder", "Laserdesignator"], RANDOM_BETWEEN(3,5)],
			["wep", ["hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_01_MRD_F", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_Yorris_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,5)],
			["itm", "Medikit", RANDOM_BETWEEN(2,3)],
			["itm", "Toolkit", RANDOM_BETWEEN(2,3)],
			["itm", "Laserbatteries", RANDOM_BETWEEN(0,4)],
			["itm", ["H_CrewHelmetHeli_B","H_CrewHelmetHeli_O", "H_CrewHelmetHeli_I"], RANDOM_BETWEEN(2,4)],
			["bac", ["B_Kitbag_mcamo", "B_Bergen_sgg", "B_FieldPack_khk", "B_Carryall_mcamo"], RANDOM_BETWEEN(3,5)],
			["itm", ["V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(2,4)],
			//["itm", ["V_PlateCarrierGL_blk", "V_PlateCarrierGL_rgr", "V_PlateCarrierGL_mtp", "V_PlateCarrierGL_tna_F"], RANDOM_BETWEEN(1,4)],
			//["itm", ["V_PlateCarrier1_blk", "V_PlateCarrierL_CTRG", "V_PlateCarrier1_rgr_noflag_F", "V_PlateCarrier1_rgr", "V_PlateCarrier1_tna_F"], RANDOM_BETWEEN(1,4)],
			//["itm", ["V_PlateCarrier2_blk", "V_PlateCarrierH_CTRG", "V_PlateCarrier2_rgr", "V_PlateCarrier2_tna_F"], RANDOM_BETWEEN(1,4)],
			//["itm", ["V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_mtp", "V_PlateCarrierSpec_tna_F"], RANDOM_BETWEEN(1,4)],
			["itm", ["Chemlight_red", "Chemlight_green", "Chemlight_yellow", "Chemlight_blue"], RANDOM_BETWEEN(6,9)],
			["mag", ["SmokeShell", "SmokeShellRed", "SmokeShellgreen"], RANDOM_BETWEEN(5,9)]
		];
	};
	Case "GEVP":
	{

		_boxItems =
		[
			//Weapons
			["wep", ["srifle_EBR_ARCO_pointer_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(10,12)],
			["wep", ["srifle_DMR_03_ARCO_F", "srifle_DMR_03_SOS_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(10,12)],
			["wep", ["srifle_DMR_06_camo_khs_F", "srifle_DMR_06_olive_F", "srifle_DMR_06_camo_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(10,12)],
            ["wep", ["MMG_01_hex_ARCO_LP_F", "MMG_01_tan_F", "MMG_01_hex_F"], RANDOM_BETWEEN(1,1), RANDOM_BETWEEN(2,4)],
			["wep", ["MMG_02_camo_F", "MMG_02_black_F", "MMG_02_sand_F", "MMG_02_sand_RCO_LP_F", "MMG_02_black_RCO_BI_F"], RANDOM_BETWEEN(1,1), RANDOM_BETWEEN(2,4)],
			["wep", ["LMG_Mk200_MRCO_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(2,5)],
            ["wep", ["srifle_DMR_05_DMS_snds_F", "srifle_DMR_05_KHS_LP_F", "srifle_DMR_05_DMS_F", "srifle_DMR_05_SOS_F", "srifle_DMR_05_MRCO_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(6,10)],
			["wep", ["LMG_Zafir_ARCO_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(2,5)],
			["wep", ["srifle_DMR_01_SOS_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(5,10)],
			["wep", ["Launch_NLAW_F"], RANDOM_BETWEEN(2,2), RANDOM_BETWEEN(4,6)],
			["wep", ["launch_B_Titan_short_F", "launch_I_Titan_short_F", "launch_O_Titan_short_F", "launch_Titan_short_F"], RANDOM_BETWEEN(2,3), RANDOM_BETWEEN(2,6)],
            ["wep", ["launch_B_Titan_F", "launch_I_Titan_F", "launch_O_Titan_F", "launch_Titan_F"], RANDOM_BETWEEN(2,2), RANDOM_BETWEEN(2,4)],
            ["wep", ["srifle_LRR_SOS_F"], RANDOM_BETWEEN(2,3), RANDOM_BETWEEN(8,14)],
			//Items
			//["itm", ["H_HelmetSpecO_blk", "H_HelmetSpecO_ocamo", "H_HelmetSpecO_ghex_F"], RANDOM_BETWEEN(0,2)],
			//["itm", ["H_HelmetLeaderO_ghex_F", "H_HelmetLeaderO_ocamo", "H_HelmetLeaderO_oucamo"], RANDOM_BETWEEN(0,2)],
			//["itm", ["H_CrewHelmetHeli_I", "H_CrewHelmetHeli_O", "H_HelmetCrew_O_ghex_F","H_CrewHelmetHeli_B"], RANDOM_BETWEEN(0,2)],
			//["itm", ["H_PilotHelmetHeli_I", "H_PilotHelmetHeli_O", "H_PilotHelmetHeli_B",], RANDOM_BETWEEN(0,2)],
			//["itm", ["H_PilotHelmetFighter_I","H_PilotHelmetFighter_O", "H_PilotHelmetFighter_B"], RANDOM_BETWEEN(0,2)],
			//["itm", ["H_HelmetO_ocamo","H_HelmetO_ghex_F","H_HelmetO_oucamo"], RANDOM_BETWEEN(0,2)],
			//["itm", ["H_HelmetB_TI_tna_F", "H_HelmetB_TI_tna_F"], RANDOM_BETWEEN(0,2)],
            ["itm", ["H_HelmetB_light_sand", "H_HelmetB_light_desert", "H_HelmetB_light_grass"], RANDOM_BETWEEN(3,5)],
            ["itm", ["H_HelmetB_camo", "H_HelmetB"], RANDOM_BETWEEN(4,6)],
			["itm", ["H_Shemag_khk", "H_Shemag_olive_hs"], RANDOM_BETWEEN(0,1)],
            ["bac", ["B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_oli", "B_Carryall_mcamo", "B_Carryall_oucamo"], RANDOM_BETWEEN(3,4)],
			["bac", ["B_Bergen_dgtl_F", "B_Bergen_hex_F", "B_Bergen_mcamo_F", "B_Bergen_tna_F"], RANDOM_BETWEEN(1,3)],
			["itm",	["V_PlateCarrierIAGL_dgtl", "V_PlateCarrierIA2_dgtl", "V_PlateCarrierGL_rgr"], RANDOM_BETWEEN(1,4)],
			["itm", ["V_TacVest_brn", "V_TacVest_blk_POLICE", "V_TacVest_blk", "V_TacVest_brn", "V_TacVest_brn", "V_TacVest_khk", "V_TacVest_oli"], RANDOM_BETWEEN(1,4)],
			//["itm", ["V_PlateCarrierGL_blk", "V_PlateCarrierGL_rgr", "V_PlateCarrierGL_mtp", "V_PlateCarrierGL_tna_F"], RANDOM_BETWEEN(1,4)],
			//["itm", ["V_PlateCarrier1_blk", "V_PlateCarrierL_CTRG", "V_PlateCarrier1_rgr_noflag_F", "V_PlateCarrier1_rgr", "V_PlateCarrier1_tna_F"], RANDOM_BETWEEN(1,4)],
			//["itm", ["V_PlateCarrier2_blk", "V_PlateCarrierH_CTRG", "V_PlateCarrier2_rgr", "V_PlateCarrier2_tna_F"], RANDOM_BETWEEN(1,4)],
			//["itm", ["V_PlateCarrierSpec_blk", "V_PlateCarrierSpec_rgr", "V_PlateCarrierSpec_mtp", "V_PlateCarrierSpec_tna_F"], RANDOM_BETWEEN(1,4)],
			["itm", ["optic_LRPS", "optic_SOS"], RANDOM_BETWEEN(2,3)],
			//["itm", ["optic_Nightstalker", "optic_tws"], RANDOM_BETWEEN(0,2)],
			["itm", ["muzzle_snds_H_MG"], RANDOM_BETWEEN(1,2)],
			["itm", ["muzzle_snds_B"], RANDOM_BETWEEN(1,3)],
			["itm", ["bipod_01_F_snd", "bipod_01_F_blk", "bipod_01_F_mtp"], RANDOM_BETWEEN(2,4)],
			["itm", ["bipod_02_F_blk", "bipod_02_F_tan", "bipod_02_F_hex"], RANDOM_BETWEEN(2,4)],
			["itm", ["bipod_03_F_blk", "bipod_03_F_oli"], RANDOM_BETWEEN(3,4)],
			["itm", ["muzzle_snds_93mmg", "muzzle_snds_93mmg_tan"], RANDOM_BETWEEN(1,2)],
			["itm", ["muzzle_snds_338_sand", "muzzle_snds_338_green", "muzzle_snds_338_black"], RANDOM_BETWEEN(1,2)]

		];
	};

	case "Ammo_Drop":
	{
		_boxitems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["mag", ["16Rnd_9x21_Mag", "30Rnd_9x21_Mag", "6Rnd_45ACP_Cylinder", "11Rnd_45ACP_Mag", "9Rnd_45ACP_Mag"], RANDOM_BETWEEN(15,20)],
			["mag", ["30Rnd_45ACP_MAG_SMG_01", "30Rnd_45ACP_Mag_SMG_01_tracer_green"], RANDOM_BETWEEN(10,15)],
			["mag", ["20Rnd_556x45_UW_mag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_Tracer_Green"], RANDOM_BETWEEN(10,11)],
			["mag", ["30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_556x45_Stanag_Tracer_Red"], RANDOM_BETWEEN(10,11)],
			["mag", ["30Rnd_65x39_caseless_mag", "30Rnd_65x39_caseless_mag_Tracer"], RANDOM_BETWEEN(10,15)],
			["mag", ["30Rnd_65x39_caseless_green", "30Rnd_65x39_caseless_green_mag_Tracer"], RANDOM_BETWEEN(10,15)],
			["mag", ["100Rnd_65x39_caseless_mag", "100Rnd_65x39_caseless_mag_Tracer"], RANDOM_BETWEEN(7,10)],
			["mag", ["200Rnd_65x39_cased_Box", "200Rnd_65x39_cased_Box_Tracer"], RANDOM_BETWEEN(7,10)],
			["mag","10Rnd_762x54_Mag", 10],
			["mag","20Rnd_762x51_Mag", 10],
			["mag", ["150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer"], 10],
			["mag","10Rnd_338_Mag", 10],
			["mag","130Rnd_338_Mag", 10],
			["mag","7Rnd_408_Mag", 10],
			["mag","10Rnd_93x64_DMR_05_Mag", 10],
			["mag","150Rnd_93x64_Mag", 10],
			["mag","10Rnd_127x54_Mag", 10],
			["mag", ["5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag"], RANDOM_BETWEEN(10,15)],
			["mag","SmokeShellyellow", RANDOM_BETWEEN(3,6)],
			["mag", ["1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell"], RANDOM_BETWEEN(8,10)],
			["mag", ["3Rnd_HE_Grenade_shell","3Rnd_Smoke_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell", "3Rnd_SmokeGreen_Grenade_shell", "3Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell","3Rnd_SmokeRed_Grenade_shell"], RANDOM_BETWEEN(8,10)],
			["mag", ["UGL_FlareWhite_F", "UGL_FlareGreen_F","UGL_FlareYellow_F","UGL_FlareRed_F","UGL_FlareCIR_F", "3Rnd_UGL_FlareWhite_F", "3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareYellow_F", "3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareCIR_F"], RANDOM_BETWEEN(10,15)]

		];
	};
	case "mission_AALauncher":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["launch_Titan_F", "launch_O_Titan_F", "launch_I_Titan_F"], RANDOM_BETWEEN(1,5), RANDOM_BETWEEN(10,20)]
		];
	};
	case "mission_CompactLauncher":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["launch_Titan_short_F", "launch_O_Titan_short_F", "launch_I_Titan_short_F"], RANDOM_BETWEEN(1,5), RANDOM_BETWEEN(10,20)]
			//["mag", "Titan_AP", RANDOM_BETWEEN(0,2)]
		];
	};
	case "mission_snipers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F", "srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["srifle_EBR_F", "srifle_DMR_01_F", "srifle_DMR_03_F", "srifle_DMR_06_camo_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["srifle_DMR_04_F", "srifle_DMR_04_tan_F"], RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(10,12)],
			["mag", "5Rnd_127x108_APDS_Mag", RANDOM_BETWEEN(12,20)],
			["wep", "Rangefinder", RANDOM_BETWEEN(1,3)],
			//["wep", "Laserdesignator", "Laserdesignator_01_khk_F", "Laserdesignator_02_ghex_F", "Laserdesignator_02", "Laserdesignator_03",  RANDOM_BETWEEN(0,1)],
			["itm", "optic_DMS", RANDOM_BETWEEN(1,2)],
			["itm", "optic_SOS", RANDOM_BETWEEN(1,2)],
			["itm", "optic_AMS", RANDOM_BETWEEN(1,2)],
			["itm", "optic_KHS_blk", RANDOM_BETWEEN(1,2)],
			["itm", "optic_LRPS", RANDOM_BETWEEN(1,2)],
			//["itm", "optic_tws", RANDOM_BETWEEN(0,1)],
			//["itm", "optic_Nightstalker", RANDOM_BETWEEN(0,1)],
			["itm", "muzzle_snds_338_black", "muzzle_snds_338_green", "muzzle_snds_338_sand", RANDOM_BETWEEN(1,2)],
			["itm", "muzzle_snds_93mmg","muzzle_snds_93mmg_tan", RANDOM_BETWEEN(1,2)],
			["itm", "bipod_01_F_blk", "bipod_02_F_hex", "bipod_03_F_oli","bipod_01_F_snd","bipod_02_F_tan","bipod_01_F_khk", RANDOM_BETWEEN(2,4)]
			//["itm", "U_B_CTRG_Soldier_F", "U_O_V_Soldier_Viper_F", "U_O_V_Soldier_Viper_hex_F", RANDOM_BETWEEN(0,2)]
			//["itm", "U_B_FullGhillie_ard", "U_B_FullGhillie_lsh", "U_B_FullGhillie_sard", RANDOM_BETWEEN(0,2)]
			//["itm", "U_I_FullGhillie_ard", "U_I_FullGhillie_lsh", "U_I_FullGhillie_sard", RANDOM_BETWEEN(0,2)]
			//["itm", "U_O_FullGhillie_ard", "U_O_FullGhillie_lsh", "U_O_FullGhillie_sard", RANDOM_BETWEEN(0,2)]
			//["itm", "G_Balaclava_TI_blk_F", 0"G_Balaclava_TI_G_blk_F", "G_Balaclava_TI_tna_F", "G_Balaclava_TI_G_tna_F", RANDOM_BETWEEN(1,4)]
		];
	};
	case "mission_RPG":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", "launch_RPG32_F", RANDOM_BETWEEN(1,5), RANDOM_BETWEEN(8,12)],
			["mag", "RPG32_HE_F", RANDOM_BETWEEN(8,12)]
		];
	};
	case "mission_PCML":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", "NLAW_F", RANDOM_BETWEEN(1,5), RANDOM_BETWEEN(10,20)]
		];
	};
	case "mission_Pistols":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", "hgun_P07_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "hgun_Rook40_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "hgun_ACPC2_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "hgun_Pistol_heavy_02_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "hgun_Pistol_heavy_01_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["itm", "muzzle_snds_acp", RANDOM_BETWEEN(2,4)],
			["itm", "muzzle_snds_L", RANDOM_BETWEEN(2,4)],
			["itm", "muzzle_snds_L", RANDOM_BETWEEN(2,4)],
			["itm", "muzzle_snds_L", RANDOM_BETWEEN(2,4)],
			["itm", "optic_Yorris", RANDOM_BETWEEN(2,4)],
			["itm", "optic_MRD", RANDOM_BETWEEN(2,4)]
		];
	};
	case "mission_AssRifles":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["arifle_Mk20C_plain_F", "arifle_Mk20C_F", "arifle_Mk20_plain_F", "arifle_Mk20_F", "arifle_Mk20_GL_plain_F", "arifle_Mk20_GL_F"], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", ["arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F"], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", ["arifle_Katiba_C_F", "arifle_Katiba_F", "arifle_Katiba_GL_F"], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", ["arifle_MXC_F", "arifle_MXC_Black_F", "arifle_MX_F", "arifle_MX_Black_F", "arifle_MX_GL_F", "arifle_MX_GL_Black_F"], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", ["arifle_MXM_F", "arifle_MXM_Black_F", "srifle_DMR_01_F", "srifle_EBR_F"], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["itm", "optic_MRCO", RANDOM_BETWEEN(2,4)],
			["itm", "optic_Arco", RANDOM_BETWEEN(2,4)],
			["itm", "optic_Hamr", RANDOM_BETWEEN(2,4)],
			["itm", "optic_DMS", RANDOM_BETWEEN(2,4)]
		];
	};
	case "mission_SMGs":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", "hgun_PDW2000_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "SMG_02_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "SMG_01_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["itm", "muzzle_snds_L", RANDOM_BETWEEN(2,4)],
			["itm", "optic_aco_smg", RANDOM_BETWEEN(2,4)]
		];
	};
	case "mission_LMGs":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["arifle_MX_SW_F", "arifle_MX_SW_Black_F"], RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "LMG_Mk200_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", "LMG_Zafir_F", RANDOM_BETWEEN(2,5), RANDOM_BETWEEN(5,10)],
			["wep", ["MMG_02_sand_F", "MMG_02_camo_F","MMG_02_black_F","MMG_01_tan_F", "MMG_01_hex_F"], RANDOM_BETWEEN(2,4), RANDOM_BETWEEN(4,8)]
		];
	};
	case "Medical":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["itm", "Medikit", RANDOM_BETWEEN(10,20)],
			["itm", "FirstAidKit", RANDOM_BETWEEN(10,20)]
		];
	};
	case "mission_Field_Engineer": 
	{	
		_boxItems = 
		[
			["itm", "Toolkit", 30],
			["itm", "MineDetector", 20]
		];
	};
*/
	//Airdrop Crates
		case "airdrop_Rifles":
		{
			_boxItems =
			[
				// Item type, Item class(es), # of items, # of magazines per weapon
				//weapons
				["wep", ["arifle_MXC_F", "arifle_MXC_Black_F", "arifle_MX_F", "arifle_MX_Black_F", "arifle_MX_GL_F", "arifle_MX_GL_Black_F"], 2,6],
				["wep", ["arifle_Mk20C_plain_F", "arifle_Mk20C_F", "arifle_Mk20_plain_F", "arifle_Mk20_F", "arifle_Mk20_GL_plain_F", "arifle_Mk20_GL_F"], 2,6],
				["wep", ["arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F"], 2,6],
				["wep", ["arifle_Katiba_C_F", "arifle_Katiba_F", "arifle_Katiba_GL_F"], 2,6],
				//items
				["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], 3]
			];
		};
		case "airdrop_LMGs":
		{
			_boxItems =
			[
				// Item type, Item class(es), # of items, # of magazines per weapon
				//weapons
				["wep", ["MMG_02_black_F", "MMG_01_hex_F"], 2,5],
				["wep", ["arifle_MX_SW_F", "arifle_MX_SW_Black_F"], 2,5],
				["wep", "LMG_Mk200_F", 2,5],
				["wep", "LMG_Mk200_F", 2,5],
				["wep", "LMG_Zafir_F", 2,5],
				["wep", ["MMG_01_tan_F", "MMG_01_hex_F"], 2,5],
				//items
				["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], 2]
			];
		};
		case "airdrop_Snipers":
		{
			_boxItems =
			[
				// Item type, Item class(es), # of items, # of magazines per weapon
				//weapons
				["wep", ["srifle_GM6_LRPS_F", "srifle_GM6_camo_LRPS_F"], 2,0],
				["wep", ["srifle_LRR_LRPS_F", "srifle_LRR_camo_LRPS_F"], 2,10],
				["wep", "Laserdesignator", 4],
				//Mags
				["mag", "5Rnd_127x108_APDS_Mag", 20],
				//Items
				["itm", "optic_tws", 4]
			];
		};
		case "airdrop_Launchers":
		{
			_boxItems =
			[
				// Item type, Item class(es), # of items, # of magazines per weapon
				//Weapons
				["wep", "launch_RPG32_F", 2,4],
				["wep", "launch_NLAW_F", 2,4],
				["wep", "launch_Titan_short_F", 2,4],
				["wep", "launch_Titan_F", 2,4],
				//Mags
				["mag", "RPG32_HE_F", 8],
				["mag", "Titan_AP", 4]
			];
		};
		case "airdrop_Medical":
		{
			_boxItems =
			[
				// Item type, Item class(es), # of items, # of magazines per weapon
				["itm", "Medikit", 30],
				["itm", "FirstAidKit", 40]
			];
		};
		case "airdrop_Diving_Gear": //diving equipment for squad of 2
		{
			_boxItems =
			[
				// Item type, Item class(es), # of items, # of magazines per weapon
				//weapons
				["wep", "arifle_SDAR_F", 2,5],
				//items
				["itm", "V_RebreatherB", 2],
				["itm", "V_RebreatherIR", 2],
				["itm", "V_RebreatherIA", 2],
				["itm", "G_Diving", 2],
				["itm", "U_B_Wetsuit", 2],
				["itm", "U_O_Wetsuit", 2],
				["itm", "U_I_Wetsuit", 2],
				["bac", ["B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_oli", "B_Carryall_mcamo"], 2]
			];
		};
		case "airdrop_Field_Engineer": 
		{	
			_boxItems = 
			[
				["itm", "Toolkit", 30],
				["itm", "MineDetector", 20]
			];
		};
};

[_box, _boxItems] call processItems;

if (["A3W_artilleryStrike"] call isConfigOn) then
{
	if (random 1.0 < ["A3W_artilleryCrateOdds", 1/10] call getPublicVar) then
	{
		_box setVariable ["artillery", 1, true];
	};
};
