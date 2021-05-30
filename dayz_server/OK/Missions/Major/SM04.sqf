//
//	Abandoned Base Mission by Pastorn
//	Based on New Mission Format by Vampire
//

private ["_missName","_dbData","_baseId","_coords","_coords3d","_coords3dGround","_survivors","_wp","_nearbyStorage","_calculatedLootValue","_expectedTotalGoldValue","_remainingGoldValue","_mags","_magTypes","_filteredMagTypes","_filteredMagCount","_weaps","_backpacks","_arrayOfTraderCat","_storageTypes","_additionalCurrency","_items","_storageName","_storageNameUnlocked","_selectedStorage","_safePos","_objectUID","_ws","_patrolCoords","_patrolGroups","_patrolClasses","_patrol2Classes","_patrolClass","_nearbyPlayers","_moreSurvivors","_nearestPlayer","_unlocked","_capacity","_unlockedClass","_weapons","_magazines","_holder","_type","_dir","_vector","_pos","_charID","_objectID","_ownerID","_patrolData","_patrolVehicles","_opGemCount","_nearbyGuns","_gunnerGroup","_gunnerGroups","_gunnerGroupsAlive","_baseObjects","_startTime","_lastUpdated","_takenOver","_vehEhSetter","_baseObjectCount","_playerWithinAreaMoment","_timeOutsideArea","_survivorCount","_patrol3Classes","_patrol4Classes","_inventory","_warningsLeft"];


//////////////////////////////////////////////////////////////////////////////////////////////
// Rides

//Name of the Mission
_missName = "OK Abandoned Base";
_expectedTotalGoldValue = 50000;
_mags = [];
_weaps = [];
_backpacks = [];
_calculatedLootValue = 0;
_expectedTotalGoldValue = 100 * (round(random 1000) + 3000); //  30 BC + 0-10 BC
_patrolClasses = ["HMMWV_M998A2_SOV_DES_EP1_DZ","HMMWV_M1151_M2_CZ_DES_EP1_DZ","LandRover_Special_CZ_EP1","LandRover_MG_TK_EP1","HMMWV_M998_crows_M2_DES_EP1","ArmoredSUV_PMC"];
_patrol2Classes = ["BTR90","BTR60_TK_EP1","BTR40_MG_TK_INS_EP1","BRDM2_TK_EP1","M1126_ICV_M2_EP1"];
_patrol3Classes = ["Mi17_DZ", "UH1H_DZ", "UH60M_EP1_DZ", "UH1Y_DZ", "CH_47F_EP1_DZ"];
_patrol4Classes = ["UH1Y"];
_unlocked = false;
_takenOver = false;
_playerWithinAreaMoment = 0;
_timeOutsideArea = 0;
_survivorCount = 0;
_patrolGroups = [];
_patrolVehicles = [];
_warningsLeft = 3;

// function to get value of a single item
_get_value = {0};

_vehEhSetter = { _this addEventHandler ["GetIn", {[_this select 0] call OKSaveVeh; _this call server_checkIfTowed;}];};

_dbData = [_vehEhSetter] call server_getAbandonedBase;
if ((count _dbData) == 0) exitWith {
	OKMajDone = true;
	diag_log "OK: Aborting Abandoned base mission. No old plot poles / bases found!";
};

_baseId = _dbData select 0;
_coords = [_dbData select 1, _dbData select 2];
_coords3d = [_dbData select 1, _dbData select 2, _dbData select 3];
_coords3dGround = [_dbData select 1, _dbData select 2, 0];

[nil,nil,rTitleText,"Latest news from the trader cities says an abandoned survivor base has been found! Beware, the place might be overrun by raiders...", "PLAIN",10] call RE;

//OKAddMajMarker is a simple script that adds a marker to the location
[_coords,_missname] ExecVM OKAddMajMarker;

//OKAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, skin]
_survivors = [_coords,(round(random 10))+5,(round(random 3)),(round(random 3))] call OKAISpawn2;

// Check all safes + storage... calculate the value of their contents.
_nearbyStorage = _coords3d nearObjects ["Land_A_Tent", 50];
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["DomeTentStorage_base", 50]);
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["WoodShack_DZ", 50]);
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["Wooden_shed_DZ", 50]);
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["StorageShed_DZ", 50]);
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["WoodCrate_DZ", 50]);
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["GunRack_DZ", 50]);
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["IC_Tent", 50]);
_nearbyStorage = _nearbyStorage + (_coords3d nearObjects ["IC_DomeTent", 50]);

