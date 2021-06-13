if(!isServer) exitWith {};
private ["_dot","_position","_Marker","_name"];
_position = _this select 0;
_name = _this select 1;

_Marker = "";
_dot = "";
insurancemarkerready = false;
while {insurancemissionrunning} do {
	_Marker = createMarker ["InsuranceMission", _position];
	_Marker setMarkerColor "ColorBlue";
	_Marker setMarkerShape "ELLIPSE";
	_Marker setMarkerBrush "Grid";
	_Marker setMarkerSize [200,200];
	_Marker setMarkerText _name;
	_dot = createMarker ["dot3", _position];
	_dot setMarkerColor "ColorBlack";
	_dot setMarkerType "mil_dot";
	_dot setMarkerText _name;
	sleep 30;
	deleteMarker _Marker;
	deleteMarker _dot;
};
if (_Marker == "InsuranceMission") then {
	deleteMarker _Marker;
	deleteMarker _dot;
};
insurancemarkerready = true;
