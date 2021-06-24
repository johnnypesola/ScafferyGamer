private ["_key","_query","_baseList","_base","_baseId","_baseParts","_ws_x","_ws_y","_ws_z","_numberOfBaseParts","_qty","_obj","_page","_pageSize","_objId","_DZE_VehObjects","_vehEhSetter","_uniqId","_dataStatus","_accessResult","_numFields","_numRows","_columnNames","_foundSafePos","_tries","_banditPositions","_mgBandits","_maawsBandits","_stingerBandits","_sniperBandits","_plotPositions"];

// Pass the event handler setter function from topside.
_vehEhSetter = _this select 0;

local _tableName = "napf";
if (DZE_Extras_WorldName == "chernarus") then {
	_tableName = "cherno";
};

// Enable access to abandoned bases from DB


_key = format["CHILD:500:%1:[""Object.object_data_bases_%2"",""Object.object_data_base_parts_%2"",""Object.object_data_sub_bases_%2""]::",(profileNamespace getVariable "SUPERKEY"), _tableName];
_accessResult = _key call server_hiveReadWrite;
diag_log format ["changeTableAccess result: %1", _accessResult];

diag_log "Fetching abandoned bases list...";

// Get an abandoned base from DB
_key = format["CHILD:501:Object.object_data_bases_%1:[""base_id"",""ws_x"",""ws_y"",""ws_z""]:[[""base_id"",""IS NOT NULL""]]:[0,500]:", _tableName];
_uniqId = _key call server_hiveReadWrite;
if ((_uniqId select 0) == "PASS") then {
	_uniqId = _uniqId select 1;
	diag_log format ["Got Unique ID: %1", _uniqId];
} else {
	diag_log format ["Failed to get Unique ID", _uniqId];
	if (true) exitWith {[]};
};

_base = ["NA"];
_baseList = [];
_dataStatus = [];
_numRows = 0;
_numFields = 0;
_columnNames = [];

_key = format["CHILD:503:%1:", _uniqId];
_dataStatus = _key call server_hiveReadWrite;
if ((_dataStatus select 0) == "PASS") then {
	diag_log format ["Data status for ID %1 is : %2", _uniqId, _dataStatus];
	_numRows = _dataStatus select 1;
	_numFields = _dataStatus select 2;
	_columnNames = _dataStatus select 3;
} else {
	diag_log format ["Failed to get data status for ID %1 : %2", _uniqId, _dataStatus];
	if (true) exitWith {[]};
};

while {((_base select 0) != "NOMORE") && {_numRows > 0}} do {
	_key = format["CHILD:504:%1:", _uniqId];
	_base = _key call server_hiveReadWrite;
	if ((_base select 0) == "UNKID") exitWith {};
	if ((_base select 0) != "PASS") exitWith {
		diag_log format ["Could not get data row for ID %1 : %2", _uniqId, _base];
	};
	_base = _base select 1;
	_baseList = _baseList + [_base];
	_numRows = _numRows - 1;
};
diag_log format ["Get an abandoned base from this list: %1", _baseList];

if ((count _baseList) == 0) exitWith {
	diag_log "INFO: No abandoned bases available yet.";
	_baseList = [];
	_baseList
};

_foundSafePos = false;
_tries = 0;
while {!_foundSafePos && _tries < 100} do {
	_base = _baseList call BIS_fnc_selectRandom;
	//_base = _baseList select 2;
	diag_log format["Base: %1", _base];
	_baseId = parseNumber (_base select 0);
	_ws_x = parseNumber (_base select 1);
	_ws_y = parseNumber (_base select 2);
	_ws_z = parseNumber (_base select 3);
	diag_log format["BaseID: %1, X: %2, Y: %3, Z: %4", _baseId, _ws_x, _ws_y, _ws_z];
	
	if (0 == count ([_ws_x, _ws_y, _ws_z] nearObjects ["Plastic_Pole_EP1_DZ", 50]) &&
		{0 == count ([_ws_x, _ws_y, _ws_z] nearObjects ["AllVehicles", 50])}) then {
		_foundSafePos = true;
	};
	_tries = _tries + 1;
	sleep 0.2;
};
if (_tries >= 100) exitWith {
	diag_log "ERROR: Failed to find free spot for abandoned base!";
	[]
};

// Publishing baseparts with old datestamp won't work with HiveExt.dll
// We will read them and create the parts in-game but we won't publish them yet.

