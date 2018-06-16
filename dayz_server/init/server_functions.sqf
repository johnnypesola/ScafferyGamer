#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

waitUntil {!isNil "bis_fnc_init"};

BIS_MPF_remoteExecutionServer = {
	if ((_this select 1) select 2 == "JIPrequest") then {
		[nil,(_this select 1) select 0,"loc",rJIPEXEC,[any,any,"per","execVM","ca\Modules\Functions\init.sqf"]] call RE;
	};
};

call compile preprocessFileLineNumbers "\z\addons\dayz_code\util\compile.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_code\loot\compile.sqf";

BIS_Effects_Burn = {};
dayz_disconnectPlayers = [];
dayz_serverKey = [];
for "_i" from 0 to 12 do {
	dayz_serverKey set [_i, ceil(random 128)];
};
dayz_serverKey = toString dayz_serverKey;

server_playerLogin = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_playerLogin.sqf";
server_playerSetup = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_playerSetup.sqf";
server_onPlayerDisconnect = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_onPlayerDisconnect.sqf";
server_updateObject = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_updateObject.sqf";
server_playerDied = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_playerDied.sqf";
server_publishObj = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_publishObject.sqf";	//Creates the object in DB
server_deleteObj = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_deleteObj.sqf"; 	//Removes the object from the DB
server_deleteObjDirect = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_deleteObjDirect.sqf";         //Removes the object from the DB, NO AUTH, ONLY CALL FROM SERVER, NO PV ACCESS
server_playerSync = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_playerSync.sqf";
zombie_findOwner = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\zombie_findOwner.sqf";
server_Wildgenerate = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\zombie_Wildgenerate.sqf";
base_fireMonitor = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\fire_monitor.sqf";
//server_systemCleanup = compile preprocessFileLineNumbers "\z\addons\dayz_server\system\server_cleanup.sqf";
spawnComposition = compile preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf"; //"\z\addons\dayz_code\compile\object_mapper.sqf";
server_sendToClient = compile preprocessFileLineNumbers "\z\addons\dayz_server\eventHandlers\server_sendToClient.sqf";
server_verifySender = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_verifySender.sqf";

// EPOCH ADDITIONS
server_swapObject = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_swapObject.sqf"; //Used to downgrade and upgrade Epoch buildables
server_publishVeh = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_publishVehicle.sqf"; //Used to spawn random vehicles by server
server_publishVeh2 = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_publishVehicle2.sqf"; //Used to purchase vehicles at traders
server_publishVeh3 = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_publishVehicle3.sqf"; //Used for car upgrades
server_tradeObj = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_tradeObject.sqf";
server_traders = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_traders.sqf";
server_spawnEvents = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_spawnEvent.sqf";
server_deaths = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_playerDeaths.sqf";
server_maintainArea = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_maintainArea.sqf";
server_checkIfTowed = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_checkIfTowed.sqf";
server_handleSafeGear = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_handleSafeGear.sqf";
spawn_ammosupply = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\spawn_ammosupply.sqf";
spawn_mineveins = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\spawn_mineveins.sqf";
spawn_roadblocks = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\spawn_roadblocks.sqf";
spawn_vehicles = compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\spawn_vehicles.sqf";

// --- Ferry ---
server_ferry_transportVehicle =		compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_ferry_transportVehicle.sqf";
server_ferry_getVehicleCrewAssignments =compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_ferry_getVehicleCrewAssignments.sqf";
server_ferry_receiveVehicle =		compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\server_ferry_receiveVehicle.sqf";


