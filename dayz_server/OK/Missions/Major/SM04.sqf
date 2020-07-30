//
//	Abandoned Base Mission by Pastorn
//	Based on New Mission Format by Vampire
//

private ["_missName","_dbData","_baseId","_coords","_coords3d","_coords3dGround","_survivors","_wp","_nearbyStorage","_calculatedLootValue","_expectedTotalGoldValue","_remainingGoldValue","_mags","_magTypes","_magCount","_weaps","_backpacks","_arrayOfTraderCat","_storageTypes","_additionalCurrency","_items","_storageName","_storageNameUnlocked","_selectedStorage","_safePos","_objectUID","_ws","_patrolCoords","_patrolGroup","_patrolGroup2","_patrolClasses","_patrol2Classes","_patrolClass","_nearbyPlayers","_patrolVeh","_moreSurvivors","_nearestPlayer","_unlocked","_capacity","_unlockedClass","_weapons","_magazines","_holder","_type","_dir","_vector","_pos","_charID","_objectID","_ownerID","_patrolData","_patrolVeh","_patrolVeh2","_rubyCount","_nearbyGuns","_gunnerGroup","_gunnerGroups","_gunnerGroupsAlive","_baseObjects","_startTime","_lastUpdated","_takenOver"];


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
_patrolGroup = grpNull;
_patrolGroup2 = grpNull;
_patrolClasses = ["HMMWV_M998A2_SOV_DES_EP1_DZ","HMMWV_M1151_M2_CZ_DES_EP1_DZ","LandRover_Special_CZ_EP1","LandRover_MG_TK_EP1","HMMWV_M998_crows_M2_DES_EP1","ArmoredSUV_PMC"];
_patrol2Classes = ["BTR90","BTR60_TK_EP1","BTR40_MG_TK_INS_EP1","BRDM2_TK_EP1","M1126_ICV_M2_EP1"];
_unlocked = false;
_takenOver = false;

// function to get value of a single item
_get_value = {0};
//	private["_arrayOfTraderCat","_itemIn","_itemToEvaluate","_itemType","_configType","_sell","_sellCurrency","_worth","_part","_totalPrice","_value","_cat"];
//	_itemIn = _this select 0;
//	_itemType = _this select 1;
//	_worth = 0;
//	_totalPrice = 0;
//
//	if ((typeName _itemIn) == "ARRAY") then {
//		_itemToEvaluate = _itemIn select 0;
//	} else {
//		_itemToEvaluate = _itemIn;
//	};
//
//	// Using full set of trader categories
//	_arrayOfTraderCat = [693, 577, 575, 627, 485, 621, 538, 678, 542, 628, 630, 601, 486, 622, 541, 629, 625, 489, 574, 623, 543, 487, 624, 626, 488, 679, 677, 577, 476, 627, 527, 526, 529, 675];
//	{
//		_cat = format["Category_%1", _x];
//		if (isNumber (missionConfigFile >> "CfgTraderCategory" >> _cat >> "duplicate")) then {
//			_cat = format["Category_%1",getNumber (missionConfigFile >> "CfgTraderCategory" >> _cat >> "duplicate")];
//		};
//		if (isClass(missionConfigFile >> "CfgTraderCategory" >> _cat >> _itemToEvaluate) && {_itemType in ["find",(getText(missionConfigFile >> "CfgTraderCategory" >> _cat >> _itemToEvaluate >> "type"))]}) exitWith {
//			_configType = getText(missionConfigFile >> "CfgTraderCategory" >> _cat >> _itemToEvaluate >> "type");
//			if (_itemType == "find") then {_itemType = _configType;};
//
//			_sell = getArray(missionConfigFile >> "CfgTraderCategory" >> _cat >> _itemToEvaluate >> "sell");
//
//			_worth = 0;
//			if (!Z_SingleCurrency) then {
//				_sellCurrency = _sell select 1;
//				_part = (configFile >> "CfgMagazines" >> _sellCurrency);
//				_worth = getNumber(_part >> "worth");
//				if (_worth == 0) then { _worth = DZE_GemWorthList select (DZE_GemList find _sellCurrency); };
//				_value = _worth * (_sell select 0);
//			} else {
//				_sellCurrency = CurrencyName;
//				_value = _sellCurrency * (_sell select 0);
//			};
//		};
//	} forEach _arrayOfTraderCat;
//	_value
//};