_key = format["CHILD:501:Object.object_data_base_parts_%1:[""object_id"",""classname"",", _tableName];
_key = _key + """character_id"",""ws_x"",""ws_y"",""ws_z"",""ws_dir"",""ws_ownerpuid"",""ws_vect"",";
_key = _key + """inventory_magazines"",""inventory_weapons"",""inventory_backpacks"",""hitpoints"",""fuel"",""damage"",""storage_coins""]:";
_key = _key + format["[[""base_id"",""="",""%1""]]:[0,500]:", _baseId];
_uniqId = _key call server_hiveReadWrite;
if ((_uniqId select 0) == "PASS") then {
	_uniqId = _uniqId select 1;
	diag_log format ["Got Unique ID: %1", _uniqId];
} else {
	diag_log format ["Failed to get Unique ID", _uniqId];
	if (true) exitWith {[]};
};

_dataStatus = [];
_numRows = 0;
_numFields = 0;
_columnNames = [];

_key = format["CHILD:503:%1:", _uniqId];
_dataStatus = _key call server_hiveReadWrite;
if ((_dataStatus select 0) == "PASS") then {
	diag_log format ["Data status for ID %1 is : %2", _uniqId, _dataStatus];
	_numRows = _dataStatus select 1;
	_numFields = _dataStatus select 2;
	_columnNames = _dataStatus select 3;
} else {
	diag_log format ["Failed to get data status for ID %1 : %2", _uniqId, _dataStatus];
	if (true) exitWith {[]};
};

_obj = ["NA"];
_baseParts = [];
while {((_obj select 0) != "NOMORE") && {_numRows > 0}} do {
	_key = format["CHILD:504:%1:", _uniqId];
	_obj = _key call server_hiveReadWrite;
	if ((_obj select 0) == "UNKID") exitWith {};
	if ((_obj select 0) != "PASS") exitWith {
		diag_log format ["Could not get data row for ID %1 : %2", _uniqId, _obj];
	};
	_obj = _obj select 1;
	_baseParts = _baseParts + [_obj];
	_numRows = _numRows - 1;
};
diag_log format ["Got abandoned base parts for base ID %1:", _baseId];
{ diag_log format ["Part: %1", _x]; } forEach _baseParts;

// Get each old base part via this loop
if ((count _baseParts) == 0) exitWith {
	diag_log "ERROR: Failed to load abandoned base's parts!";
	_baseParts = [];
	_baseParts
};
_DZE_VehObjects = [];
_objId = 0;

_mgBandits = [];
_maawsBandits = [];
_stingerBandits = [];
_banditPositions = [];

