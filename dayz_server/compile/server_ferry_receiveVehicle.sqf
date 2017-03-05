private ["_activatingPlayer","_isOK","_veh","_worldspace","_location","_dir","_class","_uid","_key","_query","_keySelected","_donotusekey","_result","_oid","_row","_fromInstance","_toInstance","_class","_charID","_inventoryMagazines","_inventoryWeapons","_inventoryBackpacks","_hitpoints","_fuel","_damage","_objWpnTypes","_objWpnQty","_passengers","_passengerIdx","_canBeOverWater","_playerUID","_playerName","_pos","_found","_driver","_commander","_turrets","_subturrets","_cargo"];

_activatingPlayer = _this select 0;

// if player is NULL
if (isNull _activatingPlayer) exitWith { 
	diag_log "FERRY: ERROR: Player object NULL attempted transport reception. Exiting...";
};

_playerUID = getPlayerUID _activatingPlayer;
_playerName = name _activatingPlayer;

// Check if already in transit
_key = [_playerUID];
_query = ["inTransit", _key] call dayz_prepareDataForDB;
_result = _query call server_hiveReadWrite;

if ((count _result) == 0) exitWith {
	diag_log format ["FERRY: Player %1 [%2] does not have a vehicle in transit.", _playerName, _playerUID];

	// Check if is friend/passenger of existing transport
	if (missionNamespace getVariable[format["transit_%1",_playerUID], false]) then {
		PV_travel_boardRcvdVeh = [2, objNull, 0, []];
		(owner _activatingPlayer) publicVariableClient "PV_travel_boardRcvdVeh";
		diag_log format ["FERRY: Notify client %1 (%2) to wait for ferry.", owner _activatingPlayer, name _activatingPlayer];
	} else {

		// Move player to terminal and end loading screen, otherwise keep player at debug position.
		_pos = [server_ferryTerminalPos, 10, 200, 1, 0, 0.5, 0] call BIS_fnc_findSafePos;
		_pos set [2, 0.3];
		_activatingPlayer setPos _pos;

		PV_travel_boardRcvdVeh = [0, objNull, 0, []];
		(owner _activatingPlayer) publicVariableClient "PV_travel_boardRcvdVeh";
		diag_log format ["FERRY: Send client %1 (%2) to ferry terminal.", owner _activatingPlayer, name _activatingPlayer];
	};
};

// Get vehicle from ferry
_oid = (_result select 0) select 0;
_key = [_oid];
_query = ["showFerryContent", _key] call dayz_prepareDataForDB;
_result = _query call server_hiveReadWrite;

if (0 == count _result) exitWith {
	diag_log format ["FERRY: Database error: Unable to find player %1's [%2] vehicle in transit (ID: %3).", _playerName, _playerUID, _oid];
};

if (0 == count (_result select 0)) exitWith {
	diag_log format ["FERRY: Database error: Player %1's [%2] vehicle in transit (ID: %3) entry has no data!", _playerName, _playerUID, _oid];
};

// Get data for vehicle
_row = _result select 0;
_fromInstance = 	_row select 1;
_toInstance = 		_row select 2;
_class = 		_row select 3;
_driver =		_row select 4;
_commander =		_row select 5;
_turrets =		_row select 6;
_cargo =		_row select 7;
_charID = 		_row select 8;
_inventoryMagazines = 	_row select 9;
_inventoryWeapons = 	_row select 10;
_inventoryBackpacks = 	_row select 11;
_hitpoints = 		_row select 12;
_fuel = 		_row select 13;
_damage = 		_row select 14;

diag_log format ["FERRY: DEBUG: Got row data: %1", _row];

// Add all passengers to wait list
if (_commander != "0") then {
	missionNamespace setVariable [format["transit_%1", _commander], true];
};
for "_i" from 0 to (count _turrets)-1 do {
	if ("ARRAY" == typeName (_turrets select _i)) then {
		_subturrets = _turrets select _i;
		for "_j" from 0 to (count _subturrets)-1 do {
			missionNamespace setVariable [format["transit_%1", _subturrets select _j], true];
		};
	} else {
		missionNamespace setVariable [format["transit_%1", _turrets select _i], true];
	};
};
for "_i" from 0 to (count _cargo)-1 do {
	missionNamespace setVariable [format["transit_%1", _cargo select _i], true];
};


