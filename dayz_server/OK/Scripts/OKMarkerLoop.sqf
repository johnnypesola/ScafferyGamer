/*
	Based on Marker Resetter by Vampire
	Marker Resetter checks if a Mission is running and resets the marker for JIPs
*/
private["_run","_nul","_nil"];

diag_log format ["[OK]: Mission Marker Loop for JIPs Starting!"];

//Lets start the timer
_run = true;
while {_run} do
{
	sleep 25; //Sleep 25 seconds
	//If the marker exists (meaning the mission is active) lets delete it and re-add it
	if (!(getMarkerColor "OKMajMarker" == "")) then {
		deleteMarker "OKMajMarker";
		deleteMarker "OKMajDot";
		//Re-Add the markers
		_nul = createMarker ["OKMajMarker", OKMajCoords];
		"OKMajMarker" setMarkerColor "ColorGreen";
		"OKMajMarker" setMarkerShape "ELLIPSE";
		"OKMajMarker" setMarkerBrush "Grid";
		"OKMajMarker" setMarkerSize [175,175];
		_zap = createMarker ["OKMajDot", OKMajCoords];
		"OKMajDot" setMarkerColor "ColorBlack";
		"OKMajDot" setMarkerType "mil_dot";
		"OKMajDot" setMarkerText OKMajName;
	};
	//Now we wait another 25 seconds
};