// Create the base objects
{
	private["_idKey","_type","_ownerID","_ws_x","_ws_y","_ws_z","_inventory_magazines","_inventory_weapons","_inventory_backpacks","_hitPoints","_fuel","_damage","_storageMoney","_maintenanceMode","_maintenanceModeVars","_dir","_pos","_wsDone","_wsCount","_vector","_vecExists","_ownerPUID","_posATL","_ws2TN","_ws3TN","_object","_nonCollide","_doorLocked","_isPlot","_isDZ_Buildable","_isTrapItem","_isSafeObject","_weaponcargo","_magcargo","_backpackcargo","_weaponqty","_magqty","_backpackqty","_lockable","_codeCount","_xTypeName","_x1","_isAir","_selection","_dam"];
	_idKey = 		_x select 0;
	_type =			_x select 1;
	_ownerID = 		_x select 2;
	_ws_x =			parseNumber (_x select 3);
	_ws_y =			parseNumber (_x select 4);
	_ws_z =			parseNumber (_x select 5);
	_dir =			parseNumber (_x select 6);
	_ownerPUID =		_x select 7;
	_ws_vect =		call compile (_x select 8);
	_inventory_magazines =	call compile (_x select 9);
	_inventory_weapons =	call compile (_x select 10);
	_inventory_backpacks =	call compile (_x select 11);
	_hitPoints = 		call compile (_x select 12);
	_fuel =			parseNumber (_x select 13);
	_damage = 		parseNumber (_x select 14);
	_storageMoney = 	parseNumber (_x select 15);

	//set object to be in maintenance mode
	_maintenanceMode = false;
	_maintenanceModeVars = [];

	_pos = [_ws_x, _ws_y, _ws_z];

	_inventory = [_inventory_weapons, _inventory_magazines, _inventory_backpacks];

	//Vector building
	_vector = [[0,0,0],[0,0,0]];
	if (!isNil "_ws_vect" && {(count _ws_vect) > 0}) then {
		_vector = _ws_vect;
	};

	if (_type in ["MAP_pumpkin2","MAP_pumpkin","MAP_p_Helianthus","fiberplant"]) then {
		if (_type == "MAP_pumpkin" || _type == "MAP_pumpkin2") then {
			_mgBandits = _mgBandits + [[_dir, _pos]];
		};
		if (_type == "MAP_p_Helianthus") then {
			_maawsBandits = _maawsBandits + [[_dir, _pos]];
		};
		if (_type == "fiberplant") then {
			_stingerBandits = _stingerBandits + [[_dir, _pos]];
		};
	} else {
		//Create it
		_object = _type createVehicle [0,0,0]; //more than 2x faster than createvehicle array
		_object setDir _dir;
		_object setPosATL _pos;
		_object setDamage _damage;
		if ((count _vector) > 0) then {
			if (!([_vector, [[0,0,0],[0,0,0]]] call BIS_fnc_areEqual)) then {
				_object setVectorDirAndUp _vector;
			};
		};
		_object enableSimulation false;

		_doorLocked = _type in DZE_DoorsLocked;
		_isPlot = _type == "Plastic_Pole_EP1_DZ";

		// Use this temporarily until it is published. When it is, then it will get the appropriate ID in DB.
		// For buildable object updates the ObjectUID will be used.
		_idKey = "0";
		_object setVariable ["lastUpdate",diag_ticktime];
		_object setVariable ["ObjectID", _idKey, true];
		_object setVariable ["OwnerPUID", _ownerPUID, true];
		_object setVariable ["ObjectUID", ([_dir, _pos] call dayz_objectUID2), true]; 

		if (Z_SingleCurrency && {_type in DZE_MoneyStorageClasses}) then {
			_object setVariable [Z_MoneyVariable, _storageMoney, true];
		};

		if (_type == "Base_Fire_DZ") then {_object spawn base_fireMonitor;};

		_isTrapItem = _object isKindOf "TrapItems";
		_isSafeObject = _type in DayZ_SafeObjects;

		//Dont add inventory for traps.
		if (!_isTrapItem) then {
			clearWeaponCargoGlobal _object;
			clearMagazineCargoGlobal _object;
			clearBackpackCargoGlobal _object;
			if( (count _inventory > 0) && !_isPlot && !_doorLocked) then {
				if (_type in DZE_LockedStorage) then {
					// Do not send big arrays over network! Only server needs these
					_object setVariable ["WeaponCargo",(_inventory select 0),false];
					_object setVariable ["MagazineCargo",(_inventory select 1),false];
					_object setVariable ["BackpackCargo",(_inventory select 2),false];
				} else {
					if (count (_inventory select 0) == 2) then {
						_weaponcargo = _inventory select 0 select 0;
						_weaponqty = _inventory select 0 select 1;
					} else {
						_weaponcargo = [];
						_weaponqty = []; 
					};
					if (count (_inventory select 1) == 2) then {
						_magcargo = _inventory select 1 select 0;
						_magqty = _inventory select 1 select 1;
					} else {
						_magcargo = [];
						_magqty = [];
					};
					if (count (_inventory select 2) == 2) then {
						_backpackcargo = _inventory select 2 select 0;
						_backpackqty = _inventory select 2 select 1;
					} else {
						_backpackcargo = [];
						_backpackqty = [];
					};
					{_object addWeaponCargoGlobal [_x, _weaponqty select _foreachindex];} foreach _weaponcargo;
					{if (_x != "CSGAS") then {_object addMagazineCargoGlobal [_x, _magqty select _foreachindex];};} foreach _magcargo;
					{_object addBackpackCargoGlobal [_x, _backpackqty select _foreachindex];} foreach _backpackcargo;
				};
			} else {
				if (DZE_permanentPlot && _isPlot) then {
					// DEBUG
					diag_log format["PLOT DEBUG: Setting plot friends for plot owner: %1: %2", _ownerPUID, _inventory];
					_object setVariable ["plotfriends", _inventory_magazines, true];	// Assume the friends are stored here.
				};
				if (DZE_doorManagement && _doorLocked) then {
					_object setVariable ["doorfriends", _inventory_magazines, true];	// Assume the friends are stored here.
				};
			};
		};

		if ((typeOf _object) in ["M2StaticMG", "DSHKM_CDF"]) then {
			_object enableSimulation true;
		};

		if (_object isKindOf "AllVehicles") then {
			_object setVariable ["CharacterID", _ownerID, true];
			_object setFuel _fuel;
			if (!_isSafeObject) then {
				_DZE_VehObjects set [count _DZE_VehObjects,_object];
				_object call _vehEhSetter;
				if (_ownerID != "0" && {!(_object isKindOf "Bicycle")} && {!((typeOf _object) in ["M2StaticMG","DSHKM_CDF"])}) then {_object setVehicleLock "locked";};
			} else {
				_object enableSimulation true;
			};
		} else {
			// Fix for leading zero issues on safe codes after restart
			_lockable = getNumber (configFile >> "CfgVehicles" >> _type >> "lockable");
			_codeCount = count (toArray _ownerID);
			switch (_lockable) do {
				case 4: {
					switch (_codeCount) do {
						case 3: {_ownerID = format["0%1",_ownerID];};
						case 2: {_ownerID = format["00%1",_ownerID];};
						case 1: {_ownerID = format["000%1",_ownerID];};
					};
				};
				case 3: {
					switch (_codeCount) do {
						case 2: {_ownerID = format["0%1",_ownerID];};
						case 1: {_ownerID = format["00%1",_ownerID];};
					};
				};
			};
			_object setVariable ["CharacterID", _ownerID, true];
			if (_isSafeObject && !_isTrapItem) then {
				_object setVariable["memDir",_dir,true];
				_object addMPEventHandler ["MPKilled",{_this call vehicle_handleServerKilled;}];
				_object setVariable ["OEMPos",_pos,true]; // used for inplace upgrades and lock/unlock of safe
			} else {
				_object enableSimulation true;
			};
			if (_isTrapItem) then {
				//Use inventory traps armed state
				{
					_xTypeName = typeName _x;
					if (_xTypeName == "ARRAY") then {
						_x1 = _x select 1;
						_object setVariable ["armed", _x1, true];
					} else {
						_object setVariable ["armed", _x, true];
					};
				} count _inventory;

				if (_maintenanceMode) then { _object setVariable ["Maintenance", true, true]; _object setVariable ["MaintenanceVars", _maintenanceModeVars]; };
			};
		};
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object]; //Monitor the object
		_objId = _objId + 1;
	};
} forEach _baseParts;