server_medicalSync = {
	_player = _this select 0;
	_array = _this select 1;
	
	_player setVariable ["USEC_isDead",(_array select 0)]; //0
	_player setVariable ["NORRN_unconscious",(_array select 1)]; //1
	_player setVariable ["USEC_infected",(_array select 2)]; //2
	_player setVariable ["USEC_injured",(_array select 3)]; //3
	_player setVariable ["USEC_inPain",(_array select 4)]; //4
	_player setVariable ["USEC_isCardiac",(_array select 5)]; //5
	_player setVariable ["USEC_lowBlood",(_array select 6)]; //6
	_player setVariable ["USEC_BloodQty",(_array select 7)]; //7
	// _wounds; //8
	// [_legs,_arms]; //9
	_player setVariable ["unconsciousTime",(_array select 10)]; //10
	_player setVariable ["blood_type",(_array select 11)]; //11
	_player setVariable ["rh_factor",(_array select 12)]; //12
	_player setVariable ["messing",(_array select 13)]; //13
	_player setVariable ["blood_testdone",(_array select 14)]; //14
};
/*
dayz_Achievements = {
	_achievementID = (_this select 0) select 0;
	_player = (_this select 0) select 1;
	_playerOwnerID = owner _player;
	
	_achievements = _player getVariable "Achievements";
	_achievements set [_achievementID,1];
	_player setVariable ["Achievements",_achievements];
};
*/

//Send fences to this array to be synced to db, should prove to be better performaince wise rather then updaing each time they take damage.
server_addtoFenceUpdateArray = {
	private ["_class","_clientKey","_damage","_exitReason","_index","_object","_playerUID"];
	_object = _this select 0;
	_damage = _this select 1;
	_playerUID = _this select 2;
	_clientKey = _this select 3;
	_index = dayz_serverPUIDArray find _playerUID;
	_class = typeOf _object;

	_exitReason = switch true do {
		//Can't use owner because player may already be dead, can't use distance because player may be far from fence
		case (_clientKey == dayz_serverKey): {""};
		case (_index < 0): {
			format["Server_AddToFenceUpdateArray error: PUID NOT FOUND ON SERVER. PV ARRAY: %1",_this]
		};
		case ((dayz_serverClientKeys select _index) select 1 != _clientKey): {
			format["Server_AddToFenceUpdateArray error: CLIENT AUTH KEY INCORRECT OR UNRECOGNIZED. PV ARRAY: %1",_this]
		};
		case !(_class isKindOf "DZ_buildables"): {
			format["Server_AddToFenceUpdateArray error: setDamage request on non DZ_buildable. PV ARRAY: %1",_this]
		};
		default {""};
	};

	if (_exitReason != "") exitWith {diag_log _exitReason};

	_object setDamage _damage;

	if !(_object in needUpdate_FenceObjects) then {
		needUpdate_FenceObjects set [count needUpdate_FenceObjects, _object];
		if (_playerUID != "SERVER") then {
			diag_log format["DAMAGE: PUID(%1) requested setDamage %2 on fence %3 ID:%4 UID:%5",_playerUID,_damage,_class,(_object getVariable["ObjectID","0"]),(_object getVariable["ObjectUID","0"])];
		};
	};
};


vehicle_handleServerKilled = {
	private ["_unit","_killer"];
	_unit = _this select 0;
	_killer = _this select 1;
		
	[_unit,"killed",false,false,"SERVER",dayz_serverKey] call server_updateObject;
	_unit removeAllMPEventHandlers "MPKilled";
	_unit removeAllEventHandlers "Killed";
	_unit removeAllEventHandlers "HandleDamage";
	_unit removeAllEventHandlers "GetIn";
	_unit removeAllEventHandlers "GetOut";
};

check_publishobject = {
	private ["_saveObject","_allowed","_allowedObjects","_object","_playername","_position","_forbiddenPos"];	// MilBases forbidden zones

	_object = _this select 0;
	_playername = _this select 1;
	_allowed = false;
	_position = getPosATL _object;

	#ifdef OBJECT_DEBUG
		diag_log format["DEBUG: Checking if Object: %1 is allowed, published by %2",_object,_playername];
	#endif

	if ((typeOf _object) in DayZ_SafeObjects) then {
		_saveObject = "DayZ_SafeObjects";
		_allowed = true;
	};
	
	//Buildings
	if (_object isKindOf "DZ_buildables") then {
		_saveObject = "DZ_buildables";
		_allowed = true;
	};
	
	if (worldName == "napf") then {
		// Two military bases, forbidden to build near them
		_forbiddenPos = 
		[ 
			// Northern military base
			[ [16712.932, 19018.701, 0.00045967102],1500.0], 
			// Southern military base
			[ [10499.969, 3214.8577, 0.4272919], 	1500.0 ]
		];

		// Don't allow building near military bases
		{
			if ((_position distance (_x select 0)) < (_x select 1)) then {
				_allowed = false;
			};
		} forEach _forbiddenPos;
	};

	#ifdef OBJECT_DEBUG
		diag_log format["DEBUG: Object: %1 published by %2 is allowed by %3",_object,_playername,_saveObject];
	#endif

	_allowed
};

