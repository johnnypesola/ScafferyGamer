private ["_unitGroup","_postition","_wp"];
_unitGroup = _this select 0;
_position = _this select 1;

_wp = _unitGroup addWaypoint [_position, 1];
_wp setWaypointType "SAD";
_wp setWaypointCompletionRadius 2;
