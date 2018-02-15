/*
Author: BIB_Monkey
Filename: createrandomlootcrate.sqf
Purpose: create random loot creates based on Faction, teir, and money
*/
#define RANDOM_BETWEEN(START,END) ((START) + floor random ((END) - (START) + 1))
//Input Params
private _location = _this select 0;
private _Faction = _this select 1;
private _Tier = _this select 2;
private _MinMoney = _this select 3;
private _MaxMoney = _this select 4;
// Initalize variables
private _CrateSelect = "";
private _LootSelect = "";

//Chose the lootz
	switch (_Tier) do
	{
		case "1":
		{
			_LootSelect = selectRandom
			[
				"Mission_PMPistol",
				"Mission_P07Pistol",
				"Mission_ZuberPistol",
				"Mission_RookPistol",
				"Mission_PDW",
				"Mission_45Pistol",
				"Mission_ZuberPistol",
				"Mission_Sting",
				"Mission_Vermin",
				"Mission_Protector",
				"Mission_SDAR",
				"Mission_Mk20",
				"Mission_TRG",
				"Mission_Katiba",
				"Mission_MX",
				"Mission_SPAR16",
				"Mission_CAR95",
				"Mission_MXSW",
				"Mission_Mk200",
				"Mission_SPAR16S",
				"Mission_CAR951",
				"Mission_LIM"
			];
		};
		case "2":
		{
			_LootSelect = selectRandom
			[
				"Mission_AK",
				"Mission_MXM",
				"Mission_Mk18",
				"Mission_CMR76",
				"Mission_SPAR17",
				"Mission_MK14",
				"Mission_MK1",
				"Mission_MAR10",
				"Mission_Syrus",
				"Mission_M320",
				"Mission_Lynx",
				"Mission_ASP",
				"Mission_Zafir",
				"Mission_SPMG",
				"Mission_NAVID",
				"Mission_RPG7",
				"Mission_RPG42",
				"Mission_PCML"
			];
		};
		case "3":
		{
			switch (_faction) do
			{
				case "NATO":
				{
					_LootSelect = selectRandom
					[
						"Mission_NATO_TitanAA",
						"Mission_NATO_TitanAT"
					];
				};
				case "CSAT":
				{
					_LootSelect = selectRandom
					[
						"Mission_CSAT_TitanAA",
						"Mission_CSAT_TitanAT"
					];
				};
				case "AAF":
				{
					_LootSelect = selectRandom
					[
						"Mission_AAF_TitanAA",
						"Mission_AAF_TitanAT"
					];
				};
			};
		};
	};
//Choose the box
	//Basic Weapons Crate
		if  
		(
			_LootSelect == "Mission_PMPistol" ||
			_LootSelect == "Mission_P07Pistol"|| 
			_LootSelect == "Mission_ZuberPistol"|| 
			_LootSelect == "Mission_RookPistol"|| 
			_LootSelect == "Mission_PDW"|| 
			_LootSelect == "Mission_45Pistol"|| 
			_LootSelect == "Mission_ZuberPistol"|| 
			_LootSelect == "Mission_Sting"|| 
			_LootSelect == "Mission_Vermin"|| 
			_LootSelect == "Mission_Protector"|| 
			_LootSelect == "Mission_SDAR"|| 
			_LootSelect == "Mission_Mk20"|| 
			_LootSelect == "Mission_TRG"|| 
			_LootSelect == "Mission_Katiba"|| 
			_LootSelect == "Mission_MX"|| 
			_LootSelect == "Mission_SPAR16"|| 
			_LootSelect == "Mission_CAR95"|| 
			_LootSelect == "Mission_MXSW"|| 
			_LootSelect == "Mission_Mk200"|| 
			_LootSelect == "Mission_SPAR16S"|| 
			_LootSelect == "Mission_CAR951"|| 
			_LootSelect == "Mission_LIM"|| 
			_LootSelect == "Mission_AK"

		) then
		{
			switch (_faction) do
			{
				case "NATO":
				{
					_CrateSelect = selectrandom ["Box_T_NATO_Wps_F","Box_NATO_Wps_F"];
				};
				case "CSAT":
				{
					_CrateSelect = selectrandom ["Box_T_East_Wps_F","Box_East_Wps_F"];
				};
				case "AAF":
				{
					_CrateSelect = "Box_IND_Wps_F";
				};
			};
		};
	//Special Weapons crete
		if 
		(
			_LootSelect == "Mission_MXM"|| 
			_LootSelect == "Mission_Mk18"|| 
			_LootSelect == "Mission_CMR76"|| 
			_LootSelect == "Mission_SPAR17"|| 
			_LootSelect == "Mission_MK14"|| 
			_LootSelect == "Mission_MK1"|| 
			_LootSelect == "Mission_MAR10"|| 
			_LootSelect == "Mission_Syrus"|| 
			_LootSelect == "Mission_M320"|| 
			_LootSelect == "Mission_Lynx"|| 
			_LootSelect == "Mission_ASP"|| 
			_LootSelect == "Mission_Zafir"|| 
			_LootSelect == "Mission_SPMG"|| 
			_LootSelect == "Mission_NAVID"
		) then
		{
			switch (_faction) do
			{
				case "NATO":
				{
					_CrateSelect = selectrandom ["Box_T_NATO_WpsSpecial_F","Box_NATO_WpsSpecial_F"];
				};
				case "CSAT":
				{
					_CrateSelect = selectrandom ["Box_T_East_WpsSpecial_F","Box_East_WpsSpecial_F"];
				};
				case "AAF":
				{
					_CrateSelect = "Box_IND_WpsSpecial_F";
				};
			};
		};
	//Launchers Crate
		if 
		(
			_LootSelect == "Mission_RPG7"|| 
			_LootSelect == "Mission_RPG42"|| 
			_LootSelect == "Mission_PCML"||
			_LootSelect == "Mission_NATO_TitanAA"||
			_LootSelect == "Mission_NATO_TitanAT"||
			_LootSelect == "Mission_CSAT_TitanAA"||
			_LootSelect == "Mission_CSAT_TitanAT"||
			_LootSelect == "Mission_AAF_TitanAA"||
			_LootSelect == "Mission_AAF_TitanAT"
		) then
		{
			switch (_faction) do
			{
				case "NATO":
				{
					_CrateSelect = "Box_NATO_WpsLaunch_F";
				};
				case "CSAT":
				{
					_CrateSelect = "Box_East_WpsLaunch_F";
				};
				case "AAF":
				{
					_CrateSelect = "Box_IND_WpsLaunch_F";
				};
			};
		};
//Let's make some loot!
private _Money = RANDOM_BETWEEN(_MinMoney,_MaxMoney);
_crate = createVehicle [_CrateSelect, _location, [], 0, "NONE"];
[_crate, _LootSelect] call fn_refillbox;
_crate setVariable ["cmoney", _Money, true];
_crate

