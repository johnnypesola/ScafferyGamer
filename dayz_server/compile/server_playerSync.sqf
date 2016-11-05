private ["_empty","_name","_playerwasNearby","_character","_magazines","_force","_characterID","_charPos","_isInVehicle","_timeSince","_humanity","_debug","_distance","_isNewMed","_isNewPos","_isNewGear","_playerPos","_playerGear","_playerBackp","_medical","_distanceFoot","_lastPos","_backpack","_kills","_killsB","_killsH","_headShots","_lastTime","_timeGross","_timeLeft","_currentWpn","_currentAnim","_config","_onLadder","_isTerminal","_currentModel","_modelChk","_muzzles","_temp","_currentState","_array","_key","_query","_pos","_forceGear","_friendlies","_ws","_updatePos","_updateInv","_updateBackpack","_updateMed"];

_character = 	_this select 0;
_magazines = _this select 1;

//_force = 		_this select 2;
_forceGear =	_this select 3;
_force =	true;
_playerwasNearby = false;

if ((count _this) > 4) then {
	_playerwasNearby =	_this select 4;
};

if (isNull _character) exitWith {
	diag_log ("Player is Null FAILED: Exiting, player sync: " + str(_character));
};



_characterID =	_character getVariable ["CharacterID","0"];
_charPos = 		getPosATL _character;
_isInVehicle = 	vehicle _character != _character;
_timeSince = 	0;
_humanity =	0;
_friendlies = [];
_updatePos = false;
_updateInv = false;
_updateBackpack = false;
_updateMed = false;


//diag_log ("DW_DEBUG: (isnil _characterID): " + str(isnil "_characterID"));
_name = if (alive _character) then { name _character; } else { "Dead Player"; };
if (_character isKindOf "Animal") exitWith {
	diag_log ("ERROR: Cannot Sync Character " + (_name) + " is an Animal class");
};

if (isnil "_characterID") exitWith {
	diag_log ("ERROR: Cannot Sync Character " + (_name) + " has nil characterID");	
};

if (_characterID == "0") exitWith {
	diag_log ("ERROR: Cannot Sync Character " + (_name) + " as no characterID");
};

private["_debug","_distance"];
_debug = getMarkerpos "respawn_west";
_distance = _debug distance _charPos;
if (_distance < 2000) exitWith { 
	// Disabled by ESS
	//diag_log format["ERROR: server_playerSync: Cannot Sync Player %1 [%2]. Position in debug! %3",_name,_characterID,_charPos];
};


//Check for server initiated updates
_isNewMed =		_character getVariable["medForceUpdate",false];		//Med Update is forced when a player receives some kind of med incident
_isNewPos =		_character getVariable["posForceUpdate",false];		//Med Update is forced when a player receives some kind of med incident
_isNewGear =	(count _magazines) > 0;

