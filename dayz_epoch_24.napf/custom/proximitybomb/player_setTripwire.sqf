/*
	Set Tripwire script
	
	Last Updated by
	Pastorn - 09/06/2014
*/
private ["_location","_dir","_classname","_item","_hasRequiredTools","_missingT","_missingB","_hastoolweapon","_cancel","_reason","_hasbuilditem","_onLadder","_isWater","_require","_text","_isOk","_num_removed","_position","_object","_classnametmp","_needText","_vehicle","_inVehicle","_typeIsString","_isBuildAdmin","_needBuildItem","_itemIn","_countIn","_qty","_missingQty","_removed","_tobe_removed_total","_removed_total"];

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_40") , "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

// disallow building if too many objects are found within 30m
if((count ((getPosATL player) nearObjects ["All",30])) >= DZE_BuildingLimit) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_41"), "PLAIN DOWN"];};

_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_isWater = 		dayz_isSwimming;
_cancel = false;
_reason = "";

if(isNil "adminBuild") then {
	adminBuild = false;
};

_isBuildAdmin = adminBuild; // (getPlayerUID player) in AdminList;

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

if (_isWater) exitWith {DZE_ActionInProgress = false; cutText [localize "str_player_26", "PLAIN DOWN"];};
if (_inVehicle) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_42"), "PLAIN DOWN"];};
if (_onLadder) exitWith {DZE_ActionInProgress = false; cutText [localize "str_player_21", "PLAIN DOWN"];};
if (player getVariable["combattimeout", 0] >= time) exitWith {DZE_ActionInProgress = false; cutText [(localize "str_epoch_player_43"), "PLAIN DOWN"];};

_typeIsString = ((typeName _this) == "STRING");
//diag_log format["Type is STRING: %1",_typeIsString];
if (_typeIsString) then {
	_item =	_this;
};
if (!_typeIsString) then {
	_item =	_this select 0;
};

_reason = "";

if (_typeIsString) then {
	_classname = 	getText (configFile >> "CfgMagazines" >> _item >> "ItemActions" >> "Build" >> "create");
	_classnametmp = _classname;
	_require =  getArray (configFile >> "cfgMagazines" >> _this >> "ItemActions" >> "Build" >> "require");
};
if (!_typeIsString) then {
	_classname = _this select 0;
	_classnametmp = _classname;
	_require = _this select 1;
};
_text = 		getText (configFile >> "CfgVehicles" >> _classname >> "displayName");


_needText = localize "str_epoch_player_246";

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

	if (!_typeIsString && _hasRequiredTools) then {
		_needBuildItem = _this select 2;
		{
			_itemIn = _x select 0;
			_countIn = _x select 1;
			_qty = { (_x == _itemIn) || (configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn) } count magazines player;
			if(_qty < _countIn) exitWith { _missingB = getText(configFile >> "CfgMagazines" >> _itemIn >> "displayName"); _missingQty = (_countIn - _qty); _hasbuilditem = false;};
		} forEach _needBuildItem;
	};
	
	if (_typeIsString && _hasRequiredTools) then {
		_hasbuilditem = _this in magazines player;
	};
};
// Message If missing
if (!_hasRequiredTools) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_137"),_missingT] , "PLAIN DOWN"];};

if (!_typeIsString && !_hasbuilditem) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_epoch_player_146"),_missingQty, _missingB], "PLAIN DOWN"];};

if (_typeIsString && !_hasbuilditem) exitWith {DZE_ActionInProgress = false; cutText [format[(localize "str_player_31"),_text,"build"] , "PLAIN DOWN"]; };


//Proceed after item check
if (_hasRequiredTools && _hasbuilditem) then {

	_isOk = true;

	player playActionNow "PutDown";
	sleep 1;

	// get inital players position
	_location = getPosATL player;

	_object = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"];
	_dir = getDir player;
	_object setDir _dir;
	player reveal _object;
	
	_position = getPosATL _object;

	cutText [(localize "str_epoch_player_45"), "PLAIN DOWN"];


	// No building in trader zones
	if(!canbuild) then { _cancel = true; _reason = "Cannot set tripwire in a trader city."; };

	if(!_cancel) then {
		//diag_log "Cancel is FALSE";

		_classname = _classnametmp;

		_location = _position;

		// Level it to the ground
		//if((_location select 2) != 0) then {
		//	_location set [2,0];
		//};
	
		_object setPosATL _location;
		cutText [format[(localize "str_epoch_player_138"),_text], "PLAIN DOWN"];
		
		_isOk = false;
		_proceed = true;

		if (_proceed) then {
			//diag_log "Proceed OK";
			_tobe_removed_total = 0;
			_removed_total = 0;
			_temp_removed_array = [];
			if (!_isBuildAdmin) then {
				//diag_log "Is Admin REMOVE NOT OK";
				if (_typeIsString) then {
					_tobe_removed_total = ([player,_item] call BIS_fnc_invRemove);
					_removed_total = _tobe_removed_total;
				};
				if (!_typeIsString) then {
					{
						_removed = 0;
						_num_removed = 0;
						_itemIn = _x select 0;
						_countIn = _x select 1;
						//diag_log format["Recipe Finish: %1 %2", _itemIn,_countIn];
						_tobe_removed_total = _tobe_removed_total + _countIn;
			
						{					
							if( (_removed < _countIn) && ((_x == _itemIn) || configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn)) then {
								_num_removed = ([player,_x] call BIS_fnc_invRemove);
								if (_num_removed == 0) then {
									_num_removed = count magazines player;
									player removeMagazine _x;
									_num_removed = _num_removed - count magazines player;
								};

								_removed = _removed + _num_removed;
								_removed_total = _removed_total + _num_removed;
								if(_num_removed >= 1) then {
									_temp_removed_array set [count _temp_removed_array,_x];
								};
							};
						} forEach magazines player;
					} forEach _needBuildItem;
				};
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

				if ("Explosive" == typeOf _object) then {
					[] spawn {
						Private ["_count"];
						_count = 10;
						while { _count > 0 } do {
							cutText [format["%1 seconds until Explosive Tripwire is armed...", _count], "PLAIN DOWN"];
							sleep 1;
							_count = _count - 1;
						};	
						cutText ["Tripwire is now armed!", "PLAIN DOWN"];
					};
				};

				//diag_log "Publish Other";
				PVDZE_obj_Publish = [dayz_characterID,_object,[_dir,_location],_classname];
				publicVariableServer "PVDZE_obj_Publish";
			} else {
				//diag_log "Remove Item NOT OK";
				deleteVehicle _object;
				cutText [(localize "str_epoch_player_46") , "PLAIN DOWN"];
				{
					//diag_log format["Restoring %1 to player's inventory...", _x];
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