if (_fromInstance == dayZ_instance) exitWith {

	diag_log format["FERRY: Vehicle %1 was sent from this instance by %2 [%3], it will not be spawned in.", _class, _playerName, _playerUID]; 
	PV_travel_boardRcvdVeh = [0, objNull, 0, []];
	(owner _activatingPlayer) publicVariableClient "PV_travel_boardRcvdVeh";
	diag_log format ["FERRY: Send client %1 (%2) to ferry terminal.", owner _activatingPlayer, _playerName];
};

_canBeOverWater = 1;
_pos = [server_ferryTerminalPos, 0, 300, 10, _canBeOverWater, 20, 0] call BIS_fnc_findSafePos; // Set position to somewhere safe in spawning zone

diag_log format ["FERRY: Spawning vehicle at %1", _pos];

if (_damage >= 1) exitWith {
	diag_log format ["FERRY: Vehicle %1 transported in by player %2 [%3] has been destroyed!", _class, _playerName, _playerUID];
};


_dir = 0; // Always face north
if (_class isKindOf "Air") then {
	// Create at 400m altitude
	_pos = [_pos select 0, _pos select 1, 400];
	_veh = createVehicle [_class, ATLToASL (_pos), [], 0, "FLY"];
	_veh setVariable ["ObjectID", "1"];	// Protect the vehicle so that server won't delete it
} else {
	// Create on ground / water surface
	_pos = [_pos select 0, _pos select 1, 0.1];
	_veh = createVehicle [_class, ATLToASL (_pos), [], 0, "CAN_COLLIDE"];
	_veh setVariable ["ObjectID", "1"];	// Protect the vehicle so that server won't delete it
};

// All these are Super Hero/Bandit vehicles, ammo is always present after restart.
switch (_class) do {
	case "DSHKM_CDF": {
		_veh removeMagazinesTurret ["50Rnd_127x107_DSHKM", [0]];
	};
	case "M2StaticMG": {
		_veh removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
	};
	case "M113_TK_EP1": {
		//_veh removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
	};
	case "AH6J_EP1": {
		//_veh removeMagazinesTurret ["4000Rnd_762x51_M134", [-1]];
		_veh removeMagazinesTurret ["14Rnd_FFAR", [-1]];
	};
	case "UH1Y": {
		_veh removeMagazinesTurret ["14Rnd_FFAR", [-1]];
	};
	case "Ka60_PMC": {
		_veh setVehicleAmmo 0;
	};
	case "pook_H13_gunship": {
		//_veh removeMagazinesTurret ["pook_1300Rnd_762x51_M60", [-1]];
	};
	case "pook_H13_transport_GUE": {
		//_veh removeMagazinesTurret ["pook_250Rnd_762x51", [0]];
	};
	case "M1126_ICV_M2_EP1": {
		//_veh removeMagazinesTurret ["100Rnd_127x99_M2", [0]];
	};
	case "M1126_ICV_mk19_EP1": {
		//_veh removeMagazinesTurret ["48Rnd_40mm_MK19", [0]];
	};
};

if (_charID != "0") then {
	_donotusekey = true;
	_keySelected = _charID;
};

clearWeaponCargoGlobal  _veh;
clearMagazineCargoGlobal  _veh;

_veh setdir _dir;
if (_veh isKindOf "Air") then {
	_veh setposASL [_pos select 0, _pos select 1, 400];
	_pos = getPosASL _veh;
	if (3 > count _pos) then { _pos = ATLToASL ([_pos select 0, _pos select 1, 0.01]);};
} else {
	_veh setposASL [_pos select 0, _pos select 1, 0.01];
	_pos = getPosASL _veh;
	if (3 > count _pos) then { _pos = ATLToASL ([_pos select 0, _pos select 1, 0.01]);};
};

diag_log format ["FERRY: Spawning vehicle at %1", _pos];

{
	_selection = _x select 0;
	_dam = _x select 1;
	if (_selection in dayZ_explosiveParts && _dam > 0.8) then {_dam = 0.8};
	[_veh,_selection,_dam] call object_setFixServer;
} count _hitpoints;


_veh setDamage _damage;
_veh setFuel _fuel;

