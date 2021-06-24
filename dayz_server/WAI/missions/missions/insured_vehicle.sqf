private ["_claimingPlayerUID","_claimingPlayer","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition","_insuranceClaim","_inventory","_coins","_charID","_keyItem","_noKey","_isOK","_ws","_getPos","_timeelapsed","_timecount","_remainingWeapons","_remainingMags","_remainingBackpacks","_splitWeapons","_splitMags","_splitBackpacks","_stolenWeaponCount","_stolenMagsCount","_stolenBackpackCount","_stolenWeapons","_stolenMags","_stolenBackpacks","_expandItemsList","_compressItemsList","_splitListByCount","_expandedWeaponsList","_expandedMagsList","_expandedBackpackList","_cleanunits","_weaponcargo","_weaponqty","_magcargo","_magqty","_backpackcargo","_backpackqty","_numMagslots","_numWeapSlots","_numBackpackSlots","_estimatedNumUnits","_numUnitsPerGroup","_waves","_wavePos","_waveGrp"];

insurancemissionstartstate = "Initializing";

_expandItemsList = {
	local _itemTypes = _this select 0;
	local _itemTypeCounts = _this select 1;
	diag_log format["EXPAND: got params: %1", _this];
	local _expandedItems = [];
	{
		local _itemType = _x;
		local _itemTypeCount = _itemTypeCounts select _forEachIndex;
		for "_i" from 0 to _itemTypeCount-1 do {
			_expandedItems = _expandedItems + [_itemType];
		};
	} forEach _itemTypes;
	diag_log format["EXPAND: expanded: %1", _expandedItems];
	_expandedItems
};

_compressItemsList = {
	local _items = _this;
	diag_log format["COMPRESS: got params: %1", _items];
	local _itemTypes = [];
	local _itemTypeCounts = [];
	local _prevItemType = "";
	local _count = 0;
	local _idx = -1;
	{
		local _itemType = _x;
		if (_itemType != _prevItemType) then {
			_prevItemType = _itemType;
			_count = 0;
			_idx = _idx + 1;
			_itemTypes set [_idx, _itemType];
		};
		_count = _count + 1;
		_itemTypeCounts set [_idx, _count];
	} forEach _items;
	diag_log format["COMPRESS: types: %1, counts: %2", _itemTypes, _itemTypeCounts];
	[_itemTypes, _itemTypeCounts]
};


_splitListByCount = {
	local _items = _this select 0;
	local _count = _this select 1;
	diag_log format["SPLIT: got params: %1", _this];
	local _removedItems = [];
	local _remainingItems = [];
	for "_i" from 0 to (_count-1) do {
		_removedItems = _removedItems + [_items select _i];
	};
	for "_i" from _count to ((count _items)-1) do {
		_remainingItems = _remainingItems + [_items select _i];
	};
	diag_log format["SPLIT: removed: %1, remaining: %2", _removedItems, _remainingItems];
	[_removedItems, _remainingItems]
};

_getPos = {
	private ["_center", "_radius", "_distFromNearestObj", "_inWater", "_gradient", "_shoreMode","_result"];
	_radius = 100;
	_center = _this select 0;
	_distFromNearestObj = 10;
	_inWater = 0;
	_gradient = 0.3;
	_shoreMode = 0;
	if(WAIWorldName == "chernarus") then {
		_gradient = 0.3;
	};
	if(WAIWorldName == "napf") then {
		_gradient = 0.5;
	};
	_result = ([_center,0,_radius,_distFromNearestObj,_inWater,_gradient, _shoreMode, [], [0,0,0]] call BIS_fnc_findSafePos);
	if ([_result, [0,0,0]] call BIS_fnc_areEqual) exitWith {[] call wai_find_pos};
	_result
};

