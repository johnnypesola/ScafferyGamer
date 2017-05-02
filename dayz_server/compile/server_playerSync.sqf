private ["_distanceFoot","_playerPos","_lastPos","_playerGear","_medical","_currentModel","_currentAnim",
"_currentWpn","_muzzles","_array","_coins","_key","_globalCoins","_bankCoins","_playerBackp","_exitReason",
"_backpack","_kills","_killsB","_killsH","_headShots","_humanity","_lastTime","_timeGross","_timeSince",
"_timeLeft","_config","_onLadder","_isTerminal","_modelChk","_temp","_currentState","_character",
"_magazines","_characterID","_charPos","_isInVehicle","_name","_inDebug","_newPos","_count","_maxDist","_relocate","_playerUID","_empty","_query"];	// extDB2
//[player,array]

_character = _this select 0;
_magazines = _this select 1;
_characterID = _character getVariable ["characterID","0"];
_playerUID = getPlayerUID _character;
_charPos = getPosATL _character;
_isInVehicle = vehicle _character != _character;
_timeSince = 0;
_humanity = 0;
_friendlies = [];		// extDB2
_updatePos = false;		// extDB2
_updateInv = false;		// extDB2
_updateBackpack = false;	// extDB2
_updateMed = false;		// extDB2
_name = if (alive _character) then {name _character} else {"Dead Player"};
_inDebug = (respawn_west_original distance _charPos) < 1500;

_exitReason = switch true do {
	case (isNil "_characterID"): {("ERROR: Cannot Sync Character " + _name + " has nil characterID")}; //Unit is null
	case (_inDebug): {format["INFO: Cannot Sync Character %1 near respawn_west %2. This is normal when relogging or changing clothes.",_name,_charPos]};
	case (_characterID == "0"): {("ERROR: Cannot Sync Character " + _name + " has no characterID")};
	case (_character isKindOf "Animal"): {("ERROR: Cannot Sync Character " + _name + " is an Animal class")};
	default {"none"};
};

if (_exitReason != "none") exitWith {
	diag_log _exitReason;
};

//Check for player initiated updates
_playerPos =	[];
//_playerGear =	[];		// extDB2
_playerGear =	[[],[]];
//_playerBackp =	[];	// extDB2
_playerBackp =	["", [[],[]], [[],[]]];
_medical =		[];
_distanceFoot =	0;
_ws = "cherno";			// extDB2
_friendlies = [];		// extDB2
	
//all getVariable immediately
_globalCoins = _character getVariable ["GlobalMoney", -1];
_bankCoins = _character getVariable ["MoneySpecial", -1];
_coins = _character getVariable [Z_MoneyVariable, -1]; //should getting coins fail set the variable to an invalid value to prevent overwritting the in the DB
_lastPos = _character getVariable ["lastPos",_charPos];
_direction = round (direction _character);	// extDB2
_usec_Dead = _character getVariable ["USEC_isDead",false];
_lastTime = 	_character getVariable ["lastTime",diag_ticktime];
_modelChk = 	_character getVariable ["model_CHK",""];
_temp = round (_character getVariable ["temperature",100]);
_lastMagazines = _character getVariable ["ServerMagArray",[[],""]];
/*
	Check previous stats against what client had when they logged in
	this helps prevent JIP issues, where a new player wouldn't have received
	the old players updates. Only valid for stats where clients could have
	be recording results from their local objects (such as agent zombies)
*/
_kills = 		["zombieKills",_character] call server_getDiff;
_killsB = 		["banditKills",_character] call server_getDiff;
_killsH = 		["humanKills",_character] call server_getDiff;
_headShots = 	["headShots",_character] call server_getDiff;
_humanity = 	["humanity",_character] call server_getDiff2;

_charPosLen = count _charPos;

