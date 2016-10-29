/* Maintain Area - written by Skaronator */
private ["_player","_name","_ObjArray","_uniqueID","_objects","_key","_query"];
_player = _this select 0;
_option = _this select 1;
/*
1: PVDZE_maintainArea = [player,1,_target];
2: PVDZE_maintainArea = [player,2,_object];
*/
_targetObj = _this select 2;

if (_option == 1) then {
	_objects = nearestObjects [_targetObj, DZE_maintainClasses, DZE_maintainRange];
	{
		if (damage _x >= DZE_DamageBeforeMaint) then {
			_objectID = _x getVariable ["ObjectID","0"];
			if (_objectID == "0") then {
				_objectUID = _x getVariable ["ObjectUID","0"];
				if (_objectUID != "0") then {
					_x setDamage 0;

					_key = [_objectUID];
					_query = ["datestampObjectUpdateByUID", _key] call dayz_prepareDataForDB;
					_query call server_hiveWrite;
				};
			} else {
				_x setDamage 0;

				_key = [_objectID];
				_query = ["datestampObjectUpdateByID", _key] call dayz_prepareDataForDB;
				_query call server_hiveWrite;
			};
		};
	} count _objects;
	_name = if (alive _player) then { name _player; } else { "Dead Player"; };
	diag_log format ["MAINTAIN AREA BY %1 - %2 Objects at %3", _name, count _objects, (getPosATL _player)];
};
if (_option == 2) then {
	if (damage _targetObj >= DZE_DamageBeforeMaint) then {
		_objectID = _targetObj getVariable ["ObjectID","0"];
		if (_objectID == "0") then {
			_objectUID = _targetObj getVariable ["ObjectUID","0"];
			if (_objectUID != "0") then {
				_targetObj setDamage 0;

				_key = [_objectUID];
				_query = ["datestampObjectUpdateByUID", _key] call dayz_prepareDataForDB;
				_query call server_hiveWrite;
			};
		} else {
			_targetObj setDamage 0;

			_key = [_objectID];
			_query = ["datestampObjectUpdateByID", _key] call dayz_prepareDataForDB;
			_query call server_hiveWrite;
		};
	};
};
