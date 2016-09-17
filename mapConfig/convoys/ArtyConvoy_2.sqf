// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: PatrolConvoy_1.sqf
//	@file Author: [GoT] JoSchaap, [404] Del1te, AgentRev, LouD
//	@file Created: 13/02/2014 22:52

// starting positions for this route
_starts =
[
	[23053,18927,0],
	[23068,18933,149.81],
	[23053,18940,0],
	[23053,18954,0],
	[23042,18965,99.81],
	[23053,18973,0],
	[23053,18990,0],
	[23076,19000,49.81],
	[23052,19006,0],
	[23053,19024,0]
	
];

// starting directions in which the vehicles are spawned on this route
_startDirs =
[
	180,
	180,
    180,
	180,
	180,
	180,
	180,
	180,
	180,
	180
];

// the route
_waypoints =
[
	[23052.715, 18896.807], // Start
	[22980.904, 18788.453],
	[22844.98, 18673.688],
	[22642.373, 18566.609],
	[22645.943, 18267.176],
	[22819.709, 18025.094],
	[22940.01, 17760.738],
	[23021.699, 17423.609],
	[23060.313, 17242.42],
	[23256.354, 17267.666],
	[23459.822, 17245.389],
	[23719.725, 17188.953],
	[23926.002, 17141.758],
	[24058.502, 17117.305],
	[24092.619, 17387.422],
	[24146.076, 17593.846],
	[24187.984, 17754.559],
	[24194.572, 17932.385],
	[24201.158, 18129.969],
	[24311.807, 18359.166],
	[24471.191, 18621.291],
	[24613.455, 18830.732],
	[24521.252, 19008.557],
	[24247.268, 19050.705],
	[24014.119, 19202.189],
	[23825.76, 19291.76],
	[23584.709, 19312.836],
	[23339.707, 19240.391],
	[23092.068, 19078.375], // End
	[23052.715, 18896.807], // Start
	[22980.904, 18788.453],
	[22844.98, 18673.688],
	[22642.373, 18566.609],
	[22645.943, 18267.176],
	[22819.709, 18025.094],
	[22940.01, 17760.738],
	[23021.699, 17423.609],
	[23060.313, 17242.42],
	[23256.354, 17267.666],
	[23459.822, 17245.389],
	[23719.725, 17188.953],
	[23926.002, 17141.758],
	[24058.502, 17117.305],
	[24092.619, 17387.422],
	[24146.076, 17593.846],
	[24187.984, 17754.559],
	[24194.572, 17932.385],
	[24201.158, 18129.969],
	[24311.807, 18359.166],
	[24471.191, 18621.291],
	[24613.455, 18830.732],
	[24521.252, 19008.557],
	[24247.268, 19050.705],
	[24014.119, 19202.189],
	[23825.76, 19291.76],
	[23584.709, 19312.836],
	[23339.707, 19240.391],
	[23092.068, 19078.375] // End
];
