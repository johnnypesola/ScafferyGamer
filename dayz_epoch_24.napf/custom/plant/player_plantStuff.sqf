private ["_onLadder", "_isWater", "_cancel", "_reason", "_canBuildOnPlot", "_isBuildAdmin", "_vehicle", "_inVehicle", "_playerName", "_item", "_abort", "_distance", "_classname", "_classnametmp", "_require", "_text", "_requireplot", "_offset", "_needText", "_findNearestPoles","_findNearestPole","_IsNearPlot","_nearestPole","_ownerID","_friendlies","_missingT","_missingB","_hasRequiredTools","_hasbuilditem","_needBuildItem","_itemIn","_countIn","_qty","_location","_isOk","_location1","_dir","_object","_position","_location2","_proceed","_counter","_animState","_started","_finished","_isMedic","_tobe_removed_total","_removed_total","_temp_removed_array","_num_removed"];



if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_40") , "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

// disallow building if too many objects are found within 30m
if((count ((getPosATL player) nearObjects ["All",30])) >= DZE_BuildingLimit) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_41"), "PLAIN DOWN"];};

_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_isWater = 		dayz_isSwimming;
_cancel = false;
_reason = "";
_canBuildOnPlot = false;

if(isNil "adminBuild") then {
	adminBuild = false;
};

_isBuildAdmin = adminBuild; // (getPlayerUID player) in AdminList;

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_playerName = name player;

DZE_cancelBuilding = false;

call gear_ui_init;
closeDialog 1;

if (_isWater) exitWith {DZE_ActionInProgress = false; cutText [localize "str_player_26", "PLAIN DOWN"];};
if (_inVehicle) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_42"), "PLAIN DOWN"];};
if (_onLadder) exitWith {DZE_ActionInProgress = false; cutText [localize "str_player_21", "PLAIN DOWN"];};
if (player getVariable["combattimeout", 0] >= time) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_43"), "PLAIN DOWN"];};

_abort = false;
_distance = 10;
_reason = "";

if(_abort) exitWith {
	cutText [format[(localize "str_epoch_player_135"),_reason,_distance], "PLAIN DOWN"];
	DZE_ActionInProgress = false;
};

_item =	_this select 0;
_require = _this select 1;
_needBuildItem = _this select 2;
_offset = _this select 3;
_text = _this select 4;
_classname = _item;
_classnametmp = _classname;

_requireplot = DZE_requireplot;

_distance = DZE_PlotPole select 0;
_needText = localize "str_epoch_player_246";

// check for near plot
_findNearestPoles = nearestObjects [(vehicle player), ["Plastic_Pole_EP1_DZ"], _distance];
_findNearestPole = [];

{
if (alive _x) then {
	_findNearestPole set [(count _findNearestPole),_x];
};
} foreach _findNearestPoles;

_IsNearPlot = count (_findNearestPole);

if(_IsNearPlot == 0) then {

	// Allow building of plot
	if(_requireplot == 0) then {
		_canBuildOnPlot = true;
	};

} else {
	// Since there are plots nearby we check for ownership && then for friend status

	// check nearby plots ownership && then for friend status
	_nearestPole = _findNearestPole select 0;

	// Find owner
	_ownerID = _nearestPole getVariable ["CharacterID","0"];

	// diag_log format["DEBUG BUILDING: %1 = %2", dayz_characterID, _ownerID];

	// check if friendly to owner
	if(dayz_characterID == _ownerID) then {  //Keep ownership
		// owner can build anything within his plot except other plots
		_canBuildOnPlot = true;

	} else {
		// disallow building plot
		_friendlies		= player getVariable ["friendlyTo",[]];
		// check if friendly to owner
		if(_ownerID in _friendlies) then {
			_canBuildOnPlot = true;
		};
	};
};

//Item Check
if(!_canBuildOnPlot) exitWith {  DZE_ActionInProgress = false; cutText [format[(localize "STR_EPOCH_PLAYER_135"),_needText,_distance] , "PLAIN DOWN"]; };

_missingT = "";
_missingB = "";
_hasRequiredTools = true;
_hasbuilditem = true;
if (!_isBuildAdmin) then {
	{
		//diag_log format["Testing for tool: %1",_x];
		_hastoolweapon = _x in weapons player;
		if(!_hastoolweapon) exitWith {_hasRequiredTools = false; _missingT = getText (configFile >> "cfgWeapons" >> _x >> "displayName");};
	} forEach _require;

	if (_hasRequiredTools) then {
		{
			_itemIn = _x select 0;
			_countIn = _x select 1;
			_qty = { (_x == _itemIn) } count magazines player;
			if(_qty < _countIn) exitWith { _missingB = getText(configFile >> "CfgMagazines" >> _itemIn >> "displayName"); _missingQty = (_countIn - _qty); _hasbuilditem = false;};
		} forEach _needBuildItem;
	};
};
// Message If missing
if (!_hasRequiredTools) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_137"),_missingT] , "PLAIN DOWN"];};

if (!_hasbuilditem) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_146"),_missingQty, _missingB], "PLAIN DOWN"];};