_spawnAI = {
	private ["_mission","_aicskill","_position","_unitnumber","_skill","_weaponsOrTools","_weapons","_numMags","_backpack","_skin","_gear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_weaponandmag","_gearmagazines","_geartools","_unit","_dyn_id","_wp","_playerUnit","_iterationsNeeded","_magsRequired","_actualMagCount","_tmpArray","_magCount","_toolClasses","_tools"];
	_position = _this select 0;
	_skill = _this select 1;
	_weaponsOrTools = _this select 2;
	_magazines = _this select 3;
	_backpacks = _this select 4;
	_skin = _this select 5;
	_unitnumber = 0;
	if (count _position == 2) then {
		_position set [2, 0.0];
	};
	if (count _this == 7) then {
		_mission = _this select 6;
	} else {
		_mission = False;
	};

	_toolClasses = ["ItemCrowbarBent","Cuffs_DZE","CuffsBroken_DZE","ItemEtool","ItemEtoolBroken","ItemFishingPole",
		"ItemFishingPoleBroken","ItemFlashlight","ItemFlashlightBroken","ItemFlashlightRed","ItemFlashlightRedBroken",
		"ItemGPS","ItemGPSBroken_DZE","Hammer_DZE","HammerBroken_DZE","ItemHatchet","ItemHatchetBroken","ItemKeyKit",
		"ItemKeyKitBroken","ItemKnife","ItemKnife5","ItemKnife4","ItemKnife3","ItemKnife2","ItemKnife1","ItemKnifeBlunt",
		"ItemMachete","ItemMacheteBroken","ItemMap","ItemMap_Debug","ItemPilotmask_DZE","ItemPilotmaskBroken_DZE",
		"ItemGasmask1_DZE","ItemGasmask1Broken_DZE","ItemGasmask2_DZE","ItemGasmask2Broken_DZE","ItemMatchboxEmpty",
		"ItemMatchbox","Item5Matchbox","Item4Matchbox","Item3Matchbox","Item2Matchbox","Item1Matchbox","NVGoggles",
		"ItemNVGBroken_DZE","NVGoggles_DZE","ItemNVGFullBroken_DZE","ItemPickaxe","ItemPickaxeBroken","ItemRadio",
		"ItemRadioBroken_DZE","Handsaw_DZE","HandsawBroken_DZE","Scissors_DZE","ScissorsBroken_DZE","Screwdriver_DZE",
		"ScrewdriverBroken_DZE","ItemShovel","ItemShovelBroken","ItemSledge","ItemSledgeBroken","ItemSledgeHammer",
		"ItemSledgeHammerBroken","Smartphone_DZE","SmartphoneBroken_DZE","ItemSolder_DZE","ItemSolderBroken_DZE",
		"ItemToolbox","ItemToolboxBroken","ItemWatch","Wrench_DZE","WrenchBroken_DZE"];

	_weapons = [];
	_tools = [];
	{
		if (_x in _toolClasses) then {
			_tools set [count _tools, _x];
		} else {
			_weapons set [count _weapons, _x];
		};
	} forEach _weaponsOrTools;

	_iterationsNeeded = [count _weapons, count _tools, count _magazines, count _backpacks] call BIS_fnc_greatestNum;

	_aiskin = "";
	_aicskill = [];
	_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
	_unitGroup = createGroup east;
	_onlySurplusMagsLeft = false;

	if (!isServer) exitWith {
		insurancemissionrunning = false;
		insurancemissionstartstate = "Client called server script";
	};

	for "_i" from 0 to (_iterationsNeeded - 1) do {
		if (_skin == "") then {
			_aiskin = ai_skin call BIS_fnc_selectRandom;
		} else {
			_aiskin = _skin;
		};
		diag_log format["Creating bandit unit for group %1 with params: skin:%2, pos:%3, markers:%4, place_radius:%5, rank:%6", _unitGroup, _aiskin, _position, [], 10, "PRIVATE"];
		_unit = _unitGroup createUnit [_aiskin, [(_position select 0),(_position select 1),(_position select 2)], [], 10, "PRIVATE"];
		[_unit] joinSilent _unitGroup;
		_unit enableAI "TARGET";
		_unit enableAI "AUTOTARGET";
		_unit enableAI "MOVE";
		_unit enableAI "ANIM";
		_unit enableAI "FSM";
		_unit setCombatMode ai_combatmode;
		_unit setBehaviour ai_behaviour;
		removeAllWeapons _unit;
		removeAllItems _unit;
		_magCount = 0;

		// Give 1 weapon to one AI
		if (_i < count _weapons) then {
			_weapon = _weapons select _i;
			_unit addweapon _weapon;

			// Get default magazine type for the gun
			local _magTypes = getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines");
			if (!isNil "_magTypes" && 0 < count _magTypes) then {
				local _magType = _magTypes select 0;
				for "_j" from 1 to (4 + floor(random 4)) do {
					_unit addMagazine _magType;
					_magCount = _magCount + 1;
				};
			};
		};

		// Let one or two AI hoard the tools
		_tmpArray = [];
		{
			if (_x in (weapons _unit)) then {
				_tmpArray = _tmpArray + [_x];
			} else {
				_unit addWeapon _x;
				if (!(_x in (weapons _unit))) then {	// If it was not possible to add more
					_tmpArray = _tmpArray + [_x];
				};
			};
		} forEach _tools;
		_tools = _tmpArray;

		// Let one or two AI hoard the magazines
		_tmpArray = [];
		{
			if (_magCount < 12) then {
				_unit addMagazine _x;
				_magCount = _magCount + 1;
			} else {
				_tmpArray = _tmpArray + [_x];
			};
		} forEach _magazines;
		_magazines = _tmpArray;

		// Pick single back pack for each AI
		if (_i < count _backpacks) then {
			_backpack = _backpacks select _i;
			_unit addBackpack _backpack;
		};

		if (ai_custom_skills) then {
			switch (_skill) do {
				case 0 : {_aicskill = ai_custom_array1;};
				case 1 : {_aicskill = ai_custom_array2;};
				case 2 : {_aicskill= ai_custom_array3;};
				case "Random" : {_aicskill = ai_skill_random call BIS_fnc_selectRandom;};
			};
			{_unit setSkill [(_x select 0),(_x select 1)]} forEach _aicskill;
		} else {
			{_unit setSkill [_x,_skill]} forEach _skillarray;
		};
		ai_ground_units = (ai_ground_units + 1);
		_unit addEventHandler ["Killed",{[_this select 0, _this select 1, "ground"] call on_kill_neutral;}];
		if (_mission) then {
			_unit setVariable ["missionclean", "ground"];
		};
		_unitnumber = _unitnumber + 1;
	};
	_unitGroup selectLeader ((units _unitGroup) select 0);
	[_unitGroup, _position, _mission] call group_waypoints;

	diag_log format ["WAI: Spawned a group of %1 bandits at %2",_unitnumber,_position];
	_unitGroup
};