server_hiveWrite = {
	private "_data";
	//diag_log ("ATTEMPT WRITE: " + _this);
	// extDB2
	//_data = "extDB2" callExtension format ["%1:%2:%3", 1, DZE_DbSessionID, _this];
	_data = "extDB2" callExtension (format ["%1:%2:", 1, DZE_DbSessionID] + _this);
	//diag_log ("WRITE: " +str(_data));
};

server_hiveReadWrite = {
	//private ["_key","_resultArray","_data"];	// extDB2
	private["_parameters","_query","_result","_resultBig","_pipe"];
	_parameters = _this;
	_query = format ["%1:%2:%3", 0, DZE_DbSessionID] + _parameters;
	//diag_log format["HIVE WRITE: '%1'", _query];
	_result = call compile ("extDB2" callExtension _query);
	switch (_result select 0) do
	{
		case 0:
		{
			diag_log format["Database Error: %1", (_result select 1)];
		};
		case 2:
		{
			_result = (_result select 1) call server_hiveReadWriteLarge;
		};
	};
	//diag_log format["HIVE READ: '%1'", str (_result select 1)];
	_result select 1
};

onPlayerDisconnected "[_uid,_name] call server_onPlayerDisconnect;";

server_getStatsDiff = {
	private ["_player","_playerUID","_new","_old","_result","_statsArray"];
	_player = _this select 0;
	_playerUID = _this select 1;
	_result = [];
	_statsArray = missionNamespace getVariable _playerUID;

	if (isNil "_statsArray") exitWith {
		diag_log format["Server_getStatsDiff error: playerUID %1 not found on server",_playerUID];
		[0,0,0,0,0]
	};

	{
		_new = _player getVariable [_x,0];
		_old = _statsArray select _forEachIndex;
		_result set [_forEachIndex, (_new - _old)];
		_statsArray set [_forEachIndex, _new]; //updates original var too
	} forEach ["humanity","zombieKills","headShots","humanKills","banditKills"];

	#ifdef PLAYER_DEBUG
	diag_log format["Server_getStatsDiff - Object:%1 Diffs:%2 New:%3",_player,_result,_statsArray];
	#endif

	_result
};


server_getDiff = {
	private ["_variable","_object","_vNew","_vOld","_result"];
	_variable = _this select 0;
	_object = _this select 1;
	_vNew = _object getVariable [_variable,0];
	_vOld = _object getVariable [(_variable + "_CHK"),_vNew];
	_result = 0;
	if (_vNew < _vOld) then {
		//JIP issues
		_vNew = _vNew + _vOld;
		_object getVariable [(_variable + "_CHK"),_vNew];
	} else {
		_result = _vNew - _vOld;
		_object setVariable [(_variable + "_CHK"),_vNew];
	};
	_result
};

server_getDiff2 = {
	private ["_variable","_object","_vNew","_vOld","_result"];
	_variable = _this select 0;
	_object = _this select 1;
	_vNew = _object getVariable [_variable,0];
	_vOld = _object getVariable [(_variable + "_CHK"),_vNew];
	_result = _vNew - _vOld;
	_object setVariable [(_variable + "_CHK"),_vNew];
	_result
};

//seems max is 19 digits
dayz_objectUID2 = {
    private["_position","_dir","_time" ,"_key"];
	_dir = _this select 0;
	_time = round diag_tickTime;
	if (_time > 99999) then {_time = round(random 99999);}; //prevent overflow if server isn't restarted
	_key = "";
	_position = _this select 1;
	_key = format["%1%2%3%4", round(_time + abs(_position select 0)), round(_dir), round(abs(_position select 1)), _time];
	_key;
};

