/*
	OKInit.sqf by Vampire & bap
	This is the file that every other file branches off from.
	It checks that it is safe to run, sets relations, and starts mission timers.
*/
private["_modVariant"];

waitUntil{initialized};

// Lets let the heavier scripts run first
sleep 60;

// Error Check
if (!isServer) exitWith { diag_log format ["[OK]: <ERROR> OK is Installed Incorrectly! OK is not Running!"]; };
if (!isnil("OKInstalled")) exitWith { diag_log format ["[OK]: <ERROR> OK is Installed Twice or Installed Incorrectly!"]; };

// Global for other scripts to check if OK is installed.
OKInstalled = true;

diag_log format ["[OK]: Starting Overkill."];

// Let's see if we need to set relationships
// Checking for DayZAI, SargeAI, and WickedAI (Three AI Systems that already set relations)
// I would rather the user set their relations in the respective mod instead of overwrite them here.
if ( (isnil("DZAI_isActive")) && (isnil("SAR_version")) && (isnil("WAIconfigloaded")) ) then
{

	// They weren't found, so let's set relationships
	diag_log format ["[OK]: Relations not found! Using OK Relations."];
	
	// Create the groups if they aren't created already
	createCenter east;
	// Make AI Hostile to Survivors
	WEST setFriend [EAST,0];
	EAST setFriend [WEST,0];
	// Make AI Hostile to Zeds
	EAST setFriend [CIVILIAN,0];
	CIVILIAN setFriend [EAST,0];
	
} else {

	// Let's inform the user which relations we are using
	OKRelations = 0; //Set our counter variable
	if (!isnil("DZAI_isActive")) then {
		diag_log format ["[OK]: DZAI Found! Using DZAI's Relations!"];
		OKRelations = OKRelations + 1;
	};
	if (!isnil("SAR_version")) then {
		diag_log format ["[OK]: SargeAI Found! Using SargeAI's Relations!"];
		OKRelations = OKRelations + 1;
	};
	if (!isnil("WAIconfigloaded")) then {
		diag_log format ["[OK]: WickedAI Found! Using WickedAI's Relations!"];
		OKRelations = OKRelations + 1;
	};
	// If we have multiple relations running, lets warn the user
	if (OKRelations > 1) then {
		diag_log format ["[OK]: Multiple Relations Detected! Unwanted AI Behaviour May Occur!"];
		diag_log format ["[OK]: If Issues Arise, Decide on a Single AI System! (DayZAI, SargeAI, or WickedAI)"];
	};
	OKRelations = nil; //Destroy the Global Var
	
};

// Let's Load the Mission Configuration
call compile preprocessFileLineNumbers "\z\addons\dayz_server\OK\OKConfig.sqf";
waitUntil {OKConfigured};
OKConfigured = nil;

OKMissionIdActive = 0;

// These are Extended configuration files the user can adjust if wanted
call compile preprocessFileLineNumbers "\z\addons\dayz_server\OK\ExtConfig\OKWeaponCrateList.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\OK\ExtConfig\OKAIConfig.sqf";

// Lets check for a copy-pasted config file
if (OKVersion != "RC1.0") then {
	diag_log format ["[OK]: Outdated Configuration Detected! Please Update OK!"];
	diag_log format ["[OK]: Old Versions are not supported by the Mod Author!"];
};

diag_log format ["[OK]: Mission and Extended Configuration Loaded!"];

// Lets get the map name for mission location purposes
OKWorldName = toLower format ["%1", worldName];
diag_log format["[OK]: %1 Detected. Map Specific Settings Adjusted!", OKWorldName];

// We need to detect Epoch to change the hive call for vehicle saving
// Epoch doesn't have hive 999 calls and uses 308 publish instead
_modVariant = toLower( getText (configFile >> "CfgMods" >> "DayZ" >> "dir"));
if (_modVariant == "@dayz_epoch") then {OKEpoch = true;} else {OKEpoch = false;};

if (OKEpoch) then {
	diag_log format ["[OK]: DayZ Epoch Detected! Some Scripts Adjusted!"];
};

// Lets load our functions
call compile preprocessFileLineNumbers "\z\addons\dayz_server\OK\OKFunctions.sqf";

// Let's get the clocks running!
[] ExecVM OKMajTimer;

// Let's get the Marker Re-setter running for JIPs to stay updated
[] ExecVM OKMarkerLoop;