_keyItem = _this select 0;
_claimingPlayerUID = _this select 1;
_claimingPlayer = objNull;
insurancemissionstartstate = "Loading";

// Check player who tries to claim lost vehicle by insurance
{ if (isPlayer _x && {_claimingPlayerUID == getPlayerUID _x}) exitWith {_claimingPlayer = _x;}; } forEach playableUnits;
if (isNull _claimingPlayer) exitWith {
	diag_log format["WAI: Unknown player called claim on key %1", _keyItem];
	insurancemissionrunning = false;
	insurancemissionstartstate = "Unknown player";
};
diag_log format["WAI: Player %1 wants to claim insurance on key %1", _keyItem];

// Generate Character ID from key item
_isOK = isClass(configFile >> "CfgWeapons" >> _keyItem);
if(!_isOK) exitWith {
	diag_log ("WAI: Vehicle Insurance error: VEHICLE KEY does not exist: " + str(_keyItem));
	insurancemissionrunning = false;
	insurancemissionstartstate = "Invalid key";
};
_charID = str(getNumber(configFile >> "CfgWeapons" >> _keyItem >> "keyid"));
diag_log format["WAI: Character ID (Lock ID) is %1", _charID];


// Get vehicle from scrapyard table
_insuranceClaim = [_charID] call server_getInsuredVehicle;
if (count _insuranceClaim == 0) exitWith {
	diag_log ("WAI: Vehicle Insurance error: VEHICLE does not exist: " + str(_charID));
	insurancemissionrunning = false;
	insurancemissionstartstate = "Vehicle not found";
};

_vehclass = _insuranceClaim select 0;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");
_ws = _insuranceClaim select 2;
_inventory = _insuranceClaim select 3;
_coins = _insuranceClaim select 4;

_position = [_ws select 1] call _getPos;
diag_log format["WAI: Mission Insured Vehicle Started At %1",_position];

_veh = createVehicle [_vehclass,_position, [], 0, "CAN_COLLIDE"];
_vehdir = round(random 360);
_veh setDir _vehdir;
_veh setVariable ["ObjectID","1",true];
_veh setVariable ["", true];

_numWeapSlots = getNumber (configFile >> "CfgVehicles" >> _vehclass >> "transportMaxWeapons");
_numMagslots = getNumber (configFile >> "CfgVehicles" >> _vehclass >> "transportMaxMagazines");
_numBackpackSlots = getNumber (configFile >> "CfgVehicles" >> _vehclass >> "transportmaxbackpacks");
_estimatedNumUnits = round([_numWeapSlots, _numMagslots/12, _numBackpackSlots] call BIS_fnc_greatestNum);
_numUnitsPerGroup = 5;
_waves = _estimatedNumUnits / _numUnitsPerGroup;

