/*
	DayZ Base Building
	Made for DayZ Epoch please ask permission to use/edit/distrubute email vbawol@veteranbastards.com.
	
	Adaptation for custom buildables by
	Pastorn - 04/16/2017
*/
private ["_location","_pos","_dir","_classname","_item","_cancel","_reason","_started","_finished","_animState","_isMedic","_dis","_sfx","_tmpbuilt","_onLadder","_require","_text","_offset","_isOk","_location1","_location2","_counter","_limit","_proceed","_num_removed","_position","_object","_canBuildOnPlot","_distance","_classnametmp","_ghost","_lockable","_zheightchanged","_rotate","_combination_1","_combination_2","_combination_3","_combination_4","_combination","_combination_1_Display","_combinationDisplay","_zheightdirection","_abort","_isNear","_needNear","_vehicle","_inVehicle","_objHDiff","_isAllowedUnderGround","_canBuild","_hasItems","_num_provided","_item_count"];

if (dayz_actionInProgress) exitWith {localize "str_epoch_player_40" call dayz_rollingMessages;};
dayz_actionInProgress = true;
_pos = [player] call FNC_GetPos;

_onLadder = (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;

_cancel = false;
_canBuildOnPlot = false;

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);

DZE_Q = false;
DZE_Z = false;

DZE_Q_alt = false;
DZE_Z_alt = false;

DZE_Q_ctrl = false;
DZE_Z_ctrl = false;

DZE_5 = false;
DZE_4 = false;
DZE_6 = false;

DZE_cancelBuilding = false;

call gear_ui_init;
closeDialog 1;

if (dayz_isSwimming) exitWith {dayz_actionInProgress = false; localize "str_player_26" call dayz_rollingMessages;};
if (_inVehicle) exitWith {dayz_actionInProgress = false; localize "str_epoch_player_42" call dayz_rollingMessages;};
if (_onLadder) exitWith {dayz_actionInProgress = false; localize "str_player_21" call dayz_rollingMessages;};
if (player getVariable["combattimeout",0] >= diag_tickTime) exitWith {dayz_actionInProgress = false; localize "str_epoch_player_43" call dayz_rollingMessages;};

_classname =_this select 0;
_require = _this select 1;
_item = _this select 2;
_offset = _this select 3;

// Need Near Requirements
_abort = false;
_reason = "";

_needNear = ["Plastic_Pole_EP1_DZ"];

{
	switch(_x) do{
		case "Plastic_Pole_EP1_DZ":
		{
			_distance = 30;
			_isNear = count (nearestObjects [_pos, _needNear, _distance]);
			if(_isNear == 0) then {
				_abort = true;
				_reason = localize "str_epoch_player_246";
			};
		};
	};
} forEach _needNear;


if(_abort) exitWith {
	format[localize "str_epoch_player_135",_reason,_distance] call dayz_rollingMessages;
	dayz_actionInProgress = false;
};

_hasItems = [(_item select 0) select 0, _require, _classname] call dze_requiredItemsCheck;
//_canBuild = [_pos, _item, true] call dze_buildChecks;

_text = "";
_num_provided = 0;
_counter = 0;
{
	_classnametmp = _x select 0;
	_item_count = { _x == _classnametmp } count magazines player;
	_num_provided = _num_provided + _item_count;

	_hasItems = _hasItems && (_x select 1) <= _item_count;

	if (_item_count != _x select 1) then {
		if (_counter == 0) then {
			_text = format["%1x %2", (_x select 1) - _item_count, _x select 0];
		} else {
			_text = format["%1, %2x %3", _text, (_x select 1) - _item_count, _x select 0];
		};
		_counter = _counter + 1;
	};
} forEach _item;

if (!_hasItems) exitWith {
	dayz_actionInProgress = false;
	format["Missing items: %1",_text] call dayz_rollingMessages;
	false;
};

_canBuild = [_hasItems];

