/*
	Adds a marker for Major Missions. Only runs once.
	OKMarkerLoop.sqf keeps this marker updated.
	Usage: [coordinates,missionname]
*/
private["_nul","_nil","_daytime","_hour","_minute"];
OKMajCoords = _this select 0;
OKMajName = _this select 1;

_hour = floor daytime; 
_minute = floor ((daytime - _hour) * 60);
if (_minute < 10) then 
        {_daytime = format [" %1:0%2",_hour,_minute]}
    else
        {_daytime = format [" %1:%2",_hour,_minute]};
OKMajName = OKMajName + _daytime;

_nul = createMarker ["OKMajMarker", OKMajCoords];
"OKMajMarker" setMarkerColor "ColorYellow";
"OKMajMarker" setMarkerShape "ELLIPSE";
"OKMajMarker" setMarkerBrush "Grid";
"OKMajMarker" setMarkerSize [175,175];
_nil = createMarker ["OKMajDot", OKMajCoords];
"OKMajDot" setMarkerColor "ColorBlack";
"OKMajDot" setMarkerType "mil_dot";
"OKMajDot" setMarkerText OKMajName;