//Check for player initiated updates
if (_characterID != "0") then {
	_key = [];
	_playerPos =	[];
	_playerGear =	[[],[]];
	_playerBackp =	["", [[],[]], [[],[]]];
	_medical =	[];
	_distanceFoot =	0;
	_backpack = "";
	_ws = "cherno";
	_friendlies = [];
	
	//diag_log ("Found Character...");
	
	//Check if update is requested
	if (_isNewPos || _force) then {
		//diag_log ("position..." + str(_isNewPos) + " / " + str(_force)); sleep 0.05;
		if (((_charPos select 0) == 0) && ((_charPos select 1) == 0)) then {
			//Zero Position
		} else {
			//diag_log ("getting position..."); sleep 0.05;
			//_playerPos = 	[round(direction _character),_charPos];
			_lastPos = 		_character getVariable["lastPos",_charPos];
			if (count _lastPos > 2 && count _charPos > 2) then {
				if (!_isInVehicle) then {
					_distanceFoot = round(_charPos distance _lastPos);
				};
				_character setVariable["lastPos",_charPos];
			};
			if (count _charPos < 3) then {
				_playerPos =	[];
			} else {
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
	};
	if (_isNewGear || _forceGear) then {
		//diag_log ("gear..."); sleep 0.05;
		//_playerGear = [weapons _character,_magazines];
		//diag_log ("playerGear: " +str(_playerGear));

		_backpack = unitBackpack _character;
		_updateInv = true;

		if(_playerwasNearby) then {
			_empty = [[],[]];
			//_playerBackp = [typeOf _backpack,_empty,_empty];
		} else {
			//_playerBackp = [typeOf _backpack,getWeaponCargo _backpack,getMagazineCargo _backpack];
			_updateBackpack = true;
		};
	};
	if (_isNewMed || _force) then {
		//diag_log ("medical..."); sleep 0.05;
		if (!(_character getVariable["USEC_isDead",false])) then {
			//diag_log ("medical check..."); sleep 0.05;
			_medical = _character call player_sumMedical;
			//diag_log ("medical result..." + str(_medical)); sleep 0.05;

			_updateMed = true;
		};
		_character setVariable ["medForceUpdate",false,true];
	};
	
	//Process update
	if (_characterID != "0") then {
		//Record stats while we're here
		/*
			Check previous stats against what client had when they logged in
			this helps prevent JIP issues, where a new player wouldn't have received
			the old players updates. Only valid for stats where clients could have
			be recording  results from their local objects (such as agent zombies)
		*/
		_kills = 		["zombieKills",_character] call server_getDiff;
		_killsB = 		["banditKills",_character] call server_getDiff;
		_killsH = 		["humanKills",_character] call server_getDiff;
		_headShots = 	["headShots",_character] call server_getDiff;
		_humanity = 	["humanity",_character] call server_getDiff2;
		//_humanity = 	_character getVariable ["humanity",0];
		_character addScore _kills;		

		//
		//	Assess how much time has passed, for recording total time on server
		//
		_lastTime = 	_character getVariable["lastTime",time];
		_timeGross = 	(time - _lastTime);
		_timeSince = 	floor(_timeGross / 60);
		_timeLeft =		(_timeGross - (_timeSince * 60));

		if (_timeSince > 0) then {
			_key = _key + [format["duration = duration + %1", _timeSince]];
		};

		//
		//	Get character state details
		//
		_currentWpn = 	currentMuzzle _character;
		_currentAnim =	animationState _character;
		_config = 		configFile >> "CfgMovesMaleSdr" >> "States" >> _currentAnim;
		_onLadder =		(getNumber (_config >> "onLadder")) == 1;
		_isTerminal = 	(getNumber (_config >> "terminal")) == 1;
		//_wpnDisabled =	(getNumber (_config >> "disableWeapons")) == 1;
		_currentModel = typeOf _character;
		_modelChk = 	_character getVariable ["model_CHK",""];

		if (_currentModel == _modelChk) then {
			_currentModel = "";
		} else {
			_currentModel = _currentModel;
			_character setVariable ["model_CHK",typeOf _character];
		};

		if (_onLadder || _isInVehicle || _isTerminal) then {
			_currentAnim = "";
			//If position to be updated, make sure it is at ground level!
			if ((count _playerPos > 0) && !_isTerminal) then {
				_charPos set [2,0];
				_playerPos set[1,_charPos];					
			};
		};

		if (_isInVehicle) then {
			_currentWpn = "";
		} else {
			if ( typeName(_currentWpn) == "STRING" ) then {
				_muzzles = getArray(configFile >> "cfgWeapons" >> _currentWpn >> "muzzles");
				if (count _muzzles > 1) then {
					_currentWpn = currentMuzzle _character;
				};	
			} else {
				//diag_log ("DW_DEBUG: _currentWpn: " + str(_currentWpn));
				_currentWpn = "";
			};
		};

		_temp = round(_character getVariable ["temperature",100]);
		_currentState = [_currentWpn,_currentAnim,_temp];
		if(DZE_FriendlySaving) then {
			// save only last/most recent 5 entrys as we only have 200 chars in db field && weapon + animation names are sometimes really long 60-70 chars.
			_friendlies = [(_character getVariable ["friendlies",[]]),5] call array_reduceSizeReverse;
			//_currentState set [(count _currentState),_friendlies];
		};
		/*
			Everything is ready, now publish to HIVE
		*/
		if (count _playerPos > 0) then {
			_array = [];
			{
				if (_x > dayz_minpos && _x < dayz_maxpos) then {
					_array set [count _array,_x];
				};
			} count (_playerPos select 1);
			_playerPos set [1,_array];
		};
		
		
		if (!isNull _character) then {
			if (alive _character) then {

				// Collect data for update
				[
					_characterID,
					_character,
					_updatePos,
					_ws,
					_charPos,
					_updateInv,
					_magazines,
					_updateBackpack,
					_backpack,
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
					_humanity
				] spawn {
					private["_query", "_key","_characterID","_character","_updatePos","_ws","_charPos",
						"_updateInv","_magazines","_updateBackpack","_backpack","_updateMed","_medical","_isDead",
						"_isUncon","_isInfect","_isInjured","_isInPain","_isCardiac","_isLowBlood",
						"_kills","_headShots","_distanceFoot","_timeSince","_currentWpn","_currentAnim",
						"_temp","_friendlies","_killsH","_killsB","_currentModel","_humanity","_empty","_prof"];

					_prof = diag_tickTime;
					_key = [];
					_characterID = _this select 0;
					_character = _this select 1;
					_updatePos = _this select 2;
					_ws = _this select 3;
					_charPos = _this select 4;
					_updateInv = _this select 5;
					_magazines = _this select 6;
					_updateBackpack = _this select 7;
					_backpack = _this select 8;
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

					if (_updatePos) then {
						_key = _key + [
							format["ws_%1_x = %2", _ws, _charPos select 0],
							format["ws_%1_y = %2", _ws, _charPos select 1],
							format["ws_%1_z = %2", _ws, _charPos select 2],
							format["ws_%1_dir = %2", _ws, round(direction _character)]
						];
					};
					if (_updateInv) then {
						_key = _key + [
							format["inventory_magazines = '%1'", (str _magazines) call strip_quotes],
							format["inventory_weapons = '%1'", (str (weapons _character)) call strip_quotes],
							format["backpack = '%1'", (typeOf _backpack) call strip_quotes]
						];
						if (_updateBackpack) then {
							_key = _key + [
								format["backpack_magazines = '%1'", (str (getMagazineCargo _backpack)) call strip_quotes],
								format["backpack_weapons = '%1'", (str (getWeaponCargo _backpack)) call strip_quotes]
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
							format["med_messing = '%1'", (str (_medical select 11)) call strip_quotes]
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
					//diag_log format["DEBUG: server_playerSync: %1", _key];

					_prof = diag_tickTime - _prof;

					diag_log format ["Data processing took: %1 seconds", _prof];

					//Wait for HIVE to be free
					// Send request in background
					_query = [format["playerUpdate:%1", _characterID call strip_quotes], _key, ","] call dayz_prepareDataForDB;
					_query call server_hiveWrite;
				};

				//diag_log ("HIVE: WRITE: "+ str(_query) + " / " + _characterID);
			};
		};

		// If player is in a vehicle, keep its position updated
		if (vehicle _character != _character) then {
			//[vehicle _character, "position"] call server_updateObject;
			if (!(vehicle _character in needUpdate_objects)) then {
				//diag_log format["DEBUG: Added to NeedUpdate=%1",vehicle _character];
				needUpdate_objects set [count needUpdate_objects, vehicle _character];
			};
		};
		
		// Force gear updates for nearby vehicles/tents
		//_pos = _this select 0;
		{
			[_x, "gear"] call server_updateObject;
		} count nearestObjects [_charPos, dayz_updateObjects, 10];
		//} count nearestObjects [_pos, dayz_updateObjects, 10];
		//[_charPos] call server_updateNearbyObjects;

		//Reset timer
		if (_timeSince > 0) then {
			_character setVariable ["lastTime",(time - _timeLeft)];
		};
	};
};