if (!isNil "_magazines") then {
	if (typeName _magazines == "ARRAY") then {
		_playerGear = [weapons _character,_magazines select 0,_magazines select 1];
		_character setVariable["ServerMagArray",_magazines, false];
	};
	_updateInv = true;	// extDB2
} else {
	//check Magazines everytime they aren't sent by player_forceSave
	_magTemp = (_lastMagazines select 0);
	if (count _magTemp > 0) then {
		_magazines = [(magazines _character),20] call array_reduceSize;
		{
			_class = _x;
			if (typeName _x == "ARRAY") then {
				_class = _x select 0;
			};
			if (_class in _magazines) then {
				_MatchedCount = {_compare = if (typeName _x == "ARRAY") then {_x select 0;} else {_x}; _compare == _class} count _magTemp;
				_CountedActual = {_x == _class} count _magazines;
				if (_MatchedCount > _CountedActual) then {
					_magTemp set [_forEachIndex, "0"];
					_updateInv = true;	// extDB2
				};
			} else {
				_magTemp set [_forEachIndex, "0"];
				_updateInv = true;	// extDB2
			};
		} forEach (_lastMagazines select 0);
		_magazines = _magTemp - ["0"];
		_magazines = [_magazines, (_lastMagazines select 1)];
		_character setVariable["ServerMagArray",_magazines, false];
		_playerGear = [weapons _character,_magazines select 0,_magazines select 1];
	};
};

//Check if update is requested
if !((_charPos select 0 == 0) && (_charPos select 1 == 0)) then {
	//Position is not zero
	//diag_log ("getting position..."); sleep 0.05;
	_playerPos = [round (direction _character),_charPos];
	if (count _lastPos > 2 && {_charPosLen > 2}) then {
		if (!_isInVehicle) then {_distanceFoot = round (_charPos distance _lastPos);};
		_character setVariable["lastPos",_charPos];
	};
	if (_charPosLen < 3) then {_playerPos = [];} else {	// extDB2
		switch (DZE_Extras_WorldName) do {
			case "chernarus": { _ws = "cherno" };
			case "napf": { _ws = "napf" };
			default { _ws = "cherno" };
		};
		_updatePos = true;
	};
	//diag_log ("position = " + str(_playerPos)); sleep 0.05;
};
_character setVariable ["posForceUpdate",false,true];

//Check player backpack each time sync runs
_backpack = unitBackpack _character;
_playerBackp = [typeOf _backpack,getWeaponCargo _backpack,getMagazineCargo _backpack];
_updateBackpack = true;		// extDB2

if (!_usec_Dead) then {
	//diag_log ("medical check..."); sleep 0.05;
	_medical = _character call player_sumMedical;
	//diag_log ("medical result..." + str(_medical)); sleep 0.05;
	_updateMed = true;	// extDB2
};
_character setVariable ["medForceUpdate",false,true];

