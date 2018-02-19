//	@file Name: A3Wasteland_settings\admins.sqf

// Admin menu (U key) access levels

/*******************************************************
 Player UID examples :

	"1234567887654321", // Meatwad
	"8765432112345678", // Master Shake
	"1234876543211234", // Frylock
	"1337133713371337"  // Carl

 Important: The player UID must always be placed between
            double quotes (") and all lines need to have
            a comma (,) except the last one.
********************************************************/

// Low Administrators: manage & spectate players, remove hacked vehicles
lowAdmins =
[
	"76561198083874174" //FireFirstAce

];

// High Administrators: manage & spectate players, remove hacked vehicles, show player tags
highAdmins =
[
	"76561197968586068", //Dingus
	"76561198091057992", // Titus
	"76561197979953643", // Sayrus
	"76561198028001330", // Lava_Bear
	"76561197996525927", // Smokebreak
	"76561198123926911", //Turtle
	"76561198056978583", //Coolbreeze
	"76561197992118826" //Merc


];

// Server Owners: access to everything, including god mode, money, guns, and vehicles
serverOwners =
[
	// Put player UIDs here

	"76561198073390625", // Monkey
	"76561197960446555", // Masher
	"76561198068891152", // WitchDoctor/Alundy
	"76561198131057272" // Dreadedwraith
];
