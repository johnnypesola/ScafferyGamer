private ["_object","_worldspace","_location","_dir","_class","_uid","_dam","_hitpoints","_selection","_array","_damage","_fuel","_key","_query","_totaldam","_spawnDMG","_characterID","_result","_oid"];
//[_veh,[_dir,_location],"V3S_Civ",true]
_object = 		_this select 0;
_worldspace = 	_this select 1;
_class = 		_this select 2;
_spawnDMG =		_this select 3;
_characterID =  _this select 4;

_fuel = 1;
_damage = 0;
_array = [];

diag_log ("PUBLISH: Attempt " + str(_object));
_dir = 		_worldspace select 0;
_location = _worldspace select 1;

//Generate UID test using time
// _uid = str( round (dateToNumber date)) + str(round time);
_uid = _worldspace call dayz_objectUID2;
//_uid = format["%1%2",(round time),_uid];

if (_spawnDMG) then { 
	_fuel = 0;
	if (getNumber(configFile >> "CfgVehicles" >> _class >> "isBicycle") != 1) then {

		// Create randomly damaged parts
	
		_totaldam = 0;
		_hitpoints = _object call vehicle_getHitpoints;
		{
			// generate damage on all parts
			_dam = call generate_new_damage;

			_selection = getText(configFile >> "cfgVehicles" >> _class >> "HitPoints" >> _x >> "name");
			
			if (_dam > 0) then {
				_array set [count _array,[_selection,_dam]];
				_totaldam = _totaldam + _dam;
			};
		} count _hitpoints;	


		// just set low base dmg - may change later
		_damage = 0;
		_fuel = wai_mission_fuel;
	};
};

// TODO: check if uid already exists and if so increment by 1 and check again as soon as we find nothing continue.

//Send request
_key = [
	dayZ_instance,
	_class,
	_damage ,
	_characterID,
	((_worldspace select 1) select 0) call KK_fnc_floatToString,	// x
	((_worldspace select 1) select 1) call KK_fnc_floatToString,	// y
	((_worldspace select 1) select 2) call KK_fnc_floatToString,	// z
	(_worldspace select 0) call KK_fnc_floatToString,		// dir
	'0', // owner player uid
	[], // up vector
	[], // inv magazines
	[], // inv weapons
	[], // inv backpacks
	_array, // hitpoints
	_fuel,  // fuel
	_uid
];
_query = ["objectPublish", _key] call dayz_prepareDataForDB;
diag_log ("HIVE: WRITE: "+ str(_query)); 
_result = _query call server_hiveReadWrite;

// Try to get object ID already here
if (0 < count _result) then {
	_oid = str (_result select 0);
	_object setVariable ["ObjectID", _oid, true];
};

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];

// Switched to spawn so we can wait a bit for the ID
[_object,_uid,_fuel,_damage,_array,_characterID,_class,_oid] spawn {
	private["_object","_uid","_fuel","_damage","_array","_characterID","_done","_retry","_key","_result","_outcome","_oid","_selection","_dam","_class"];

	_object = _this select 0;
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
		diag_log ("HIVE: WRITE: "+ str(_query));
		_result = _query call server_hiveReadWrite;
		_outcome = (count _result > 0);
		if (_outcome) then {
			_oid = (_result select 0) select 0;
			_object setVariable ["ObjectID", _oid, true];
			diag_log("CUSTOM: Selected " + str(_oid));
			_done = true;
			_retry = 100;

		} else {
			diag_log("CUSTOM: trying again to get id for: " + str(_uid));
			_done = false;
			_retry = _retry + 1;
		};
	};
	if(!_done) exitWith { deleteVehicle _object; diag_log("CUSTOM: failed to get id for : " + str(_uid)); };

	_object setVariable ["lastUpdate",time];
	_object setVariable ["CharacterID", _characterID, true];
	_object setDamage _damage;

	// Set Hits after ObjectID is set
	{
		_selection = _x select 0;
		_dam = _x select 1;
		if (_selection in dayZ_explosiveParts && _dam > 0.8) then {_dam = 0.8};
		[_object,_selection,_dam] call fnc_veh_setFixServer;
	} count _array;
	
	_object setFuel _fuel;
	
	_object setvelocity [0,0,1];

	_object call fnc_veh_ResetEH;

	// testing - should make sure everyone has eventhandlers for vehicles was unused...
	PVDZE_veh_Init = _object;
	publicVariable "PVDZE_veh_Init";

	diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid));
};
