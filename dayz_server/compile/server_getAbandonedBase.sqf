private ["_key","_query","_baseList","_base","_baseId","_baseParts","_ws_x","_ws_y","_ws_z","_numberOfBaseParts","_qty","_baseArray","_obj","_continueLoading","_page","_pageSize","_objId","_DZE_VehObjects","_vehEhSetter"];

// Pass the event handler setter function from topside.
_vehEhSetter = _this select 0;

// Get an abandoned base from DB
_key = [];
_query = ["loadAbandonedBase", _key] call dayz_prepareDataForDB;
_baseList = _query call server_hiveReadWrite;

if ((count _baseList) == 0) exitWith {
	diag_log "INFO: No abandoned bases available yet.";
	_baseList = [];
	_baseList
};

_base = _baseList call BIS_fnc_selectRandom;
_baseId = _base select 0;
_ws_x = _base select 1;
_ws_y = _base select 2;
_ws_z = _base select 3;

// Publish the abandoned base parts from DB (using old datestamp and last_updated)
_key = [_baseId];
_query = ["publishAbandonedBaseParts", _key] call dayz_prepareDataForDB;
_query call server_hiveWrite;

// Wait for the query to finish...
sleep 10;

_page = 0;
_pageSize = 100;
_qty = 0;
_baseArray = [];
_continueLoading = true;

while {_continueLoading} do
{
	_key = [_baseId, _page * _pageSize, _pageSize];
	_query = ["getPublishedAbandonedBasePartIds", _key] call dayz_prepareDataForDB;
	_baseParts = _query call server_hiveReadWrite;

	_numberOfBaseParts = count _baseParts;
	if (_numberOfBaseParts > 0) then
	{
		for "_i" from 0 to _numberOfBaseParts - 1 do
		{
			_key = [(_baseParts select _i) select 0];
			_query = ["getObject", _key] call dayz_prepareDataForDB;
			_obj = _query call server_hiveReadWriteSingle;

			_baseArray set [_qty,_obj];
			_qty = _qty + 1;
		};
	};
	_page = _page + 1;
	if (_numberOfBaseParts < _pageSize) then
	{
		_continueLoading = false;
	};
};

// Get each old base part via this loop
if ((count _baseArray) == 0) exitWith {
	diag_log "ERROR: Failed to load abandoned base's parts!";
	_baseArray = [];
	_baseArray
};
_DZE_VehObjects = [];