_missiontimeout = true;
_cleanmission = false;
_playerPresent = false;
_starttime = floor(time);
_timecount = 0;
_expandedWeaponsList = (_inventory select 0) call _expandItemsList;
_stolenWeaponCount = round((count _expandedWeaponsList)/4);
_expandedMagsList = (_inventory select 1) call _expandItemsList;
_stolenMagsCount = round((count _expandedMagsList)/4);
_expandedBackpackList = (_inventory select 2) call _expandItemsList;
_stolenBackpackCount = round((count _expandedBackpackList)/4);

// Exclude the robbers from the pre-armed bandit unit count
_estimatedNumUnits = _estimatedNumUnits - round([count _expandedWeaponsList, (count _expandedMagsList)/12, count _expandedBackpackList] call BIS_fnc_greatestNum);

// Add inventory
clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

// Set vehicle lock
_veh setVariable ["CharacterID", _charID, true];
if (_charID != "0" && {!(_veh isKindOf "Bicycle")}) then {_veh setVehicleLock "locked";};

// Set coins if enabled
if (Z_SingleCurrency && {_vehclass in DZE_MoneyStorageClasses}) then {
	_veh setVariable ["cashMoney", _coins, true];
};

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];
diag_log format["WAI: Mission Insured Vehicle spawned a %1", _vehname];

_objPosition = getPosATL _veh;

_rndnum = _numUnitsPerGroup + (round (random 4) - 2);
_wavePos = [_objPosition,0,50,10,0,0.3,0] call BIS_fnc_findSafePos;
_waveGrp = [
	[_wavePos select 0, _wavePos select 1, 0],	//position
	_rndnum,					//Number Of units
	1,						//Skill level 0-1. Has no effect if using custom skills
	"Random",					//Primary gun set number. "Random" for random weapon set.
	4,						//Number of magazines
	"",						//Backpack "" for random or classname here.
	"Bandit2_DZ",					//Skin "" for random or classname here.
	"Random",					//Gearset number. "Random" for random gear set.
	true,						// Mission true or false
	-1,
	[_objPosition select 0, _objPosition select 1, 0],
	false
] call spawn_neutral_group;
_waves = _waves - 1;

[_position,_vehname] execVM "\z\addons\dayz_server\WAI\missions\compile\insurancemarkers.sqf";
[nil,_claimingPlayer,"loc",rTitleText,"The insured vehicle has been restored but it was found by bandits!! Check your map for the location!", "PLAIN",10] call RE;

insurancemissionstartstate = "Success";