//Proceed after item check
if (_hasRequiredTools && _hasbuilditem) then {

	_location = [0,0,0];
	_isOk = true;

	// get inital players position
	_location1 = getPosATL player;
	_dir = getDir player;


	_object = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];
	_object setDir _dir;
	_object attachTo [player,_offset];
	
	_position = getPosATL _object;

	cutText [(localize "str_epoch_player_45"), "PLAIN DOWN"];

	player allowDamage false;

	while {_isOk} do {
		sleep 1;
		_location2 = getPosATL player;

		if(DZE_5) exitWith {
			_isOk = false;
			detach _object;
			_dir = getDir _object;
			_position = getPosATL _object;
		};

		if(_location1 distance _location2 > 3) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = "You've moved to far away from where you started planting (within 3 meters)"; 
			detach _object;
		};
		
		if (player getVariable["combattimeout", 0] >= time) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = (localize "str_epoch_player_43");
			detach _object;
		};

		if (DZE_cancelBuilding) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = "Cancelled planting.";
			detach _object;
		};
	};

	player allowDamage true;
	
	if (isOnRoad _position) then { _cancel = true; _reason = "Cannot plant on a road."; };

	// No building in trader zones
	if(!canbuild) then { _cancel = true; _reason = "Cannot plant in a city."; };

	if(!_cancel) then {
		//diag_log "Cancel is FALSE";

		_classname = _classnametmp;

		_location = _position;
		_location set [2,0];
	
		_object setPosATL _location;
		cutText [format[(localize "str_epoch_player_138"),_text], "PLAIN DOWN"];
		
		_limit = 1;

		_isOk = true;
		_proceed = false;
		_counter = 0;

		while {_isOk && !_isBuildAdmin} do {

			[10,10] call dayz_HungerThirst;
			player playActionNow "Medic";

			r_interrupt = false;
			_animState = animationState player;
			r_doLoop = true;
			_started = false;
			_finished = false;

			while {r_doLoop} do {
				_animState = animationState player;
				_isMedic = ["medic",_animState] call fnc_inString;
				if (_isMedic) then {
					_started = true;
				};
				if (_started && !_isMedic) then {
					r_doLoop = false;
					_finished = true;
				};
				if (r_interrupt || (player getVariable["combattimeout", 0] >= time)) then {
					r_doLoop = false;
				};
				if (DZE_cancelBuilding) exitWith {
					r_doLoop = false;
				};
				sleep 0.1;
			};
			r_doLoop = false;


			if(!_finished) exitWith {
				_isOk = false;
				_proceed = false;
			};

			if(_finished) then {
				_counter = _counter + 1;
			};

			cutText [format["Planting seeds, step %1 of %2...", _counter,_limit], "PLAIN DOWN"];

			if(_counter == _limit) exitWith {
				_isOk = false;
				_proceed = true;
			};

		};

		if (_isBuildAdmin) then {
			_isOk = false;
			_proceed = true;
		};
		
		if (_proceed) then {
		//diag_log "Proceed OK";
			_tobe_removed_total = 0;
			_removed_total = 0;
			_temp_removed_array = [];
			if (!_isBuildAdmin) then {
				//diag_log "Is Admin REMOVE NOT OK";
				{
					_removed = 0;
					_itemIn = _x select 0;
					_countIn = _x select 1;
					// //diag_log format["Recipe Finish: %1 %2", _itemIn,_countIn];
					_tobe_removed_total = _tobe_removed_total + _countIn;
		
					{					
						if( (_removed < _countIn) && (_x == _itemIn)) then {
							_num_removed = ([player,_x] call BIS_fnc_invRemove);
							_removed = _removed + _num_removed;
							_removed_total = _removed_total + _num_removed;
							if(_num_removed >= 1) then {
								_temp_removed_array set [count _temp_removed_array,_x];
							};
						};
					} forEach magazines player;
				} forEach _needBuildItem;
			} else {
				//diag_log "Is Admin REMOVE OK";
				_tobe_removed_total = 1;
				_removed_total = 1;
			};
			if((_tobe_removed_total == _removed_total) && (_removed_total >= 1)) then {
				//diag_log "Removed Item OK";
				cutText [format[localize "str_build_01",_text], "PLAIN DOWN"];

				_object setVariable ["OEMPos",_location,true];
				_object setVariable ["CharacterID",dayz_characterID,true];

				//diag_log "Publish Other";
				PVDZE_obj_Publish = [dayz_characterID,_object,[_dir,_location],_classname,_playerName];
				publicVariableServer "PVDZE_obj_Publish";

			} else {
				//diag_log "Remove Item NOT OK";
				deleteVehicle _object;
				cutText [(localize "str_epoch_player_46") , "PLAIN DOWN"];
				{
					[player,_x] call BIS_fnc_invAdd;
				} forEach _temp_removed_array;				
			};

		} else {
			//diag_log "Proceed NOT OK";
			r_interrupt = false;
			if (vehicle player == player) then {
				[objNull, player, rSwitchMove,""] call RE;
				player playActionNow "stop";
			};

			deleteVehicle _object;
			cutText [(localize "str_epoch_player_46") , "PLAIN DOWN"];
		};

	} else {
		//diag_log "Cancel is TRUE";
		deleteVehicle _object;
		cutText [format[(localize "str_epoch_player_47"),_text,_reason], "PLAIN DOWN"];
	};
};

DZE_ActionInProgress = false;
