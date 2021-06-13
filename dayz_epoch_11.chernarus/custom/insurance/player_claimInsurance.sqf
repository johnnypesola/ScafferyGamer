if (dayz_actionInProgress) exitWith {localize "STR_EPOCH_PLAYER_52" call dayz_rollingMessages;};
dayz_actionInProgress = true;

private["_keyItem","_playerUID","_requirementsMagazine","_missingQty","_missing","_proceed","_itemIn","_countIn","_qty","_textMissing","_finished","_temp_removed_array_mag","_removed_total","_tobe_removed_total","_removed","_num_removed"];

if (!isServer) then {

	_keyItem = _this select 0;
	_requirementsMagazine = _this select 1;

	_missingQty = 0;
	_missing = "";

	_proceed = true;
	{
		_itemIn = _x select 0;
		_countIn = _x select 1;
		_qty = {_x == _itemIn} count magazines player;
		if (_qty < _countIn) exitWith { _missing = _itemIn; _missingQty = (_countIn - _qty); _proceed = false; };
	} count _requirementsMagazine;

	if (_proceed) then {
		[player,(getPosATL player),20,"repair"] spawn fnc_alertZombies;
		_finished = ["Medic",1] call fn_loopAction;
		if (!_finished) exitWith {};
		_temp_removed_array_mag = [];
		_removed_total = 0;
		_tobe_removed_total = 0;

		{
			_removed = 0;
			_itemIn = _x select 0;
			_countIn = _x select 1;
			//diag_log format["Recipe Finish: %1 %2", _itemIn,_countIn];
			_tobe_removed_total = _tobe_removed_total + _countIn;

			{
				if ((_removed < _countIn) && {(_x == _itemIn) || {configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn}}) then {
					_num_removed = ([player,_x] call BIS_fnc_invRemove);
					_removed = _removed + _num_removed;
					_removed_total = _removed_total + _num_removed;
					if (_num_removed >= 1) then {
						_temp_removed_array_mag set [count _temp_removed_array_mag,_x];
					};
				};
			} count magazines player;
		} forEach _requirementsMagazine;

		// all parts removed proceed
		if (_tobe_removed_total == _removed_total) then {
			call player_forceSave;

			//Log claim on client side
			diag_log format["Insurance: Attempting to claim using key %1...", _keyItem];
			format["Claiming insurance using key %1...", _keyItem] call dayz_rollingMessages;
			 
			closeDialog 0;
			dze_waiting = nil;
			PVDZE_veh_insurance = [_keyItem, getPlayerUID player]; //Send claim
			publicVariableServer "PVDZE_veh_insurance";

			waitUntil {!isNil "dze_waiting"};
			if (dze_waiting == "fail") then {
				{player addMagazine _x;} count _temp_removed_array_mag;
				{player addWeapon _x;} count _temp_removed_array_wep;
				format["Insurance claim for key %1 denied! (Already claimed?)"] call dayz_rollingMessages;
			} else {
				format["Insurance claim for key %1 approved!", _keyItem] call dayz_rollingMessages;
				["Working",0,[3,2,4,0]] call dayz_NutritionSystem;
			};
		} else {
			{player addMagazine _x;} count _temp_removed_array_mag;
			{player addWeapon _x;} count _temp_removed_array_wep;
			format[localize "str_epoch_player_145",_removed_total,_tobe_removed_total] call dayz_rollingMessages;
		};
	} else {
		_textMissing = getText(configFile >> "CfgMagazines" >> _missing >> "displayName");
		format[localize "STR_EPOCH_ACTIONS_6",_missingQty, _textMissing] call dayz_rollingMessages;

		systemchat localize "STR_CRAFTING_NEEDED_ITEMS";

		if (count _requirementsMagazine > 0) then {
			{
				_text = getText(configFile >> "CfgMagazines" >> (_x select 0) >> "displayName");
				systemchat format ["%2x %1",_text,(_x select 1)];
			} count _requirementsMagazine;
		};
	};
};
dayz_actionInProgress = false;