while {_missiontimeout} do {
	sleep 5;
	_currenttime = floor(diag_tickTime);
	_timeelapsed = _currenttime - _starttime;
	_timecount = _timecount + 5;
	{if((isPlayer _x) AND (_x distance _position <= 150)) then {_playerPresent = true};}forEach playableUnits;
	if (_timeelapsed >= 1200) then {_cleanmission = true;};
	if (_timecount == 120 || _timecount == 240) then {	// 2,4, and 6 mins passed

		// Add a set of bots stealing 25% of cargo
		_splitWeapons = [_expandedWeaponsList, _stolenWeaponCount] call _splitListByCount;
		_stolenWeapons = _splitWeapons select 0;
		_remainingWeapons = _splitWeapons select 1;
		_splitMags = [_expandedMagsList, _stolenMagsCount] call _splitListByCount;
		_stolenMags = _splitMags select 0;
		_remainingMags = _splitMags select 1;
		_splitBackpacks = [_expandedBackpackList, _stolenBackpackCount] call _splitListByCount;
		_stolenBackpacks = _splitBackpacks select 0;
		_remainingBackpacks = _splitBackpacks select 1;
		local _skill = "Random";
		local _skin = "";
		local _isMission = true;
		
		// Spawn the bots with the stolen inventory
		[_position, _skill, _stolenWeapons, _stolenMags, _stolenBackpacks, _skin, _isMission] call _spawnAI;

		// Set remaining inventory as the next batch to be stolen from.
		_expandedWeaponsList = _remainingWeapons;
		_expandedMagsList = _remainingMags;
		_expandedBackpackList = _remainingBackpacks;
	};
	if (_timecount == 360) then {	// 2,4, and 6 mins passed

		// Add a set of bots stealing the remaining 25% of cargo
		_stolenWeapons = _expandedWeaponsList;
		_remainingWeapons = [];
		_stolenMags = _expandedMagsList;
		_remainingMags = [];
		_stolenBackpacks = _expandedBackpackList;
		_remainingBackpacks = [];
		local _skill = "Random";
		local _skin = "";
		local _isMission = true;
		
		// Spawn the bots with the stolen inventory
		[_position, _skill, _stolenWeapons, _stolenMags, _stolenBackpacks, _skin, _isMission] call _spawnAI;

		// Set remaining inventory as the next batch to be stolen from.
		_expandedWeaponsList = _remainingWeapons;
		_expandedMagsList = _remainingMags;
		_expandedBackpackList = _remainingBackpacks;
	};
	// Spawn reinforcement AI
	if (_waves > 0 && {({alive _x} count units _waveGrp) == 0}) then {
		_rndnum = _numUnitsPerGroup + (round (random 4) - 2);
		_wavePos = [_objPosition,200,300,10,0,0.3,0] call BIS_fnc_findSafePos;
		_waveGrp = [
			[_wavePos select 0, _wavePos select 1, 0],	//position
			_rndnum,					//Number Of units
			1,						//Skill level 0-1. Has no effect if using custom skills
			"Random",					//Primary gun set number. "Random" for random weapon set.
			4,						//Number of magazines
			"",						//Backpack "" for random or classname here.
			"Bandit2_DZ",					//Skin "" for random or classname here.
			"Random",					//Gearset number. "Random" for random gear set.
			true,						// Mission true or false
			-1,
			[_objPosition select 0, _objPosition select 1, 0],
			false
		] call spawn_neutral_group;
		_waves = _waves - 1;
	};

	if ((_playerPresent) || (_cleanmission)) then {_missiontimeout = false;};
};
if (_playerPresent) then {

	// Recompose any remaining inventory of the recovered vehicle...
	if ((count _expandedWeaponsList) > 0) then {
		_weaponcargo = _expandedWeaponsList call _compressItemsList;
		_weaponqty = _weaponcargo select 1;
		_weaponcargo = _weaponcargo select 0;
	} else {
		_weaponqty = [];
		_weaponcargo = [];
	};
	if ((count _expandedMagsList) > 0) then {
		_magcargo = _expandedMagsList call _compressItemsList;
		_magqty = _magcargo select 1;
		_magcargo = _magcargo select 0;
	} else {
		_magqty = [];
		_magcargo = [];
	};
	if ((count _expandedBackpackList) > 0) then {
		_backpackcargo = _expandedBackpackList call _compressItemsList;
		_backpackqty = _backpackcargo select 1;
		_backpackcargo = _backpackcargo select 0;
	} else {
		_backpackqty = [];
		_backpackcargo = [];
	};

	diag_log format["Adding back remaining cargo: [%1,%2,%3]...", _weaponcargo, _magcargo, _backpackcargo];
	{_veh addWeaponCargoGlobal [_x, _weaponqty select _forEachIndex];} forEach _weaponcargo;
	{if (_x != "CSGAS") then { _veh addMagazineCargoGlobal [_x, _magqty select _forEachIndex];} ;} forEach _magcargo;
	{_veh addBackpackCargoGlobal [_x, _backpackqty select _foreachindex];} foreach _backpackcargo;
	_inventory = [[_weaponcargo, _weaponqty], [_magcargo, _magqty], [_backpackcargo, _backpackqty]];

	[_veh,[_vehdir,_objPosition],_vehclass,false,_charID,_inventory] call custom_publish;
	waitUntil
	{
		sleep 5;
		_playerPresent = false;
		{if((isPlayer _x) AND (_x distance _position <= 30)) then {_playerPresent = true};}forEach playableUnits;
		(_playerPresent)
	};
	diag_log format["WAI: Mission Insured Vehicle Ended At %1",_position];
	[nil,nil,rTitleText,"Survivors have secured the recovered vehicle!", "PLAIN",10] call RE;

} else {
	clean_running_insurance_mission = True;
	{_cleanunits = _x getVariable "missionclean";
		if (!isNil "_cleanunits") then {
			switch (_cleanunits) do {
				case "ground" : {ai_ground_units = (ai_ground_units -1);};
				case "air" : {ai_air_units = (ai_air_units -1);};
				case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
				case "static" : {ai_emplacement_units = (ai_emplacement_units -1);};
			};
			deleteVehicle _x;
			sleep 0.05;
		};	
	} forEach allUnits;

	[_veh,[_vehdir,_objPosition],_vehclass,false,_charID,[]] call custom_publish;
	
	diag_log format["WAI: Mission Insured vehicle Timed Out At %1",_position];
	[nil,_claimingPlayer,"loc",rTitleText,"The owner did not secure the recovered insured vehicle on time, bandits stole all the cargo!", "PLAIN",10] call RE;
};

insurancemissionrunning = false;