local _dropMultiplier = 1;
local _dropChance = 0;
local _dropped = false;
local _numStorage = count _nearbyStorage;
{
	_opGemCount = 0;
	diag_log format["OK: Found %1 storage at %2. Clearing extremely valuable gems from the inventory...", (typeOf _x), (getPosATL _x)];
	if ((typeOf _x) in ["VaultStorageLocked", "LockboxStorageLocked"]) then {
		_mags =_x getVariable ["MagazineCargo",[]];
		_magTypes = _mags select 0;
		_filteredMagTypes = [];
		_filteredMagCount = [];
		for "_i" from 0 to (count(_mags select 0) - 1) do {
			_dropChance = (random 100) / 100;
			_dropped = _dropChance <= (_numStorage * _numStorage) / (100 * _dropMultiplier);
			if (!((_magTypes select _i) in ["ItemRuby","ItemCitrine","ItemEmerald","ItemAmethyst"]) || {_dropped}) then {
				_filteredMagTypes = _filteredMagTypes + [(_mags select 0) select _i];
				_filteredMagCount = _filteredMagCount + [(_mags select 1) select _i];
				_dropMultiplier = _dropMultiplier + 1;
			} else {
				_dropChance = random 100;
				if (_dropChance >= 50) then {
					_filteredMagTypes = _filteredMagTypes + ["ItemObsidian"];
					_filteredMagCount = _filteredMagCount + [(_mags select 1) select _i];
				};
				_opGemCount = _opGemCount + 1;
			};
		};
		_mags = [_filteredMagTypes, _filteredMagCount];
		_x setVariable ["MagazineCargo", _mags, false];
	} else {
		local _tmpObj = _x;
		_mags = getMagazineCargo _tmpObj;
		_magTypes = _mags select 0;
		_filteredMagTypes = [];
		_filteredMagCount = [];
		clearMagazineCargoGlobal _tmpObj;
		for "_i" from 0 to (count(_mags select 0) - 1) do {
			_dropChance = (random 100) / 100;
			_dropped = _dropChance <= (_numStorage * _numStorage) / (100 * _dropMultiplier);
			if (!((_magTypes select _i) in ["ItemRuby","ItemCitrine","ItemEmerald","ItemAmethyst"])) then {
				_filteredMagTypes = _filteredMagTypes + [(_mags select 0) select _i];
				_filteredMagCount = _filteredMagCount + [(_mags select 1) select _i];
				_dropMultiplier = _dropMultiplier + 1;
			} else {
				_dropChance = random 100;
				if (_dropChance >= 50) then {
					_filteredMagTypes = _filteredMagTypes + ["ItemObsidian"];
					_filteredMagCount = _filteredMagCount + [(_mags select 1) select _i];
				};
				_opGemCount = _opGemCount + 1;
			};
		};
		_mags = [_filteredMagTypes, _filteredMagCount];
		{_tmpObj addMagazineCargoGlobal [_x, _filteredMagCount select _foreachindex];} forEach _filteredMagTypes;
	};
	diag_log format["OK: Cleared %1 overpowered gems from the inventory of %2 at %3!", _opGemCount, (typeOf _x), (getPosATL _x)];
} forEach _nearbyStorage;

_nearbyGuns = _coords3d nearObjects ["M2StaticMG", 75];
_nearbyGuns = _nearbyGuns + (_coords3d nearObjects ["DSHKM_CDF", 75]);
_gunnerGroups = [];

{
	_gunnerGroup = [_x, (round(random 3)),(round(random 3)), _gunnerGroups, true] call OKManStaticGun;
} forEach _nearbyGuns;

// Count base parts
_baseObjectCount = (count nearestObjects[_coords3d, DayZ_SafeObjects, 75]);

_startTime = diag_ticktime;
diag_log "OK: Waiting for a player to come within 75m of the abandoned base.";

//Wait until the player is within 75 meters of the area
waitUntil {sleep 3; {isPlayer _x && _x distance _coords3d <= 75 } count playableunits > 0 };
diag_log "OK: A player has come within 75m of the abandoned base!";
[nil,nil,rTitleText,"The abandoned base has been discovered! Watch out, there's an ambush!", "PLAIN",10] call RE;

_nearbyPlayers = [];
{
	if (isPlayer _x && (_x distance _coords) <= 500) then {
		_nearbyPlayers = _nearbyPlayers + [_x];
	};
} forEach playableUnits;

