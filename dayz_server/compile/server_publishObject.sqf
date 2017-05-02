#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

private ["_type","_objectUID","_characterID","_object","_worldspace","_key","_query","_ownerArray","_inventory","_name","_bedOwner","_vect","_ownerpuid","_magazines","_weapons","_backpacks"];	// SPAWN BED MOD, extDB2

_characterID =		_this select 0;
_object = 		_this select 1;
_worldspace = 	_this select 2;
_inventory = 		_this select 3;
if (typeName _inventory != "ARRAY") then {_inventory = [];}; //Temp fix for error in player_build.sqf in 1.0.6 release
_type = typeOf _object;

if ([_object, "Server"] call check_publishobject) then {
	//diag_log ("PUBLISH: Attempt " + str(_object));

	_objectUID = _worldspace call dayz_objectUID2;
	_object setVariable [ "ObjectUID", _objectUID, true ];
	// we can't use getVariable because only the object creation is known from the server (position,direction,variables are not sync'ed yet)
	//_characterID = _object getVariable [ "characterID", 0 ];
	//_ownerArray = _object getVariable [ "ownerArray", [] ];
	//_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:", dayZ_instance, _type, 0, _characterID, _worldspace, _inventory, [], 0,_objectUID ];

	// extDB2
	//_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance, _type, 0 , _characterID, _worldspace call AN_fnc_formatWorldspace, _inventory, [], 0,_objectUID]; // Precise Base Building 1.0.5

	// extDB2
	//_key call server_hiveWrite;

	// extDB2

	//Get owner and up vector
	_ownerpuid = if (3 == count _worldspace) then {_worldspace select 2} else {'0'};
	_vect = if (4 == count _worldspace) then {_worldspace select 3} else {[]};

	// extDB2, check if inventory used for identities
	if (count _inventory == 1) then {
		_magazines = _inventory;
		_weapons = [[],[]];
		_backpacks = [[],[]];
	} else {
		if (count _inventory == 3) then {
			_magazines = _inventory select 1;
			_weapons = _inventory select 0;
			_backpacks = _inventory select 2;
		} else {
			_magazines = [[],[]];
			_weapons = [[],[]];
			_backpacks = [[],[]];
		};
	};

	//Send request
	_key = [
		dayZ_instance,
		_type,
		0,	// damage
		_characterID,
		((_worldspace select 1) select 0) call KK_fnc_floatToString,	// x
		((_worldspace select 1) select 1) call KK_fnc_floatToString,	// y
		((_worldspace select 1) select 2) call KK_fnc_floatToString,	// z
		(_worldspace select 0) call KK_fnc_floatToString,		// dir
		_ownerpuid,
		_vect,
		_magazines,
		_weapons,
		_backpacks,
		[],	// hitpoints
		0,	// fuel
		_objectUID
	];
	_query = ["objectPublish", _key] call dayz_prepareDataForDB;

	// extDB2
	_query call server_hiveWrite;

	if !(_object isKindOf "TrapItems") then {
		if (DZE_GodModeBase && {!(_type in DZE_GodModeBaseExclude)}) then {
			_object addEventHandler ["HandleDamage", {false}];
		} else {
			_object addMPEventHandler ["MPKilled",{_this call vehicle_handleServerKilled;}];
		};
	};
	// Test disabling simulation server side on buildables only.
	_object enableSimulation false;

	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];

	#ifdef OBJECT_DEBUG
	diag_log ["PUBLISH: Created ",_type,"ObjectUID", _objectUID,"characterID", _characterID, " with variables/inventory:", _inventory ];
	#endif
}
else {
	#ifdef OBJECT_DEBUG
	diag_log ("PUBLISH: *NOT* created " + (_type ) + " (not allowed)");
	#endif
};