// Read in base plot poles
_key = format["CHILD:501:Object.object_data_sub_bases_%1:[""base_part_id"",""ws_x"",""ws_y"",""ws_z""]:[[""base_id"",""="",""%2""]]:[0,500]:", 
	_tableName, _baseId];
_uniqId = _key call server_hiveReadWrite;
if ((_uniqId select 0) == "PASS") then {
	_uniqId = _uniqId select 1;
	diag_log format ["Got Unique ID: %1", _uniqId];
} else {
	diag_log format ["Failed to get Unique ID", _uniqId];
	if (true) exitWith {[]};
};

_dataStatus = [];
_numRows = 0;
_numFields = 0;
_columnNames = [];

_key = format["CHILD:503:%1:", _uniqId];
_dataStatus = _key call server_hiveReadWrite;
if ((_dataStatus select 0) == "PASS") then {
	diag_log format ["Data status for ID %1 is : %2", _uniqId, _dataStatus];
	_numRows = _dataStatus select 1;
	_numFields = _dataStatus select 2;
	_columnNames = _dataStatus select 3;
} else {
	diag_log format ["Failed to get data status for ID %1 : %2", _uniqId, _dataStatus];
	if (true) exitWith {[]};
};

_obj = ["NA"];
_baseParts = [];
while {((_obj select 0) != "NOMORE") && {_numRows > 0}} do {
	_key = format["CHILD:504:%1:", _uniqId];
	_obj = _key call server_hiveReadWrite;
	if ((_obj select 0) == "UNKID") exitWith {};
	if ((_obj select 0) != "PASS") exitWith {
		diag_log format ["Could not get data row for ID %1 : %2", _uniqId, _obj];
	};
	_obj = _obj select 1;
	_baseParts = _baseParts + [_obj];
	_numRows = _numRows - 1;
};
_plotPositions = [];
diag_log format ["Got abandoned base plot poles for base ID %1:", _baseId];
{
	_plotPositions = _plotPositions + [
		[
			parseNumber (_x select 0),
			parseNumber (_x select 1),
			parseNumber (_x select 2),
			parseNumber (_x select 3)
		]
	];
	diag_log format ["Plot pole: %1", _x];
} forEach _baseParts;

// Get each old base part via this loop
if ((count _plotPositions) == 0) exitWith {
	diag_log "ERROR: Failed to load abandoned base's plot poles!";
	_plotPositions = [];
	_plotPositions
};

diag_log format["INFO: Loaded abandoned base with ID %1 and location [%2, %3, %4]", _baseId, _ws_x, _ws_y, _ws_z];

_banditPositions = [_mgBandits, _maawsBandits, _stingerBandits];

// Return abandoned base ID, location and plot poles from DB
[_baseId, _ws_x, _ws_y, _ws_z, _plotPositions, _banditPositions]