_dbData = [] call server_getAbandonedBase;
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

{
	_rubyCount = 0;
	diag_log format["OK: Found %1 storage at %2. Clearing rubies from the inventory...", (typeOf _x), (getPosATL _x)];
	if ((typeOf _x) in ["VaultStorageLocked", "LockboxStorageLocked"]) then {
		_mags =_x getVariable ["MagazineCargo",[]];
		_magTypes = _mags select 0;
		_magCount = [];
		for "_i" from 0 to (count(_mags select 0) - 1) do {
			if ((_magTypes select _i) != "ItemRuby") then {
				_magTypes = _magTypes + [(_mags select 0) select _i];
				_magCount = _magCount + [(_mags select 1) select _i];
			} else {
				_rubyCount = _rubyCount + 1;
			};
		};
		_mags = [_magTypes, _magCount];
		_x setVariable ["MagazineCargo", _mags, false];
	} else {
		_mags = getMagazineCargo _x;
		_magTypes = _mags select 0;
		_magCount = [];
		for "_i" from 0 to (count(_mags select 0) - 1) do {
			if ((_magTypes select _i) != "ItemRuby") then {
				_magTypes = _magTypes + [(_mags select 0) select _i];
				_magCount = _magCount + [(_mags select 1) select _i];
			} else {
				_rubyCount = _rubyCount + 1;
			};
		};
		_mags = [_magTypes, _magCount];
		clearMagazineCargoGlobal _x;
		_x addMagazineCargoGlobal _mags;
	};
	diag_log format["OK: Cleared %1 rubies from the inventory of %2 at %3!", _rubyCount, (typeOf _x), (getPosATL _x)];
} forEach _nearbyStorage;

_nearbyGuns = _coords3d nearObjects ["M2StaticMG", 75];
_nearbyGuns = _nearbyGuns + (_coords3d nearObjects ["DSHKM_CDF", 75]);
_gunnerGroups = [];

{
	_gunnerGroup = [_x, (round(random 3)),(round(random 3))] call OKManStaticGun;
	_gunnerGroups set [count _gunnerGroups, _gunnerGroup]; 
} forEach _nearbyGuns;
//{
//	_calculatedLootValue = _calculatedLootValue + ([_x, "trade_weapons"] call _get_value);
//} forEach _weaps;
//{
//	_calculatedLootValue = _calculatedLootValue + ([_x, "trade_items"] call _get_value);
//} forEach _mags;
//{
//	_calculatedLootValue = _calculatedLootValue + ([_x, "trade_backpacks"] call _get_value);
//} forEach _backpacks;

//_remainingGoldValue = _expectedTotalGoldValue - _calculatedLootValue;
//_additionalCurrency = [];
//if (_remainingGoldValue > 0) then {
//
//	_selectedStorage = objNull;
//	_storageTypes = [
//		"VaultStorageLocked",
//		"LockboxStorageLocked",
//		"WoodShack_DZ",
//		"Wooden_shed_DZ",
//		"DesertTentStorage",
//		"DesertTentStorage0",
//		"DesertTentStorage1",
//		"DesertTentStorage2",
//		"DesertTentStorage3",
//		"DesertTentStorage4",
//		"IC_Tent",
//		"IC_DomeTent",
//		"GunRack_DZ",
//		"WoodCrate_DZ",
//		"StorageShed_DZ"
//	];
//
//	if (Z_SingleCurrency) then {
//		_additionalCurrency = _remainingGoldValue;
//	} else {
//		_additionalCurrency = [_remainingGoldValue] call OKCalcCurrency;
//	};
//
//	// Put some valuables inside safes + other storage. (Reset code for safes also to 0000 + unlock them)
//	{
//		_storageName = typeOf _x;
//		if (_storageName in _storageTypes) then {
//			if (isText(configFile >> "CfgVehicles" >> _storageName >> "unlockedClass")) then {	// Is lockbox or safe
//				_storageNameUnlocked = getText (configFile >> "CfgVehicles" >> _storageName >> "unlockedClass");
//				_capacity = getNumber(configFile >> "CfgVehicles" >> _storageNameUnlocked >> "transportMaxMagazines");
//			} else {	// Not lockbox or safe
//				_capacity = getNumber(configFile >> "CfgVehicles" >> _storageName >> "transportMaxMagazines");
//			};
//			if (Z_SingleCurrency && {_storageName in DZE_MoneyStorageClasses}) exitWith {
//				_selectedStorage = _x;
//			};
//			if (count (_x getVariable ["MagazineCargo", []]) + count(_additionalCurrency) <= _capacity) exitWith {
//					_selectedStorage = _x;
//			};
//		};
//	} forEach _nearbyStorage;

