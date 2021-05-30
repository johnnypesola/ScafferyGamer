/*
	Get object info
	Pastorn - 04/16/2017
*/
private ["_cursorTarget","_classname","_pos","_dir","_vect","_objectID","_charID"];

_cursorTarget = cursorTarget;

if (isNil "_cursorTarget") exitWith {};
_objectID = _cursorTarget getVariable ["ObjectID", "None"];
_charID = _cursorTarget getVariable ["CharacterID", "None"];
_classname = typeOf _cursorTarget;
_pos = getPos _cursorTarget;
_dir = getDir _cursorTarget;
_vect = [vectorDir _cursorTarget, vectorUp _cursorTarget];
format["Object %1, class: ""%2"", pos: %3, dir: %4, vect: %5", _cursorTarget, _classname, _pos, _dir, _vect] call dayz_rollingMessages;