if (_canBuild select 0) then {
	_classnametmp = _classname;
	_require = [];
	_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
	if (_classname == "MAP_F_postel_manz_kov") then { _text = "Spawn Bed"; };

	_isAllowedUnderGround = 0;

	if (_classname == "MAP_F_postel_manz_kov") then {
		// Check for existing beds
		_bedObject = objNull;
		_existingBeds = allMissionObjects "MAP_F_postel_manz_kov";
		{if ((_x getVariable ["OwnerPUID","0"]) == _playerUID) exitWith {_bedObject=_x;};} foreach _existingBeds;
		if (!isNull _bedObject) exitWith {format ["You already have a spawn bed at %1.", getPosATL _bedObject] call dayz_rollingMessages;dayz_actionInProgress = false;};
	};

	_location = [0,0,0];
	_isOk = true;
	_location1 = [player] call FNC_GetPos; // get inital players position
	_dir = getDir player;


	_object = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];

	if((count _offset) <= 0) then {
		_offset = [0,(abs(((boundingBox _object)select 0) select 1)),0];
	};

	_object attachTo [player,_offset];

	_position = getPosATL _object;

	//localize "str_epoch_player_45" call dayz_rollingMessages;
	if (_classname == "MAP_F_postel_manz_kov") then {
		format["Warning: You can only build one bed and must be destroyed in order to build another!"] call dayz_rollingMessages;
	};

	_objHDiff = 0;

	while {_isOk} do {

		_zheightchanged = false;
		_zheightdirection = "";
		_rotate = false;

		if (DZE_Q) then {
			DZE_Q = false;
			_zheightdirection = "up";
			_zheightchanged = true;
		};
		if (DZE_Z) then {
			DZE_Z = false;
			_zheightdirection = "down";
			_zheightchanged = true;
		};
		if (DZE_Q_alt) then {
			DZE_Q_alt = false;
			_zheightdirection = "up_alt";
			_zheightchanged = true;
		};
		if (DZE_Z_alt) then {
			DZE_Z_alt = false;
			_zheightdirection = "down_alt";
			_zheightchanged = true;
		};
		if (DZE_Q_ctrl) then {
			DZE_Q_ctrl = false;
			_zheightdirection = "up_ctrl";
			_zheightchanged = true;
		};
		if (DZE_Z_ctrl) then {
			DZE_Z_ctrl = false;
			_zheightdirection = "down_ctrl";
			_zheightchanged = true;
		};
		if (DZE_4) then {
			_rotate = true;
			DZE_4 = false;
			_dir = 180;
		};
		if (DZE_6) then {
			_rotate = true;
			DZE_6 = false;
			_dir = 0;
		};

		if(_rotate) then {
			_object setDir _dir;
			_object setPosATL _position;
			//diag_log format["DEBUG Rotate BUILDING POS: %1", _position];
		};

		if(_zheightchanged) then {
			detach _object;

			_position = getPosATL _object;

			if(_zheightdirection == "up") then {
				_position set [2,((_position select 2)+0.1)];
				_objHDiff = _objHDiff + 0.1;
			};
			if(_zheightdirection == "down") then {
				_position set [2,((_position select 2)-0.1)];
				_objHDiff = _objHDiff - 0.1;
			};

			if(_zheightdirection == "up_alt") then {
				_position set [2,((_position select 2)+1)];
				_objHDiff = _objHDiff + 1;
			};
			if(_zheightdirection == "down_alt") then {
				_position set [2,((_position select 2)-1)];
				_objHDiff = _objHDiff - 1;
			};

			if(_zheightdirection == "up_ctrl") then {
				_position set [2,((_position select 2)+0.01)];
				_objHDiff = _objHDiff + 0.01;
			};
			if(_zheightdirection == "down_ctrl") then {
				_position set [2,((_position select 2)-0.01)];
				_objHDiff = _objHDiff - 0.01;
			};

			_object setDir (getDir _object);

			if((_isAllowedUnderGround == 0) && ((_position select 2) < 0)) then {
				_position set [2,0];
			};

			_object setPosATL _position;

			//diag_log format["DEBUG Change BUILDING POS: %1", _position];

			_object attachTo [player];

		};

		uiSleep 0.5;

		_location2 = getPosATL player;

		if(DZE_5) exitWith {
			_isOk = false;
			detach _object;
			_dir = getDir _object;
			_position = getPosATL _object;
			//diag_log format["DEBUG BUILDING POS: %1", _position];
			deleteVehicle _object;
		};

		if(_location1 distance _location2 > DZE_buildMaxMoveDistance) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = format[localize "STR_EPOCH_BUILD_FAIL_MOVED",DZE_buildMaxMoveDistance];
			detach _object;
			deleteVehicle _object;
		};

		if(abs(_objHDiff) > DZE_buildMaxHeightDistance) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = format[localize "STR_EPOCH_BUILD_FAIL_HEIGHT",DZE_buildMaxHeightDistance];
			detach _object;
			deleteVehicle _object;
		};

		if (player getVariable["combattimeout",0] >= diag_tickTime) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = localize "str_epoch_player_43";
			detach _object;
			deleteVehicle _object;
		};

		if (DZE_cancelBuilding) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = localize "STR_EPOCH_PLAYER_46";
			detach _object;
			deleteVehicle _object;
		};
	};

	//No building on roads unless toggled
	if (!DZE_BuildOnRoads) then {
		if (isOnRoad _position) then { _cancel = true; _reason = localize "STR_EPOCH_BUILD_FAIL_ROAD"; };
	};

	// No building in trader zones
	if(!canbuild) then { _cancel = true; _reason = format[localize "STR_EPOCH_PLAYER_136",localize "STR_EPOCH_TRADER"]; };

	if(!_cancel) then {

		_classname = _classnametmp;

		// Start Build
		_tmpbuilt = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];

		_tmpbuilt setdir _dir;

		// Get position based on object
		_location = _position;

		if((_isAllowedUnderGround == 0) && ((_location select 2) < 0)) then {
			_location set [2,0];
		};

		_tmpbuilt setPosATL _location;

		format[localize "str_epoch_player_138",_text] call dayz_rollingMessages;

		_limit = 3;

		if (DZE_StaticConstructionCount > 0) then {
			_limit = DZE_StaticConstructionCount;
		}
		else {
			if (isNumber (configFile >> "CfgVehicles" >> _classname >> "constructioncount")) then {
				_limit = getNumber(configFile >> "CfgVehicles" >> _classname >> "constructioncount");
			};
		};

		_isOk = true;
		_proceed = false;
		_counter = 0;

		while {_isOk} do {
		
			format[localize "str_epoch_player_139",_text, (_counter + 1),_limit] call dayz_rollingMessages;

			player playActionNow "Medic";

			_dis=20;
			_sfx = "repair";
			[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
			[player,_dis,true,(getPosATL player)] spawn player_alertZombies;

			r_interrupt = false;
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
				if (r_interrupt || (player getVariable["combattimeout",0] >= diag_tickTime)) then {
					r_doLoop = false;
				};
				if (DZE_cancelBuilding) exitWith {
					r_doLoop = false;
				};
				uiSleep 0.1;
			};
			r_doLoop = false;


			if(!_finished) exitWith {
				_isOk = false;
				_proceed = false;
			};

			if(_finished) then {
				_counter = _counter + 1;
			};

			if(_counter == _limit) exitWith {
				_isOk = false;
				_proceed = true;
			};

		};

		if (_classname == "MAP_F_postel_manz_kov") then {
			format["You have built a spawn bed, you can respawn here if you die :)"] call dayz_rollingMessages;
		};

		if (_proceed) then {

			_num_removed = 0;
			{
				private ["_qty"];
				for [{_qty=0},{_qty<_x select 1},{_qty=_qty+1}] do {
					_num_removed = _num_removed + ([player, _x select 0] call BIS_fnc_invRemove);
				};
			} forEach _item;

			if(_num_removed == _num_provided) then {
				["Working",0,[20,10,5,0]] call dayz_NutritionSystem;
				call player_forceSave;
				format[localize "str_build_01",_text] call dayz_rollingMessages;

				_tmpbuilt setVariable ["OEMPos",_location,true];
				_tmpbuilt setVariable ["CharacterID",dayz_characterID,true];

				_tmpbuilt setVariable ["ownerPUID",dayz_playerUID,true];
				PVDZ_obj_Publish = [dayz_characterID,_tmpbuilt,[_dir,_location,dayz_playerUID],[]];
				publicVariableServer "PVDZ_obj_Publish";

			} else {
				deleteVehicle _tmpbuilt;
				localize "str_epoch_player_46" call dayz_rollingMessages;
			};
		} else {
			r_interrupt = false;
			if (vehicle player == player) then {
				[objNull, player, rSwitchMove,""] call RE;
				player playActionNow "stop";
			};

			deleteVehicle _tmpbuilt;

			localize "str_epoch_player_46" call dayz_rollingMessages;
		};
	} else {
		format[localize "str_epoch_player_47",_text,_reason] call dayz_rollingMessages;
	};
};

dayz_actionInProgress = false;