//	if (isNull _selectedStorage) then {
//		// Create a safe with the specified storage.
//		_selectedStorage = "WoodCrate_DZ" createVehicle [0,0,0];
//		_safePos = [_coords, 0, 45, 1, 0, 0.9, 0, [], _coords] call BIS_fnc_findSafePos;
//		_ws = [random 360, [_safePos select 0, _safePos select 1, 0]];
//		_selectedStorage setDir (_ws select 0);
//		_selectedStorage setPosATL (_ws select 1);
//		_selectedStorage setDamage 0;
//		_selectedStorage enableSimulation false;
//		_objectUID = _ws call dayz_objectUID2;
//		_selectedStorage setVariable ["ObjectUID", _objectUID, true];
//
//		// Do not send big arrays over network! Only server needs these
//		_selectedStorage setVariable ["lastUpdate",diag_ticktime];
//		clearWeaponCargoGlobal _selectedStorage;
//		clearMagazineCargoGlobal _selectedStorage;
//		clearBackpackCargoGlobal _selectedStorage;
//		_selectedStorage setVariable["memDir",getDir _selectedStorage, true];
//		if (DZE_GodModeBase && {!(_storageName in DZE_GodModeBaseExclude)}) then {
//			_selectedStorage addEventHandler ["HandleDamage",{false}];
//		} else {
//			_selectedStorage addMPEventHandler ["MPKilled",{_this call vehicle_handleServerKilled;}];
//		};
//		_selectedStorage setVariable ["OEMPos", getPosATL _selectedStorage,true]; // used for inplace upgrades and lock/unlock of safe
//		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_selectedStorage]; //Monitor the object
//	};
//
//	diag_log format["OK: Trying to add the following items to safe or storage: %1", _additionalCurrency];
//	if (Z_SingleCurrency) then {
//		_additionalCurrency = _additionalCurrency + _selectedStorage getVariable [Z_MoneyVariable, 0];
//		_selectedStorage setVariable [Z_MoneyVariable, _additionalCurrency, true];
//	} else {
//		if (_selectedStorage in DZE_LockedStorage) then {
//			_items = _selectedStorage getVariable ["MagazineCargo",[]];
//			_items = _items + _additionalCurrency;
//			_selectedStorage setVariable ["MagazineCargo", _items, false];
//			diag_log format["OK: Set the following items in safe inventory: %1", _items];
//		} else {
//			{
//				_selectedStorage addMagazineCargoGlobal [_x, 1];
//			} forEach _additionalCurrency;
//			diag_log format["OK: Added the following items to storage: %1", _additionalCurrency];
//		};
//	};
//};

_startTime = diag_ticktime;
diag_log "OK: Waiting for a player to come within 75m of the abandoned base.";

waitUntil {sleep 3; {isPlayer _x && _x distance _coords3d <= 75 } count playableunits > 0 };
diag_log "OK: A player has come within 75m of the abandoned base!";

//Wait until the player is outside 100 meters of the area
_nearbyPlayers = [];
{
	if (isPlayer _x && (_x distance _coords) <= 500) then {
		_nearbyPlayers = _nearbyPlayers + [_x];
	};
} forEach playableUnits;