dayz_recordLogin = {
	private ["_key","_query","_status","_name"];
	// extDB2
	//_key = format["CHILD:103:%1:%2:%3:",_this select 0,_this select 1,_this select 2];
	//_key call server_hiveWrite;
	_key = [_this select 0,_this select 1,_this select 2];
	_query = ["recordCharacterLogin", _key] call dayz_prepareDataForDB;
	_query call server_hiveWrite;
		
	_status = switch (1==1) do {
		case ((_this select 2) == 0): { "CLIENT LOADED & PLAYING" };
		case ((_this select 2) == 1): { "LOGIN PUBLISHING, Location " +(_this select 4) };
		case ((_this select 2) == 2): { "LOGGING IN" };
		case ((_this select 2) == 3): { "LOGGED OUT, Location " +(_this select 4) };
	};
	
	// Ferry:
	// This should be a good point where to confirm arrival to server.
	{
		if ((_this select 0) == getPlayerUID _x && (_this select 2) == 0) exitWith {_x setVariable ["readyToBoard", true, false];};
	} forEach playableUnits;

	_name = if (typeName (_this select 3) == "ARRAY") then { toString (_this select 3) } else { _this select 3 };
	diag_log format["INFO - Player: %1(UID:%3/CID:%4) Status: %2",_name,_status,(_this select 0),(_this select 1)];
};

generate_new_damage = {
	private "_damage";
    _damage = ((random(DynamicVehicleDamageHigh-DynamicVehicleDamageLow))+DynamicVehicleDamageLow) / 100;
	_damage
};

server_hiveReadWriteLarge = {
	private["_key","_result","_pipe"];	// extDB2 version
	_key = _this;
	_result = "";
	while{true} do
	{
		_pipe = "extDB2" callExtension format["5:%1", _key];
		if ([_pipe, ""] call BIS_fnc_areEqual) exitWith {};
		_result = _result + _pipe;
	};
	call (compile _result)
};

// coor2str: convert position to a GPS coordinates
fa_coor2str = {
	private["_pos","_res","_nearestCity","_town"];

	_pos = +(_this);
	if (count _pos < 1) then { _pos = [0,0]; }
	else { if (count _pos < 2) then { _pos = [_pos select 0,0]; };
	};
	_nearestCity = nearestLocations [_pos, ["NameCityCapital","NameCity","NameVillage","NameLocal"],1000];
	_town = "Wilderness";
	if (count _nearestCity > 0) then {_town = text (_nearestCity select 0)};
	_res = format["%1 [%2]", _town, mapGridPosition _pos];

	_res
};

// print player player PID and name. If name unknown then print UID.
fa_plr2str = {
	private["_x","_res","_name"];
	_x = _this;
	_res = "nobody";
	if (!isNil "_x") then {
		_name = _x getVariable ["bodyName", nil];
		if ((isNil "_name" OR {(_name == "")}) AND ({alive _x})) then { _name = name _x; };
		if (isNil "_name" OR {(_name == "")}) then { _name = "UID#"+(getPlayerUID _x); };
		_res = format["PID#%1(%2)", owner _x, _name ];
	};
	_res
};

array_reduceSize = {
	private ["_array1","_array","_count","_num"];
	_array1 = _this select 0;
	_array = _array1 - ["Hatchet_Swing","Crowbar_Swing","Machete_Swing","Bat_Swing","BatBarbed_Swing","BatNails_Swing","Fishing_Swing","Sledge_Swing","CSGAS"];
	_count = _this select 1;
	_num = count _array;
	if (_num > _count) then {
		_array resize _count;
	};
	_array
};

// Precise base building 1.0.5
call compile preprocessFileLineNumbers "\z\addons\dayz_server\compile\kk_functions.sqf";

// extDB2
server_hiveReadWriteSingle = {
	private["_parameters","_query","_result"];
	_parameters = _this;
	_query = format ["%1:%2:%3", 0, DZE_DbSessionID, _parameters];
	//diag_log format["HIVE WRITE: '%1'", _query];
	_result = call compile ("extDB2" callExtension _query);
	switch (_result select 0) do
	{
		case 0:
		{
			diag_log format["Database Error: %1", (_result select 1)];
		};
		case 2:
		{
			_result = (_result select 1) call server_hiveReadWriteLarge;
		};
	};
	//diag_log format["HIVE READ: '%1'", str ((_result select 1) select 0)];
	(_result select 1) select 0
};

