private ["_activatingPlayer","_isOK","_object","_worldspace","_location","_dir","_class","_uid","_key","_query","_keySelected","_characterID","_donotusekey","_result","_playerUID","_instanceName","_crew","_driver","_commander","_turrets","_cargo","_clientID","_playerName","_array","_selection","_hit","_id","_isplayernearby","_magazines","_plrPos","_localCharID","_crewMemberName"];
//PVDZE_veh_Transport = [_veh,[_dir,_location],_part_out,false,_keySelected,_activatingPlayer];
_object = 		_this select 0;
_class = 		_this select 1;
_worldspace =		_this select 2;
_donotusekey =		_this select 3;
_keySelected =  	_this select 4;
_activatingPlayer =	_this select 5;
_destinationInstance =	_this select 6;

// if player is NULL
if (isNull _activatingPlayer) exitWith { 
	diag_log format["FERRY: ERROR: Player object NULL attempted transport of vehicle %1. Exiting...", _class];
};

_playerUID = getPlayerUID _activatingPlayer;
_playerName = name _activatingPlayer;

// if object/vehicle is NULL
if (isNull _object) exitWith { 
	diag_log format["FERRY: ERROR: Player %1 [%2] attempted transport of vehicle %3 but with object NULL. Exiting...", _playerName, _playerUID, _class];
};

// If player is not inside vehicle
if ((vehicle _activatingPlayer) != _object) then {
	diag_log format["FERRY: ERROR: Player %1 [] is not NULL attempted transport of vehicle %1. Exiting...", _class];
};

// Get instance name
if (_destinationInstance == 11) then { _instanceName = "Chernarus"; };
if (_destinationInstance == 24) then { _instanceName = "Napf"; };
if (_destinationInstance == 15) then { _instanceName = "Namalsk"; };
if (!(_destinationInstance in [11, 15, 24])) exitWith {
	diag_log format["Transport to instance %1 is not available!", _destinationInstance];
};

// Check player and check key
if(_donotusekey) then {
	_isOK = true;
} else {
	_isOK = isClass(configFile >> "CfgWeapons" >> _keySelected);
};

if(!_isOK) exitWith { diag_log ("FERRY: CARKEY DOES NOT EXIST: "+ str(_keySelected));  };

// Get key ID (character id in database)
if(_donotusekey) then {
	_characterID = _keySelected;
} else {
	_characterID = str(getNumber(configFile >> "CfgWeapons" >> _keySelected >> "keyid"));
};

diag_log format ["FERRY: Player %1 [%2], attempts to transport a vehicle of type %3", _playerName, _playerUID, _class];

// Check position
_dir = 		_worldspace select 0;
_location =	_worldspace select 1;
if ((_location distance server_ferryTerminalPos) > 211) exitWith {
	diag_log format["FERRY: Player %1 [%2]: Vehicle %3 is too far (%4m > 211m) to terminal!",
		_playerName, _playerUID, _class, _location distance server_ferryTerminalPos];
};

// Check if already in transit
_key = [_playerUID];
_query = ["inTransit", _key] call dayz_prepareDataForDB;
_result = _query call server_hiveReadWriteSingle;

if ((count _result) > 0) exitWith {

	PV_travel_boardFerry = [true, false, _destinationInstance];
	_clientID = owner _activatingPlayer;
	_clientID publicVariableClient "PV_travel_boardFerry";
	diag_log format ["FERRY: Player %1 already has a vehicle in transit.", _playerUID];
};

// Collect crew info
_crew = [_object] call server_ferry_getVehicleCrewAssignments;
_driver = _crew select 0;
_commander = _crew select 1;
_turrets = _crew select 2;
_cargo = _crew select 3;

// Get all hitpoints
_hitpoints = _object call vehicle_getHitpoints;
_array = [];
{
	_hit = [_object,_x] call object_getHit;
	_selection = getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "HitPoints" >> _x >> "name");
	if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
	_object setHit ["_selection", _hit];
} count _hitpoints;

//Send request
_key = [
	_playerUID,
	_destinationInstance,
	_class,
	_driver,
	_commander,
	_turrets,
	_cargo,
	_characterID,
	getMagazineCargo _object, // inv magazines
	getWeaponCargo _object, // inv weapons
	getBackpackCargo _object, // inv backpacks
	_array, // hitpoints
	fuel _object,  // fuel
	damage _object	// damage
];

_query = ["loadOntoFerry", _key] call dayz_prepareDataForDB;
//diag_log ("HIVE: WRITE: "+ str(_query)); 
_result = _query call server_hiveReadWrite;

if ((count _result) == 0) exitWith {
	diag_log format ["FERRY: Player %1: failed to send vehicle %2 with ferry! Reason: Database failure", _playerUID, _class];
};

diag_log format ["FERRY: Vehicle %1 loaded onto ferry. Player %2 [%3] and crew must log on to instance %4 to receive the vehicle.", _class, _playerName, _playerUID, _destinationInstance];

// Delete the vehicle from the database
[
	_object getVariable ["ObjectID", "0"],
	_object getVariable ["ObjectUID", "0"],
	_playerUID
] call server_deleteObj;


// From this point and onwards, keep passengers inside ;-)
_object setVehicleLock "locked";

// Get fresh object of player
{
	if ((getPlayerUID _x) == _playerUID) exitWith {_activatingPlayer = _x;};
} count playableUnits;

// Save player data
// Save and disconnect crew players.
// On client side, end mission for the involved members.
{
	if (alive _x && isPlayer _x) then {

		if (_activatingPlayer == _x) then {
			PV_travel_boardFerry = [true, true, _instanceName];
		} else {
			PV_travel_boardFerry = [false, true, _instanceName];
		};

		// Set position to ground level if needed
		_plrPos = getPosATL _x;
		if ((_plrPos select 2) > 0.1) then {
			_x setPosATL [_plrPos select 0, _plrPos select 1, 0.01];
		};

		// Save players
		_playerUID = getPlayerUID _x;
		_crewMemberName = name _x;

		/*
		_localCharID = _x getVariable ["CharacterID","0"];

		_x setVariable ["write_lock", true, false];
		[_playerUID, _localCharID, 2] spawn dayz_recordLogin;

		// prevent saving more than 20 magazine items
		_magazines = [(magazines _x),20] call array_reduceSize;

		[_x,_magazines,true,true,false] call server_playerSync;
		*/

		_clientID = owner _x;
		if (_clientID != 0) then {

			_clientID publicVariableClient "PV_travel_boardFerry";
			diag_log format["FERRY: Crew member %1 (client ID: %2) was transported along with %3 in vehicle %4 to %5.", _clientID, _crewMemberName, _playerName, _class, _instanceName];

			/*
			_x spawn {
				// Wait until player is saved (fixes race condition between server_playerSync and dayz_removePlayerOnDisconnect.)
				waitUntil { !(_this getVariable["write_lock", false]) };

				// remove player.
				_this call dayz_removePlayerOnDisconnect;
			};
			*/

		} else {
			diag_log format["FERRY: ERROR: Couldn't fetch client ID: [result = %1] Crew member %2 needs to log out manually to %3.", _clientID, _crewMemberName, _instanceName];
		};

	};
} forEach (crew _object);


[_object] spawn {
	private["_object"];
	_object = _this select 0;

	sleep 2;

	// Remove vehicle
	deleteVehicle _object;
};

diag_log format["FERRY: COMPLETE: %1 has transported a %2 to %3.", _playerName, _class, _instanceName];
