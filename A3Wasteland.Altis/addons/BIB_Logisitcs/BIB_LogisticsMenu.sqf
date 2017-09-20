//Setupd Logistics menu
LogisticsMenu =
[
	["Logistics",true],
			["Adjust Object Up",				[73],		"AdjustObjectUp.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Adjust Object Down",				[71],		"AdjustObjectDown.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Adjust Object North",				[72],		"AdjustObjectNorth.sqf",				-5,		[["expression",		""]],	"1",	"1"],
			["Adjust Object South",				[82],		"AdjustObjectSouth.sqf",				-5,		[["expression",		""]],	"1",	"1"],
			["Ajust Object East",				[75],		"AdjustObjectEast.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Ajust Object West",				[77],		"AdjustObjectWest.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Rotate Object Right",				[79],		"RotateObjectCounterClockwise.sqf",		-5,		[["expression",		""]],	"1",	"1"],
			["Rotate Object Left",				[80],		"RotateObjectClockwise.sqf",				-5,		[["expression",		""]],	"1",	"1"],
			["Set Object to Ground",			[0],		"DroptoGround.sqf",			-5,		[["expression",		""]],	"1",	"1"],
			["Align Object Horizontally",		[0],		"AlignHorizontal.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Align Object To Terrain",			[0],		"AlightTerrain.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Tip object Direction X+",			[0],		"TipObjectXpos.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Tip Object Direction X-",			[0],		"TipObjectXneg.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Tip Object Direction Y+",			[0],		"TipObjectYpos.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Tip object Direction Y-",			[0],		"TipObjectYneg.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Tip Object Direction Z+",			[0],		"TipObjectZpos.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Tip Object Direction Z-",			[0],		"TipObjectZneg.sqf",					-5,		[["expression",		""]],	"1",	"1"],
			["Cancel Logistics",				[0],		"",										-3,		[["expression",		""]],	"1",	"1"]
];
showCommandingMenu "#USER:LogisticsMenu";