//Add Weapons
_objWpnTypes = _inventoryWeapons select 0;
_objWpnQty = _inventoryWeapons select 1;
_countr = 0;
{
	if(_x in (DZE_REPLACE_WEAPONS select 0)) then {
		_x = (DZE_REPLACE_WEAPONS select 1) select ((DZE_REPLACE_WEAPONS select 0) find _x);
	};
	_isOK = isClass(configFile >> "CfgWeapons" >> _x);
	if (_isOK) then {
		_veh addWeaponCargoGlobal [_x,(_objWpnQty select _countr)];
	};
	_countr = _countr + 1;
} count _objWpnTypes; 

//Add Magazines
_objWpnTypes = _inventoryMagazines select 0;
_objWpnQty = _inventoryMagazines select 1;
_countr = 0;
{
	if (_x == "BoltSteel") then { _x = "WoodenArrow" }; // Convert BoltSteel to WoodenArrow
	if (_x == "ItemTent") then { _x = "ItemTentOld" };
	_isOK =	isClass(configFile >> "CfgMagazines" >> _x);
	if (_isOK) then {
		_veh addMagazineCargoGlobal [_x,(_objWpnQty select _countr)];
	};
	_countr = _countr + 1;
} count _objWpnTypes;

//Add Backpacks
_objWpnTypes = _inventoryBackpacks select 0;
_objWpnQty = _inventoryBackpacks select 1;
_countr = 0;
{
	_isOK = isClass(configFile >> "CfgVehicles" >> _x);
	if (_isOK) then {
		_veh addBackpackCargoGlobal [_x,(_objWpnQty select _countr)];
	};
	_countr = _countr + 1;
} count _objWpnTypes;

diag_log ("FERRY: Publishing vehicle " + str(_veh));

// Publish the vehicle
_worldspace = [_dir, _pos];
_uid = _worldspace call dayz_objectUID2;

//Send request
_key = [
	dayZ_instance,
	_class,
	_damage,
	_charID,
	((_worldspace select 1) select 0) call KK_fnc_floatToString,	// x
	((_worldspace select 1) select 1) call KK_fnc_floatToString,	// y
	((_worldspace select 1) select 2) call KK_fnc_floatToString,	// z
	(_worldspace select 0) call KK_fnc_floatToString,		// dir
	_inventoryMagazines,
	_inventoryWeapons,
	_inventoryBackpacks,
	_hitpoints,
	_fuel,
	_uid
];
_query = ["objectPublish", _key] call dayz_prepareDataForDB;
_result = _query call server_hiveReadWrite;

// Try to get object ID already here
if ((typeName _result) == "ARRAY") then {
	if (0 < count _result) then {
		_oid = str (_result select 0);
		_veh setVariable ["ObjectID", _oid, true];
		diag_log format["FERRY: Successfully published %1 with uid: %2 and object_id: %3", _class, _uid, _oid];
	};
} else {
	diag_log format["FERRY: Failed to publish vehicle %1 with uid: %2 and object_id: %3: %4", _class, _uid, _oid, _result];
};

PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_veh];

// Switched to spawn so we can wait a bit for the ID
[_veh,_uid,_fuel,_damage,_hitpoints,_charID,_class,_oid] spawn {
	private["_veh","_uid","_fuel","_damage","_array","_characterID","_done","_retry","_key","_result","_outcome","_oid","_selection","_dam","_class"];

	_veh = _this select 0;
	_uid = _this select 1;
	_fuel = _this select 2;
	_damage = _this select 3;
	_array = _this select 4;
	_characterID = _this select 5;
	_class = _this select 6;
	_oid = _this select 7;

	_done = false;
	_retry = 0;
	if (!isNil "_oid") then {

		_retry = 100;
		_done = true;
	};

	// TODO: Needs major overhaul
	while {_retry < 10} do {
		
		sleep 1;
		// GET DB ID
		_key = [_uid];
		_query = ["objectReturnID",_key] call dayz_prepareDataForDB;
		//diag_log ("HIVE: WRITE: "+ str(_query));
		_result = _query call server_hiveReadWrite;
		_outcome = (count _result > 0);
		if (_outcome) then {

			_oid = (_result select 0) select 0;
			_veh setVariable ["ObjectID", _oid, true];

			//diag_log("CUSTOM: Selected " + str(_oid));

			_done = true;
			_retry = 100;

		} else {
			diag_log("TIMEOUT: trying again to get id for vehicle: " + str(_uid));
			_done = false;
			_retry = _retry + 1;
		};
	};
	//if(!_done) exitWith { deleteVehicle _veh; diag_log("TIMEOUT: failed to get id for vehicle: " + str(_uid)); };

	_veh setVariable ["lastUpdate",time];
	_veh setVariable ["CharacterID", _characterID, true];
	_veh call fnc_veh_ResetEH;

	// testing - should make sure everyone has eventhandlers for vehicles was unused...
	PVDZE_veh_Init = _veh;
	publicVariable "PVDZE_veh_Init";
	diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid));
};