// Create the base objects
{
	private["_idKey","_type","_ownerID","_worldspace","_inventory","_hitPoints","_fuel","_damage","_storageMoney","_maintenanceMode","_maintenanceModeVars","_dir","_pos","_wsDone","_wsCount","_vector","_vecExists","_ownerPUID","_posATL","_ws2TN","_ws3TN","_object","_nonCollide","_doorLocked","_isPlot","_isDZ_Buildable","_isTrapItem","_isSafeObject","_weaponcargo","_magcargo","_backpackcargo","_weaponqty","_magqty","_backpackqty","_lockable","_codeCount","_xTypeName","_x1","_isAir","_selection","_dam"];
	_idKey = 		_x select 0;
	_type =			_x select 1;
	_ownerID = 		_x select 2;
	_worldspace = [_x select 6, [_x select 3, _x select 4, _x select 5]];
	if ((_x select 7) != '0') then {
		_worldspace set [count _worldspace, _x select 7];
	};
	if (count (_x select 8) > 0) then {
		_worldspace set [count _worldspace, _x select 8];
	};
	if (_type == "Plastic_Pole_EP1_DZ" || _type in DZE_DoorsLocked) then {
		_inventory =	_x select 9;	// Friendlies list in inventory
	} else {
		_inventory =	[_x select 10, _x select 9, _x select 11]; // weapons, magazines, backpacks
		if (count (_x select 10) == 0) then {
			_inventory set [1, [[],[]]];
		};
		if (count (_x select 9) == 0) then {
			_inventory set [0, [[],[]]];
		};
		if (count (_x select 11) == 0) then {
			_inventory set [2, [[],[]]];
		};
	};
	_hitPoints = _x select 12;
	_fuel =	_x select 13;
	_damage = _x select 14;
	_storageMoney = _x select 15;

	//set object to be in maintenance mode
	_maintenanceMode = false;
	_maintenanceModeVars = [];

	_dir = 90;
	_pos = [0,0,0];
	_wsDone = false;
	_wsCount = count _worldspace;

	//Vector building
	_vector = [[0,0,0],[0,0,0]];
	_vecExists = false;
	_ownerPUID = "0";

	if (_wsCount >= 2) then {
		_dir = _worldspace select 0;
		_posATL = _worldspace select 1;
		if (count _posATL == 3) then {
			_pos = _posATL;
			_wsDone = true;
		};
		if (_wsCount >= 3) then{
			_ws2TN = typename (_worldspace select 2);
			_ws3TN = typename (_worldspace select 3);
			if (_wsCount == 3) then{
					if (_ws2TN == "STRING") then{
						_ownerPUID = _worldspace select 2;
					} else {
						 if (_ws2TN == "ARRAY") then{
							_vector = _worldspace select 2;
							_vecExists = true;
						};
					};
			} else {
				if (_wsCount == 4) then{
					if (_ws3TN == "STRING") then{
						_ownerPUID = _worldspace select 3;
					} else {
						if (_ws2TN == "STRING") then{
							_ownerPUID = _worldspace select 2;
						};
					};
					if (_ws2TN == "ARRAY") then{
						_vector = _worldspace select 2;
						_vecExists = true;
					} else {
						if (_ws3TN == "ARRAY") then{
							_vector = _worldspace select 3;
							_vecExists = true;
						};
					};
				};
			};
		} else {
			_worldspace set [count _worldspace, "0"];
		};
	};

	if (!_wsDone) then {
		if ((count _posATL) >= 2) then {
			_pos = [_posATL select 0,_posATL select 1,0];
			diag_log format["INFO: Abandoned Base; moved %1 of class %2 with worldspace array = %3 to pos: %4",_idKey,_type,_worldspace,_pos];
		} else {
			diag_log format["INFO: Abandoned Base; moved %1 of class %2 with worldspace array = %3 to pos: [0,0,0]",_idKey,_type,_worldspace];
		};
	};
	if ("Maintenance" in _hitPoints) then {
		_maintenanceModeVars = [_type,_pos];
		_type = _type + "_Damaged";
	};
	_nonCollide = _type in DayZ_nonCollide;

	//Create it
	if (_nonCollide) then {
		_object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
	} else {
		_object = _type createVehicle [0,0,0]; //more than 2x faster than createvehicle array
	};
	_object setDir _dir;
	_object setPosATL _pos;
	_object setDamage _damage;
	if (_vecExists) then {
		_object setVectorDirAndUp _vector;
	};
	_object enableSimulation false;

	_doorLocked = _type in DZE_DoorsLocked;
	_isPlot = _type == "Plastic_Pole_EP1_DZ";

	_object setVariable ["lastUpdate",diag_ticktime];
	_object setVariable ["ObjectID", _idKey, true];
	_object setVariable ["OwnerPUID", _ownerPUID, true];

	if (Z_SingleCurrency && {_type in DZE_MoneyStorageClasses}) then {
		_object setVariable [Z_MoneyVariable, _storageMoney, true];
	};

	dayz_serverIDMonitor set [count dayz_serverIDMonitor,_idKey];

	if (!_wsDone) then {[_object,"position",true] call server_updateObject;};
	if (_type == "Base_Fire_DZ") then {_object spawn base_fireMonitor;};

	_isDZ_Buildable = _object isKindOf "DZ_buildables";
	_isTrapItem = _object isKindOf "TrapItems";
	_isSafeObject = _type in DayZ_SafeObjects;

	//Dont add inventory for traps.
	if (!_isDZ_Buildable && !_isTrapItem) then {
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
				_weaponcargo = _inventory select 0 select 0;
				_magcargo = _inventory select 1 select 0;
				_backpackcargo = _inventory select 2 select 0;
				_weaponqty = _inventory select 0 select 1;
				{_object addWeaponCargoGlobal [_x, _weaponqty select _foreachindex];} foreach _weaponcargo;

				_magqty = _inventory select 1 select 1;
				{_object addMagazineCargoGlobal [_x, _magqty select _foreachindex];} foreach _magcargo;

				_backpackqty = _inventory select 2 select 1;
				{_object addBackpackCargoGlobal [_x, _backpackqty select _foreachindex];} foreach _backpackcargo;
			};
		} else {
			if (DZE_permanentPlot && _isPlot) then {
				// DEBUG
				diag_log format["PLOT DEBUG: Setting plot friends for plot owner: %1: %2", _ownerPUID, _inventory];
				_object setVariable ["plotfriends", _inventory, true];
			};
			if (DZE_doorManagement && _doorLocked) then {
				_object setVariable ["doorfriends", _inventory, true];
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
			if (_ownerID != "0" && {!(_object isKindOf "Bicycle")}) then {_object setVehicleLock "locked";};
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
		if (_isDZ_Buildable || {(_isSafeObject && !_isTrapItem)}) then {
			_object setVariable["memDir",_dir,true];
			if (DZE_GodModeBase && {!(_type in DZE_GodModeBaseExclude)}) then {
				_object addEventHandler ["HandleDamage",{false}];
			} else {
				_object addMPEventHandler ["MPKilled",{_this call vehicle_handleServerKilled;}];
			};
			_object setVariable ["OEMPos",_pos,true]; // used for inplace upgrades and lock/unlock of safe
		} else {
			_object enableSimulation true;
		};
		if (_isDZ_Buildable || {_isTrapItem}) then {
			//Use inventory for owner/clan info and traps armed state
			{
				_xTypeName = typeName _x;
				switch (_xTypeName) do {
					case "ARRAY": {
						_x1 = _x select 1;
						switch (_x select 0) do {
							case "ownerArray" : { _object setVariable ["ownerArray", _x1, true]; };
							case "clanArray" : { _object setVariable ["clanArray", _x1, true]; };
							case "armed" : { _object setVariable ["armed", _x1, true]; };
							case "padlockCombination" : { _object setVariable ["dayz_padlockCombination", _x1, false]; };
							case "BuildLock" : { _object setVariable ["BuildLock", _x1, true]; };
						};
					};
					case "STRING": {_object setVariable ["ownerArray", [_x], true]; };
					case "BOOLEAN": {_object setVariable ["armed", _x, true]};
				};
			} foreach _inventory;

			if (_maintenanceMode) then { _object setVariable ["Maintenance", true, true]; _object setVariable ["MaintenanceVars", _maintenanceModeVars]; };
		};
	};
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object]; //Monitor the object
} forEach _baseArray;

diag_log format["INFO: Loaded abandoned base with ID %1 and location [%2, %3, %4]", _baseId, _ws_x, _ws_y, _ws_z];

// Return abandoned base data from DB
[_baseId, _ws_x, _ws_y, _ws_z]