if ((count _patrolGroups) == 0) then {
	_survivorCount = floor (_baseObjectCount / 7.5); // Up to 300 base objects => up to 45 bots!

	_patrolCoords = [_coords3dGround, 300, 400, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
	_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0.05];
	_moreSurvivors = [_patrolCoords,(round(random 3))+_survivorCount,(round(random 3)),(round(random 3))] call OKAISpawn2;
	_patrolCoords = [_coords3dGround, 300, 400, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
	_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0.05];
	_patrolClass = _patrolClasses call BIS_fnc_selectRandom;
	_patrolData = [_coords3dGround, _patrolCoords, 200, 6, _patrolClass, 1, false] call OKVehiclePatrolGround;
	_patrolVehicles set [0, _patrolData select 0];
	_patrolGroups set [0, _patrolData select 1];
	if (_patrolClass == "HMMWV_M998A2_SOV_DES_EP1_DZ") then {
		(_patrolVehicles select 0) addMagazine ["48Rnd_40mm_MK19", 8];
	};
	if (_patrolClass == "LandRover_Special_CZ_EP1") then {
		(_patrolVehicles select 0) addMagazine ["29Rnd_30mm_AGS30", 8];
	};
	if (_patrolClass in ["HMMWV_M998_crows_M2_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1_DZ","LandRover_MG_TK_EP1"]) then {
		(_patrolVehicles select 0) addMagazine ["100Rnd_127x99_M2", 8];
	};
	if (_patrolClass == "ArmoredSUV_PMC") then {
		(_patrolVehicles select 0) addMagazine ["2000Rnd_762x51_M134", 8];
	};
	if (_baseObjectCount >=75) then {
		_patrolCoords = [_coords3dGround, 300, 400, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
		_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0.05];
		_patrolClass = _patrol2Classes call BIS_fnc_selectRandom;
		_patrolData = [_coords3dGround, _patrolCoords, 200, 10, _patrolClass, 1, true] call OKVehiclePatrolGround;
		_patrolVehicles set [1, _patrolData select 0];
		_patrolGroups set [1, _patrolData select 1];
	};
	if (_baseObjectCount >=150) then {
		_patrolCoords = [_coords3dGround, 500, 800, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
		_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0];
		_patrolClass = _patrol3Classes call BIS_fnc_selectRandom;
		_patrolGroups set [2, ([_coords3dGround, [(_patrolCoords select 0), 100, 500], 200, 10, _patrolClass, 1, true] call OKVehiclePatrol)];
	};
	if (_baseObjectCount >= 225) then {
		_patrolCoords = [_coords3dGround, 500, 800, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
		_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0];
		_patrolClass = _patrol4Classes call BIS_fnc_selectRandom;
		_patrolGroups set [3, ([_coords3dGround, [100, (_patrolCoords select 1), 500], 200, 10, _patrolClass, 1, true] call OKVehiclePatrol)];
	};

	if ((count _nearbyPlayers) > 0) then {
		{ _x reveal (_nearbyPlayers call BIS_fnc_selectRandom); } forEach _patrolGroups;
		_moreSurvivors reveal (_nearbyPlayers call BIS_fnc_selectRandom);
	};
	diag_log "OK: Created ambush patrols!";
};

_collectedUnits = [];
local _lockableParts = [
	"VaultStorageLocked",
	"LockboxStorageLocked",
	"VaultStorage2Locked",
	"TallSafeLocked",
	"LockboxStorageLocked",
	"LockboxStorage2Locked",
	"LockboxStorageWinterLocked",
	"LockboxStorageWinter2Locked",
	"Land_DZE_WoodDoorLocked",
	"Land_DZE_LargeWoodDoorLocked",
	"Land_DZE_GarageWoodDoorLocked",
	"Land_DZE_WoodGateLocked",
	"Land_DZE_WoodOpenTopGarageLocked",
	"CinderGateLocked_DZ",
	"CinderWallDoorLocked_DZ",
	"CinderWallDoorSmallLocked_DZ",
	"CinderGarageOpenTopLocked_DZ",
	"CinderDoorHatchLocked_DZ",
	"DoorLocked_DZ",
	"Metal_DrawbridgeLocked_DZ"
];

