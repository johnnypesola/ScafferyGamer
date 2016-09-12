private ["_target", "_pos", "_posASL", "_name", "_side", "_damage"];
//Malory's point to repair script
_target = cursorTarget;
_name = typeOf _target;
_pos = getPosATL _target;
_posASL = getPosASL _target;
_side = side _target;
_damage = damage _target;
cutText [format["%1 : ATL: %2, ASL %3, Side: %4, Damage: %5%6", _name, _pos, _posASL, _side, floor(_damage*100), "%"], "PLAIN DOWN"];