_character addScore _kills;		
_timeGross = 	(diag_ticktime - _lastTime);
_timeSince = 	floor (_timeGross / 60);
_timeLeft =		(_timeGross - (_timeSince * 60));
/*
	Get character state details
*/
_currentWpn = 	currentMuzzle _character;
_currentAnim =	animationState _character;
_config = 		configFile >> "CfgMovesMaleSdr" >> "States" >> _currentAnim;
_onLadder =		(getNumber (_config >> "onLadder")) == 1;
_isTerminal = 	(getNumber (_config >> "terminal")) == 1;
//_wpnDisabled =	(getNumber (_config >> "disableWeapons")) == 1;
_currentModel = typeOf _character;
if (_currentModel == _modelChk) then {
	_currentModel = "";
} else {
	_currentModel = str _currentModel;
	_character setVariable ["model_CHK",typeOf _character];
};
if (count _this > 4) then { //calling from player_onDisconnect
	if (_this select 4) then { //combat logged
		_medical set [1, true]; //set unconcious to true
		_medical set [10, 150]; //combat timeout
		//_character setVariable ["NORRN_unconscious",true,true]; // Set status to unconscious
		//_character setVariable ["unconsciousTime",150,true]; // Set knock out timer to 2 minutes 30 seconds
		//_character setVariable ["USEC_injured",true]; // Set status to bleeding
		//_character setVariable ["USEC_BloodQty",3000]; // Set blood to 3000
		_updateMed = true;	// extDB2
	};	
	if (_isInVehicle) then {
		//if the player object is inside a vehicle lets eject the player
		_relocate = ((vehicle _character isKindOf "Air") && (_charPos select 2 > 1.5));
		_character action ["eject", vehicle _character];
		
		// Prevent relog in parachute, heli or plane above base exploit to get inside
		if (_relocate) then {
			_count = 0;
			_maxDist = 800;
			_newPos = [_charPos, 80, _maxDist, 10, 1, 0, 0, [], [_charPos,_charPos]] call BIS_fnc_findSafePos;
			
			while {_newPos distance _charPos == 0} do {
				_count = _count + 1;
				if (_count > 4) exitWith {_newPos = _charPos;}; // Max 4km away fail safe (needs to finish fast so server_playerSync runs below)
				_newPos = [_charPos, 80, (_maxDist + 800), 10, 1, 0, 0, [], [_charPos,_charPos]] call BIS_fnc_findSafePos;
			};
			_newPos set [2,0]; //findSafePos only returns two elements
			_charPos = _newPos;
			diag_log format["%1(%2) logged out in air vehicle. Relocated to safePos.",_name,_playerUID];
			_updatePos = true;	// extDB2
		};
	};
};
if (_onLadder or _isInVehicle or _isTerminal) then {
	_currentAnim = "";
	//If position to be updated, make sure it is at ground level!
	if ((count _playerPos > 0) && !_isTerminal) then {
		_charPos set [2,0];
		_playerPos set [1,_charPos];					
	};
	_updatePos = true;	// extDB2
};
if (_isInVehicle) then {
	_currentWpn = "";
} else {
	if (typeName _currentWpn == "STRING") then {
		_muzzles = getArray (configFile >> "cfgWeapons" >> _currentWpn >> "muzzles");
		if (count _muzzles > 1) then {_currentWpn = currentMuzzle _character;};	
	} else {
		//diag_log ("DW_DEBUG: _currentWpn: " + str(_currentWpn));
		_currentWpn = "";
	};
};
// extDB2
//_currentState = [[_currentWpn,_currentAnim,_temp],[]];

// extDB2 supports friendlies saving
if(DZE_FriendlySaving) then {
	// save only last/most recent 5 entrys as we only have 200 chars in db field && weapon + animation names are sometimes really long 60-70 chars.
	_friendlies = [(_character getVariable ["friendlies",[]]),5] call array_reduceSizeReverse;
};

// If player is in a vehicle, keep its position updated
if (vehicle _character != _character) then {
	[vehicle _character, "position"] call server_updateObject;
};

//Reset timer
if (_timeSince > 0) then {
	_character setVariable ["lastTime",(diag_ticktime - _timeLeft)];
};

/*
	Everything is ready, now publish to HIVE
	Low priority code below this point where _character object is no longer needed and may be Null.
*/
if (count _playerPos > 0) then {
	_array = [];
	{
		if (_x > dayz_minpos && _x < dayz_maxpos) then {_array set [count _array,_x];};
	} forEach (_playerPos select 1);
	_playerPos set [1,_array];
};

// extDB2
//Wait for HIVE to be free and send request
//_key = if (Z_SingleCurrency) then {
//	format["CHILD:201:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:",_characterID,_playerPos,_playerGear,_playerBackp,_medical,false,false,_kills,_headShots,_distanceFoot,_timeSince,_currentState,_killsH,_killsB,_currentModel,_humanity,_coins]
//} else {
//	format["CHILD:201:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:",_characterID,_playerPos,_playerGear,_playerBackp,_medical,false,false,_kills,_headShots,_distanceFoot,_timeSince,_currentState,_killsH,_killsB,_currentModel,_humanity]
//};

