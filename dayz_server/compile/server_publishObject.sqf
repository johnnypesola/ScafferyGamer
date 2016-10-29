private ["_class","_uid","_charID","_object","_worldspace","_key","_query","_allowed","_count","_time","_name"];
//[dayz_characterID,_tent,[_dir,_location],"TentStorage"]
_charID =		_this select 0;
_object = 		_this select 1;
_worldspace = 	_this select 2;
_class = 		_this select 3;
if (count _this > 4) then {
	_name = _this select 4;
} else {
	_name = "unknown";
};

switch (_class) do {

	case "Explosive": {

		[_worldspace] spawn {
			sleep 10;
			_trig = createTrigger ["EmptyDetector", ((_this select 0) select 1)];
			_trig setTriggerArea [2, 2, 0, false];
			_trig setTriggerActivation ["ANY", "PRESENT", false];
			_trig setTriggerTimeout [0, 0, 0, true]; 
			_trig setTriggerStatements ["this", "[(nearestObject [thisTrigger, ""Explosive""]), ""Small""] exec ""custom\proximitybomb\ied.sqs""" , ""];
		};
		//get UID
		_uid = _worldspace call dayz_objectUID2;

		_object setVariable ["lastUpdate",time];
		_object setVariable ["ObjectUID", _uid,true];

		_object addMPEventHandler ["MPKilled",{_this call object_handleServerKilled;}];

		// Test disabling simulation server side on buildables only.
		_object enableSimulation false;

		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];
	};
	case "MAP_F_postel_manz_kov": {

		// PASTORN: SPAWN BED MOD

		//diag_log ("PUBLISH: Attempt " + str(_object));
		_playerUID = _name;
		_bedOwner = "'[[[_playerUID],[1]]]'";

		//get UID
		_uid = _worldspace call dayz_objectUID2;

		//Send request
		_key = [dayZ_instance, _class, 0 , _charID, format["'%1'", [_worldspace select 0, _worldspace select 1] call AN_fnc_formatWorldspace], _bedOwner, "'[]'", 0, _uid];
		_query = ["objectPublish", _key] call dayz_prepareDataForDB;
		//diag_log ("HIVE: WRITE: "+ str(_query));
		_query call server_hiveWrite;

		_object setVariable ["lastUpdate",time];
		_object setVariable ["ObjectUID", _uid,true];
		_object setVariable ["playerSpawn", _playerUID, true];
		// _object setVariable ["CharacterID",_charID,true];

		if (DZE_GodModeBase) then {
			_object addEventHandler ["HandleDamage", {false}];
		}else{
			_object addMPEventHandler ["MPKilled",{_this call object_handleServerKilled;}];
		};
		// Test disabling simulation server side on buildables only.
		_object enableSimulation false;

		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];

		//diag_log ("PUBLISH: Created " + (_class) + " with ID " + _uid);

	};

	default {
		_allowed = [_object, _name] call check_publishobject;
		if (!_allowed) exitWith { deleteVehicle _object; };

		//diag_log ("PUBLISH: Attempt " + str(_object));

		//get UID
		_uid = _worldspace call dayz_objectUID2;

		//Send request
		_key = [dayZ_instance, _class, 0 , _charID, format ["'%1'", [_worldspace select 0, _worldspace select 1] call AN_fnc_formatWorldspace], "'[]'", "'[]'", 0, _uid];
		_query = ["objectPublish", _key] call dayz_prepareDataForDB;
		//diag_log ("HIVE: WRITE: "+ str(_query));
		_query call server_hiveWrite;

		_object setVariable ["lastUpdate",time];
		_object setVariable ["ObjectUID", _uid,true];
		// _object setVariable ["CharacterID",_charID,true];

		if (DZE_GodModeBase) then {
			_object addEventHandler ["HandleDamage", {false}];
		}else{
			_object addMPEventHandler ["MPKilled",{_this call object_handleServerKilled;}];
		};
		// Test disabling simulation server side on buildables only.
		_object enableSimulation false;

		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];

		//diag_log ("PUBLISH: Created " + (_class) + " with ID " + _uid);
	};
};