// Unload vehicle from ferry... TODO: MUST check on server (re)start if vehicle exists in intermediate table, if it does, then delete it!
_key = [_playerUID];
_query = ["unloadFromFerry", _key] call dayz_prepareDataForDB;
_query call server_hiveWrite;

// Wait for players belonging to the vehicle for 10 minutes; when they arrive move them into seats inside the vehicle.
[_veh, _driver, _commander, _turrets, _cargo] spawn {
	private ["_done","_veh","_driver","_commander","_turrets","_subturrets","_cargo","_timeout","_elapsed","_gotDriver","_gotCommander","_gotTurrets","_gotCargo","_plrCount","_plrIdx","_plr","_plrList","_count","_total","_oid","_tries"];

	_veh = _this select 0;
	_driver = _this select 1;
	_commander = _this select 2;
	_turrets = _this select 3;
	_cargo = _this select 4;

	// Set timeout to 10 minutes for waiting for all players to connect
	_timeout = diag_tickTime + 600;

	// Determine seats to occupy
	_done = false;
	_gotDriver = false;
	_gotCommander = false;
	_gotTurrets = false;
	_gotCargo = false;
	_count = 0;
	_total = 0;
	_oid = _veh getVariable ["ObjectID", 0];

	// Collect the remaining seats to be filled.
	if (_driver != "0") then {
		_total = _total + 1;
	};
	if (_commander != "0") then {
		_total = _total + 1;
	};
	for "_i" from 0 to (count _turrets)-1 do {
		if ("ARRAY" == typeName (_turrets select _i)) then {
			_subturrets = _turrets select _i;
			for "_j" from 0 to (count _subturrets)-1 do {
				_total = _total + 1;
			};
		} else {
			_total = _total + 1;
		};
	};
	for "_i" from 0 to (count _cargo)-1 do {
		_total = _total + 1;
	};


	// Wait until all players are inside vehicle or at most 10 minutes. Vehicle can be driven meanwhile.
	while {!_done && diag_tickTime < _timeout} do {

		_done = false;
		_plrList = +playableUnits;	// Get fresh list of players (playableUnits might increase or decrease, copy to avoid race conditions)
		_plrCount = count _plrList;
		_plrIdx = 0;

		// For each player check UID and see if the player is one of the passengers.
		// If the player is, then add this player to the vehicle.
		while {_plrIdx < _plrCount && !_done} do {

			_plr = _plrList select _plrIdx;

			// Skip players that are still at JIP and login/preloading process.
			if (_plr getVariable ["readyToBoard", false]) then {

				// Driver
				if (_driver != "0") then {

					diag_log "FERRY: Looking for driver...";
					
					if (_driver == getPlayerUID _plr) then {
						
						diag_log format ["FERRY: Found pilot/driver %1 crew member of vehicle %2", name _plr, typeOf _veh];

						_tries = 5;
						while { _tries > 0 && _plr == vehicle _plr} do {
							diag_log format ["FERRY: Sent boarding command to client %1 (%2) to board vehicle %3 as driver/pilot", owner _plr, name _plr, typeOf _veh];
							PV_travel_boardRcvdVeh = [1, _veh, 0, []];
							(owner _plr) publicVariableClient "PV_travel_boardRcvdVeh";
							sleep 1;
							_tries = _tries - 1;
						};

						_driver = "0";
						_count = _count + 1;
					};
				};

				// Commander
				if (_commander != "0") then {

					diag_log "FERRY: Looking for commander...";

					if (_commander == getPlayerUID _plr) then {

						diag_log format ["FERRY: Found commander %1 crew member of vehicle %2", name _plr, typeOf _veh];
						_tries = 5;
						while { _tries > 0 && _plr == vehicle _plr} do {
							diag_log format ["FERRY: Sent boarding command to client %1 (%2) to board vehicle %3 as commander", owner _plr, name _plr, typeOf _veh];
							PV_travel_boardRcvdVeh = [1, _veh, 1, []];
							(owner _plr) publicVariableClient "PV_travel_boardRcvdVeh";
							sleep 1;
							_tries = _tries - 1;
						};

						missionNamespace setVariable [format["transit_%1", _commander], false];
						_commander = "0";
						_count = _count + 1;
					};
				};

				// Gunners
				for "_i" from 0 to (count _turrets)-1 do {

					if ("ARRAY" == typeName (_turrets select _i)) then {

						_subturrets = _turrets select _i;
						for "_j" from 0 to (count _subturrets)-1 do {

							if ((_subturrets select _j) != "0") then {
								diag_log format["FERRY: Looking for gunner/turret [%1][%2]...", _i, _j];
								if ((_subturrets select _j) == getPlayerUID _plr) then {

									diag_log format ["FERRY: Found gunner[%1][%2] %3 crew member of vehicle %4", _i, _j, name _plr, typeOf _veh];

									_tries = 5;
									while { _tries > 0 && _plr == vehicle _plr} do {
										diag_log format ["FERRY: Sent boarding command to client %1 (%2) to board vehicle %3 as gunner[%4][%5]", owner _plr, name _plr, typeOf _veh, _i, _j];
										PV_travel_boardRcvdVeh = [1, _veh, 2, [_i, _j]];
										(owner _plr) publicVariableClient "PV_travel_boardRcvdVeh";
										sleep 1;
										_tries = _tries - 1;
									};

									missionNamespace setVariable [format["transit_%1", _subturrets select _j], false];
									_subturrets set [_j, "0"];
									_count = _count + 1;
								};
							};
						};
					} else {

						if ((_turrets select _i) != "0") then {

							diag_log format["FERRY: Looking for gunner/turret [%1]...", _i];

							if ((_turrets select _i) == getPlayerUID _plr) then {

								diag_log format ["FERRY: Found gunner[%1] %2 crew member of vehicle %3", _i, name _plr, typeOf _veh];

								_tries = 5;
								while { _tries > 0 && _plr == vehicle _plr} do {
									diag_log format ["FERRY: Sent boarding command to client %1 (%2) to board vehicle %3 as gunner[%4]", owner _plr, name _plr, typeOf _veh, _i];
									PV_travel_boardRcvdVeh = [1, _veh, 2, [_i]];
									(owner _plr) publicVariableClient "PV_travel_boardRcvdVeh";
									sleep 1;
									_tries = _tries - 1;
								};

								missionNamespace setVariable [format["transit_%1", _turrets select _i], false];
								_turrets set [_i, "0"];
								_count = _count + 1;
							};
						};
					};
				};

				// Cargo
				for "_i" from 0 to (count _cargo)-1 do {

					if ((_cargo select _i) != "0") then {

						diag_log format["FERRY: Looking for cargo [%1]...", _i];

						if ((_cargo select _i) == getPlayerUID _plr) then {

							diag_log format ["FERRY: Found cargo[%1] %2 crew member of vehicle %3", _i, name _plr, typeOf _veh];

							_tries = 5;
							while { _tries > 0 && _plr == vehicle _plr} do {
								diag_log format ["FERRY: Sent boarding command to client %1 (%2) to board vehicle %3 as cargo[%4]", owner _plr, name _plr, typeOf _veh, _i];
								PV_travel_boardRcvdVeh = [1, _veh, 3, [_i]];
								(owner _plr) publicVariableClient "PV_travel_boardRcvdVeh";
								sleep 1;
								_tries = _tries - 1;
							};

							missionNamespace setVariable [format["transit_%1", _cargo select _i], false];
							_cargo set [_i, "0"];
							_count = _count + 1;
						};
					};
				};
			};

			_done = _count == _total;
			_plrIdx = _plrIdx + 1;
		};

		sleep 0.1;
		if (_count < _total) then {
			diag_log format["FERRY: Looking for players to vehicle %2 from ferry [ID %1] : got %3 out of %4.", _oid, typeOf _veh, _count, _total];
		};
	};
};