// extDB2
server_hiveReadWriteSingleField = {
	private["_parameters","_query","_result"];
	_parameters = _this;
	_query = format ["%1:%2:%3", 0, DZE_DbSessionID, _parameters];
	//diag_log format["HIVE WRITE: '%1'", _query];
	_result = call compile ("extDB2" callExtension _query);
	switch (_result select 0) do
	{
		case 0:
		{
			diag_log format["Database Error: %1", (_result select 1)];
		};
		case 2:
		{
			_result = (_result select 1) call server_hiveReadWriteLarge;
		};
	};
	//diag_log format["HIVE READ: '%1'", str ((_result select 1) select 0)];
	((_result select 1) select 0) select 0
};

// extDB2 (called from server_playerLogin.sqf)
server_loadPlayer = {
	private["_key","_query","_playerID","_result","_playerName","_charID","_worldspace","_inventory","_backpack","_survival","_model","_hiveVer","_primary","_isInfected","_generation","_humanity","_newPlayer","_tries","_playerSex","_playerGroup","_CharacterCoins","_playerCoins","_BankCoins","_bloodType"];

	_playerID = _this select 0;
	_playerName = _this select 1;

	//Variables
	_inventory =	[];
	_backpack = 	[];
	_survival =	[0,0,0];
	_isInfected =   0;
	_model =	"";
	_primary = [];

	// Many steps! From hiveext.dll source
	// Also, any result returned from callExtension (and extDB2.dll) is instantiated from the extension,
	// if a runtime error happens while reading the result variable, then the server WILL crash so be 
	// patient. Seems like there's very poor error handling inside extDB2.

	_key = [_playerID];
	_query = ["playerExists", _key] call dayz_prepareDataForDB;
	_result = _query call server_hiveReadWrite;

	if (0 < count _result) then {

		_key = [_playerID,_playerName];
		_query = ["updatePlayerName", _key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;

		// Fetch bank money, player money, sex, and group
		_result = (_result select 0);

		_playerSex = _result select 1;
		_playerGroup = _result select 2;
		_playerCoins = _result select 3;
		_BankCoins = _result select 4;

	} else {

		_key = [_playerID,_playerName];
		_query = ["createPlayer", _key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;
		_playerSex = 0;
		_playerGroup = [];
		_playerCoins = 0;
		_BankCoins = 0;
	};

	_key = [_playerID];
	_query = ["getCharacter", _key] call dayz_prepareDataForDB;
	_result = _query call server_hiveReadWrite;

	// Get latest character
	if (count _result > 0 && {count (_result select 0) > 0}) then {

		_result = _result select 0;
		_charID = _result select 0;

		_key = [_charID];
		_query = ["updateCharacterLogin", _key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;

		_newPlayer = false;
		_worldspace = [_result select 4, [_result select 1, _result select 2, _result select 3]];
		_inventory = [_result select 6, _result select 5, _result select 7];
		_backpack = [_result select 8, _result select 10, _result select 9];
		_survival = [_result select 11, _result select 12, _result select 13, _result select 14];
		_CharacterCoins = _result select 15;
		_model = _result select 16;
		_hiveVer = 0.96;

		_primary = ["PASS", _newPlayer, _charID, _worldspace, _inventory, _backpack, _survival, _CharacterCoins, _model, _playerGroup, _playerCoins, _BankCoins, _hiveVer];
		diag_log format["Fetching character: %1", _primary];
	} else {
		_key = [_playerID];
		_query = ["getPrevCharacter", _key] call dayz_prepareDataForDB;
		_result = _query call server_hiveReadWrite;

		_generation = 1;
		_humanity = 2500;
		_worldspace = [0,[0,0,0]];
		_hiveVer = 0.96;

		if (count _result > 0 && {count (_result select 0) > 0}) then {

			_result = _result select 0;

			_generation = _result select 0;
			_humanity = _result select 1;
			_model = _result select 2;
			_isInfected = _result select 3;

			diag_log format["Found previous dead char, fetching: [generation:%1, humanity:%2, model:'%3', isInfected:%4]", _generation, _humanity, _model, _isInfected]; 
		};

		// Add a new character
		//_key = format["createCharacter:%1:%2:%3:%4:%5:%6:%7:%8",_playerID,_worldspace,_inventory,_backpack,_survival,_generation,_humanity];

		_bloodType = ["A","B","AB","O"] call BIS_fnc_selectRandom;
		_key = [
			_playerID, 
			0,	// x
			0,	// y
			0,	// z
			0,	// direction
			[],	// inventory mags
			[],	// inventory weaps
			"",	// backpack classname
			[],	// backpack mags
			[],	// backpack weaps
			0,	// is dead
			0,	// is unconscious
			0,	// is infected
			0,	// is injured
			0,	// is inpain
			0,	// is cardiac arrest
			0,	// is low blood
			12000,	// blood qty
			[],	// wounds
			0,	// hit legs
			0,	// hit arms
			0,	// unconscious time
			_bloodType,		// blood type
			floor(random(2)),	// RH factor
			[0,0,0],		// messing (hunger, thirst, ?)
			0,	// is blood test done
			_generation,
			_humanity
		];
		_query = ["createCharacter", _key] call dayz_prepareDataForDB;
		_query call server_hiveWrite;

		_key = [_playerID];
		_query = ["getCharacterID", _key] call dayz_prepareDataForDB;
		_tries = 0;
		while {isNil "_charID" && _tries < 20} do {

			_result = _query call server_hiveReadWrite;
			_charID = (_result select 0) select 0;
			_tries = _tries + 1;
		};
		if (_tries >= 20) then {
			_primary = ["ERROR"];
		} else {
			_newPlayer = true;
			_primary = ["PASS", _newPlayer, _charID, _isInfected, _model, _playerGroup, _playerCoins, _BankCoins, _hiveVer];
		};
	};
	_primary
};

// extDB2
dayz_prepareDataForDB = {
	private["_opName","_columns","_numItems","_i","_item","_message","_delim"];
	_opName = _this select 0;
	_columns = _this select 1;
	_delim = ":";
	if (count _this > 2) then {
		_delim = _this select 2;
	};

	// Preprocess
	_numItems = count _columns;

	if (_numItems > 0) then {
		_item = _columns select 0;
		if (typeName _item != "STRING") then {_item = str(_item)};
		_message = _item;
		_message = _opName + ":" + _message;
		for "_i" from 1 to _numItems - 1 do {
			_item = _columns select _i;
			if (typeName _item != "STRING") then {_item = str(_item)};
			_message = _message + _delim + _item;
		};
	} else {
		_message = _opName;
	};
	_message
}; 

// This function is needed for the dynamic query for security,
// the only unstripped character is the single quote, `'`.
strip_quotes = {
	private["_result","_arr","_j"];
	_arr = toArray(_this);
	_result = [];
	_j = 0;
	for "_i" from 0 to (count _arr) - 1 do {
		if ((_arr select _i) != 39) then {
			_result set [_j, _arr select _i];
			_j = _j + 1;
		};
	};
	toString(_result)
};


// -----------------------------------------------------------------------------------


// Multimap tools
// Lets get the map name for deciding what to add here...
DZE_Extras_WorldName = toLower format ["%1", worldName];
diag_log format["%1 detected. Map Specific Settings Adjusted!", DZE_Extras_WorldName];

//Napf Universal bases
if (DZE_Extras_WorldName == "napf") then {
	server_ferryTerminalPos = [18333.551, 2286.2048, 0];
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\calling_military_base.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\pastorn_military_base.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\military_mission_base.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\traders.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\boat_harbors.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\ferry_terminal_napf.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\trader_extras_napf.sqf";
};
if (DZE_Extras_WorldName == "chernarus") then {
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\elektro.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\epochbalota.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\epochcherno.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\neaf.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\nwaf.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\ferry_terminal_chernarus.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\milbase_chernarus.sqf";
	call compile preProcessFileLineNumbers "\z\addons\dayz_server\extrabuildings\trader_extras_chernarus.sqf";
};

#include "spawn_config.sqf"
#include "mission_check.sqf"