// Main monitor loop; If after 10 mins no players have entered area to reset timer, exit the main loop.
_lastTimePlayersPresent = diag_ticktime;
while {(_timeOutsideArea < 600) && (!_takenOver)} do {

	_nearbyPlayers = [];
	{
		if ((isPlayer _x) && (_x distance _coords) <= 500) then {
			_nearbyPlayers = _nearbyPlayers + [_x];
		};
	} forEach playableUnits;

	while {(count _nearbyPlayers) > 0 && {!_takenOver}} do {
		if (_warningsLeft == 0) then { _warningsLeft = 1; };
		_gunnerGroupsAlive = 0;
		{
			_gunnerGroupsAlive = _gunnerGroupsAlive + ({alive _x} count units _x);
		} forEach _gunnerGroups;
		_collectedUnits = (units _survivors) + (units _moreSurvivors);
		{
			_collectedUnits = _collectedUnits + (units _x);
		} forEach _patrolGroups;
		if (!_unlocked && (({(alive _x) && (_x distance _coords3dGround) < 800} count _collectedUnits) + _gunnerGroupsAlive == 0)) then {
			{
				// Fix for leading zero issues on safe codes after restart
				local _ownerID = _x getVariable ["CharacterID", "000"];
				local _lockable = getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> "lockable");
				switch (_lockable) do {
					case 4: {_ownerID = "0000";};
					case 3: {_ownerID = "000";};
				};
				_x setVariable ["CharacterID", _ownerID, true];
			} forEach nearestObjects [_coords3d, _lockableParts, 75];
			_unlocked = true;
			[nil,nil,rTitleText,"Abandoned Base forces have been defeated! Its safe and door combinations have temporarily reset to 0000 and 000.", "PLAIN",6] call RE;
		};

		_nearbyPlayers = [];
		{
			if (isPlayer _x && (_x distance _coords) <= 500) then {
				_nearbyPlayers = _nearbyPlayers + [_x];
			};
		} forEach playableUnits;

		if ((count _nearbyPlayers) == 0 && {_warningsLeft == 3}) then {
			[nil,nil,rTitleText,"Warning: Leaving the abandoned base area will end the mission in 10 min.", "PLAIN",5] call RE;
			_warningsLeft = 2;
		};

		sleep 5;
		_lastTimePlayersPresent = diag_ticktime;
	};

	_timeOutsideArea = diag_ticktime - _lastTimePlayersPresent;
	if (_timeOutsideArea >= 300 && _warningsLeft == 2) then {
		[nil,nil,rTitleText,"Abandoned Base: 5 minutes left.", "PLAIN",5] call RE;
		_warningsLeft = 0;
	} else {
		if (_timeOutsideArea >= 480 && _warningsLeft == 1) then {
			[nil,nil,rTitleText,"Abandoned Base: 2 minutes left.", "PLAIN",5] call RE;
			_warningsLeft = 1;
		};
	};
	sleep 5;
};
_takenOver  = false; // Just in case plot pole is removed!

diag_log "OK: Players have left the abandoned base!";

// Check if base was taken over
{
	_lastUpdated = _x getVariable ["lastUpdate", diag_ticktime];
	if (_lastUpdated > _startTime && {alive _x}) then {
		_takenOver = true;
		_pos = getPosATL _x;
		diag_log "OK: New plot pole found, the abandoned base was taken over!";
	};
} forEach nearestObjects [_coords3d, ["Plastic_Pole_EP1_DZ"], 75];

// Delete base if not taken over
_baseObjects = nearestObjects[_coords3d, DayZ_SafeObjects, 75];
if (!_takenOver) then {
	diag_log "OK: No new plot pole found, the abandoned base will be deleted.";
	{
		deleteVehicle _x;
	} forEach _baseObjects;
} else {
	{
		_object = _x;
		_worldspace = [getDir _object, getPosATL _object, "0", [vectorDir _object, vectorUp _object]];
		_inventory = call {
			if (DZE_permanentPlot && {(typeOf _object) == "Plastic_Pole_EP1_DZ"}) exitwith {
				_object getVariable ["plotfriends", []] //We're replacing the inventory with UIDs for this item
			};
			if (DZE_doorManagement && {(typeOf _object) in DZE_DoorsLocked}) exitwith {
				_object getVariable ["doorfriends", []] //We're replacing the inventory with UIDs for this item
			};
			if (_object isKindOf "TrapItems") exitwith {
				[["armed",_object getVariable ["armed",false]]]
			};
			[getWeaponCargo _object, getMagazineCargo _object, getBackpackCargo _object]
		};
		diag_log format["OK: Publishing %1 @ %2 with UID %3, CharacterID %4", typeOf _object, _worldspace, _object getVariable["ObjectUID", "0"], _object getVariable["CharacterID", "0"]];
		[_object getVariable ["CharacterID", "0"], _object, _worldspace, _inventory] call server_publishAbandonedBaseObject;
	} forEach _baseObjects;
};

//Let everyone know the mission is over
[nil,nil,rTitleText,"Abandoned base was visited!", "PLAIN",6] call RE;

diag_log format["[OK]: Abandoned Base Mission has Ended."];
deleteMarker "OKMajMarker";
deleteMarker "OKMajDot";

//Let the timer know the mission is over
OKMajDone = true;

sleep OKDespawnTime;

// Once timed out, if anyone is alive then just delete them.
{
	if ((vehicle _x) != _x) then {
		deleteVehicle (vehicle _x);
	};
	if (alive _x) then { deleteVehicle _x; };
	sleep 0.05;
} forEach _collectedUnits;
{
	_gunnerGroup = _x;
	{
		if (alive _x) then { deleteVehicle _x; };
		sleep 0.05;
	} forEach units _gunnerGroup;
} forEach _gunnerGroups;