// extDB2
// Collect data for update
[
	_characterID,
	_playerGear,
	_updatePos,
	_ws,
	_charPos,
	_updateInv,
	_direction,
	_updateBackpack,
	_playerBackp,
	_updateMed,
	_medical,
	_kills,
	_headShots,
	_distanceFoot,
	_timeSince,
	_currentWpn,
	_currentAnim,
	_temp,
	_friendlies,
	_killsH,
	_killsB,
	_currentModel,
	_humanity,
	_coins
] spawn {
	private["_query", "_key","_characterID","_playerGear","_updatePos","_ws","_charPos",
		"_updateInv","_direction","_updateBackpack","_playerBackp","_updateMed","_medical","_isDead",
		"_isUncon","_isInfect","_isInjured","_isInPain","_isCardiac","_isLowBlood","_isBloodTestDone",
		"_kills","_headShots","_distanceFoot","_timeSince","_currentWpn","_currentAnim",
		"_temp","_friendlies","_killsH","_killsB","_currentModel","_humanity","_empty","_prof","_coins"];

	//_prof = diag_tickTime;
	_key = [];
	_characterID = _this select 0;
	_playerGear = _this select 1;
	_updatePos = _this select 2;
	_ws = _this select 3;
	_charPos = _this select 4;
	_updateInv = _this select 5;
	_direction = _this select 6;
	_updateBackpack = _this select 7;
	_playerBackp = _this select 8;
	_updateMed = _this select 9;
	_medical = _this select 10;
	_kills = _this select 11;
	_headShots = _this select 12;
	_distanceFoot = _this select 13;
	_timeSince = _this select 14;
	_currentWpn = _this select 15;
	_currentAnim = _this select 16;
	_temp = _this select 17;
	_friendlies = _this select 18;
	_killsH = _this select 19;
	_killsB = _this select 20;
	_currentModel = _this select 21;
	_humanity = _this select 22;
	_coins = _this select 23;

	_key = _key + [format["instance_id = %1", dayZ_instance]];

	if (_updatePos) then {
		_key = _key + [
			format["ws_%1_x = %2", _ws, _charPos select 0],
			format["ws_%1_y = %2", _ws, _charPos select 1],
			format["ws_%1_z = %2", _ws, _charPos select 2],
			format["ws_%1_dir = %2", _ws, _direction]
		];
	};
	if (_updateInv) then {
		_key = _key + [
			format["inventory_magazines = '%1'", (str (_playerGear select 1)) call strip_quotes],
			format["inventory_weapons = '%1'", (str (_playerGear select 0)) call strip_quotes],
			format["backpack = '%1'", (_playerBackp select 0) call strip_quotes]
		];
		if (count _playerGear > 2) then {
			_key = _key + [format["inventory_onback = '%1'", (str (_playerGear select 2)) call strip_quotes]];
		};
		if (_updateBackpack) then {
			_key = _key + [
				format["backpack_magazines = '%1'", (str (_playerBackp select 2)) call strip_quotes],
				format["backpack_weapons = '%1'", (str (_playerBackp select 1)) call strip_quotes]
			];
		} else {
			_empty = [[],[]];
			_key = _key + [
				format["backpack_magazines = '%1'", (str _empty) call strip_quotes],
				format["backpack_weapons = '%1'", (str _empty) call strip_quotes]
			];
		};
	};
	if (_updateMed) then {
		_isDead = if (_medical select 0) then {1} else {0};
		_isUncon = if (_medical select 1) then {1} else {0};
		_isInfect = if (_medical select 2) then {1} else {0};
		_isInjured = if (_medical select 3) then {1} else {0};
		_isInPain = if (_medical select 4) then {1} else {0};
		_isCardiac = if (_medical select 5) then {1} else {0};
		_isLowBlood = if (_medical select 6) then {1} else {0};
		_isRhFactorPos = if (_medical select 12) then {1} else {0};
		_isBloodTestDone = if (_medical select 14) then {1} else {0};
		_key = _key + [
			format["med_dead = %1", _isDead],
			format["med_unconscious = %1", _isUncon],
			format["med_infected = %1", _isInfect],
			format["med_injured = %1", _isInjured],
			format["med_inpain = %1", _isInPain],
			format["med_cardiac = %1", _isCardiac],
			format["med_lowblood = %1", _isLowBlood],
			format["med_bloodqty = %1", _medical select 7],
			format["med_wounds = '%1'", (str (_medical select 8)) call strip_quotes],
			format["med_hit_legs = %1", (_medical select 9) select 0],
			format["med_hit_arms = %1", (_medical select 9) select 1],
			format["med_unconscious_time = %1", _medical select 10],
			format["med_blood_type = '%1'", (_medical select 11) call strip_quotes],	// new in 1.0.6
			format["med_rh_factor = '%1'", _isRhFactorPos],	// new in 1.0.6
			format["med_messing = '%1'", (str (_medical select 13)) call strip_quotes],
			format["med_blood_testdone = %1", _isBloodTestDone]	// new in 1.0.6
		];
	};
	if (_kills > 0) then {
		_key = _key + [format["kills_z = kills_z + %1", _kills]];
	};
	if (_headShots > 0) then {
		_key = _key + [format["headshots_z = headshots_z + %1", _headShots]];
	};
	if (_distanceFoot > 0) then {
		_key = _key + [format["dist_foot = dist_foot + %1", _distanceFoot]];
	};
	if (_timeSince > 0) then {
		_key = _key + [format["duration = duration + %1", _timeSince]];
	};
	_key = _key + [format["current_weapon = '%1'", _currentWpn call strip_quotes]];
	_key = _key + [format["current_anim = '%1'", _currentAnim call strip_quotes]];
	_key = _key + [format["current_temp = %1", _temp]];

	//TODO: Add achievements here when it comes... 1.0.7 :-) ??

	if ((count _friendlies) > 0) then {
		_key = _key + [format["friendlies = '%1'", (str _friendlies) call strip_quotes]];
	};
	if (_killsH > 0) then {
		_key = _key + [format["kills_h = kills_h + %1", _killsH]];
	};
	if (_killsB > 0) then {
		_key = _key + [format["kills_b = kills_b + %1", _killsB]];
	};
	if (_currentModel != "") then {
		_key = _key + [format["model = '%1'", _currentModel call strip_quotes]];
	};
	if (_humanity > 0) then {
		_key = _key + [format["humanity = humanity + %1", _humanity]];
	} else { if (_humanity < 0) then {
		_key = _key + [format["humanity = humanity - %1", abs(_humanity)]];
	};};
	if (Z_SingleCurrency) then {	// Zupa's Single Currency support
		_key = _key + [format["coins = %1", _coins]];
	};
	//diag_log format["DEBUG: server_playerSync: %1", _key];

	//_prof = diag_tickTime - _prof;

	//diag_log format ["Data processing took: %1 seconds", _prof];

	//Wait for HIVE to be free
	// Send request in background
	_query = [format["playerUpdate:%1", _characterID call strip_quotes], _key, ","] call dayz_prepareDataForDB;
	_query call server_hiveWrite;

	//_character setVariable["write_lock", false, false];
	//diag_log ("HIVE: WRITE: "+ str(_query) + " / " + _characterID);
};

if (Z_SingleCurrency) then { //update global coins
	// extDB2
	_key = [_playerUID,dayZ_instance,_globalCoins,_bankCoins];
	_query = ["playerUpdateCoins", _key] call dayz_prepareDataForDB;
	_query = call server_hiveWrite;
	//_key = format["CHILD:205:%1:%2:%3:%4:",_playerUID,dayZ_instance,_globalCoins,_bankCoins];
	//_key call server_hiveWrite;
};

// Force gear updates for nearby vehicles/tents
{[_x,"gear"] call server_updateObject;} count nearestObjects [_charPos,DayZ_GearedObjects,10];