if (isNull(_patrolGroup)) then {
	_patrolCoords = [_coords3dGround, 500, 800, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
	_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0];
	_moreSurvivors = [_patrolCoords,(round(random 3))+5,(round(random 3)),(round(random 3))] call OKAISpawn2;
	_patrolCoords = [_coords3dGround, 500, 800, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
	_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0];
	_patrolClass = _patrolClasses call BIS_fnc_selectRandom;
	_patrolData = [_coords3dGround, _patrolCoords, 200, 6, _patrolClass, 1, false] call OKVehiclePatrolGround;
	_patrolVeh = _patrolData select 0;
	_patrolGroup = _patrolData select 1;
	_patrolCoords = [_coords3dGround, 500, 800, 1, 0, 0.9, 0, [], _coords3dGround] call BIS_fnc_findSafePos;
	_patrolCoords = [_patrolCoords select 0, _patrolCoords select 1, 0];
	_patrolClass = _patrol2Classes call BIS_fnc_selectRandom;
	_patrolData = [_coords3dGround, _patrolCoords, 200, 6, _patrolClass, 1, true] call OKVehiclePatrolGround;
	_patrolVeh2 = _patrolData select 0;
	_patrolGroup2 = _patrolData select 1;

	if (_patrolClass == "HMMWV_M998A2_SOV_DES_EP1_DZ") then {
		_patrolVeh addMagazine ["48Rnd_40mm_MK19", 8];
	};
	if (_patrolClass == "LandRover_Special_CZ_EP1") then {
		_patrolVeh addMagazine ["29Rnd_30mm_AGS30", 8];
	};
	if (_patrolClass in ["HMMWV_M998_crows_M2_DES_EP1","HMMWV_M1151_M2_CZ_DES_EP1_DZ","LandRover_MG_TK_EP1"]) then {
		_patrolVeh addMagazine ["100Rnd_127x99_M2", 8];
	};
	if (_patrolClass == "ArmoredSUV_PMC") then {
		_patrolVeh addMagazine ["2000Rnd_762x51_M134", 8];
	};

	if ((count _nearbyPlayers) > 0) then {
		_patrolGroup reveal (_nearbyPlayers call BIS_fnc_selectRandom);
		_patrolGroup2 reveal (_nearbyPlayers call BIS_fnc_selectRandom);
		_moreSurvivors reveal (_nearbyPlayers call BIS_fnc_selectRandom);
	};
	diag_log "OK: Created ambush patrol!";
};

while {(count _nearbyPlayers) > 0} do {
	_gunnerGroupsAlive = 0;
	{
		_gunnerGroupsAlive = _gunnerGroupsAlive + ({alive _x} count units _x);
	} forEach _gunnerGroups;
	if (!_unlocked && {({alive _x} count ((units _survivors) + (units _moreSurvivors) + (units _patrolGroup) + (units _patrolGroup2))) + _gunnerGroupsAlive == 0}) then {
		{
			// Unlock each safe
			_x setVariable ["CharacterID", "0000", true];

		} forEach nearestObjects [_coords3d, ["VaultStorageLocked", "LockboxStorageLocked"], 75];
		_unlocked = true;
		[nil,nil,rTitleText,"Abandoned Base forces have been defeated! Its safe combinations have temporarily reset to 0000.", "PLAIN",6] call RE;
	};

	_nearbyPlayers = [];
	{
		if (isPlayer _x && (_x distance _coords) <= 500) then {
			_nearbyPlayers = _nearbyPlayers + [_x];
		};
	} forEach playableUnits;
	sleep 5;
};
diag_log "OK: Players have left the abandoned base!";

// Check if base was taken over
{
	_lastUpdated = _x getVariable ["lastUpdate", 0];
	if (_lastUpdated > _startTime && {alive _x}) then {
		_takenOver = true;
	};
} forEach nearestObjects [_coords3d, "Plastic_Pole_EP1_DZ", 75];

// Delete base if not taken over or 
_baseObjects = nearestObjects[_coords3d, DayZ_SafeObjects, 75];
if (!_takenOver) then {
	{
		_objectID = _x getVariable ["ObjectID", "0"];
		[_objectID, "0"] call server_deleteObjDirect;
		deleteVehicle _x;
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
	if (alive _x) then { deleteVehicle _x; };
	sleep 0.05;
} forEach units _survivors;
{
	if (alive _x) then { deleteVehicle _x; };
	sleep 0.05;
} forEach units _moreSurvivors;
{
	if ((vehicle _x) != _x) then {
		deleteVehicle (vehicle _x);
	};
	if (alive _x) then { deleteVehicle _x; };
	sleep 0.05;
} forEach units _patrolGroup;
{
	if ((vehicle _x) != _x) then {
		deleteVehicle (vehicle _x);
	};
	if (alive _x) then { deleteVehicle _x; };
	sleep 0.05;
} forEach units _patrolGroup2;

{
	_gunnerGroup = _x;
	{
		if (alive _x) then { deleteVehicle _x; };
		sleep 0.05;
	} forEach units _gunnerGroup;
} forEach _gunnerGroups;
