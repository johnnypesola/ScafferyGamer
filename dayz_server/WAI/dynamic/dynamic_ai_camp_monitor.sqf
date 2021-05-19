private ["_bestPlaces","_safePos","_direction","_campId","_vehicleClass","_numUnits","_timeout"];

if (!isServer) exitWith { };
waitUntil {!isNil "WAIconfigloaded" && {WAIconfigloaded}};
// Activate after 150 seconds 

sleep 150;


ai_active_survivorcamps = 0;
ai_max_active_survivorcamps = 5;

_campId = 10000;
_timeout = 900;

_bestPlaces = [];
while { true } do {

	if (ai_active_survivorcamps < ai_max_active_survivorcamps) then {
		diag_log format["WAI: Looking for camp site from center %1.", getMarkerPos "center"];
		_safePos = [getMarkerPos "center",0,5000,10,0,1,0] call BIS_fnc_findSafePos;
		diag_log format["WAI: Found camp site place at %1.", _safePos];
		_bestPlaces = selectBestPlaces [_safePos, 100, "forest+trees-meadow-houses-(10*sea)", 5, 10];
		diag_log format["WAI: Selecting spot from the following spots: %1", _bestPlaces];
		
		if (count _bestPlaces > 0) then {
			_safePos = (_bestPlaces call BIS_fnc_selectRandom) select 0;
			diag_log format["WAI: Selected spot %1.", _safePos];
			_safePos = [ _safePos select 0, _safePos select 1, 0];
		};
		_direction = (random 360);

		_vehicleClass = [
			"GAZ_Vodnik_DZE",
			"GAZ_Vodnik_DZE",
			"GAZ_Vodnik_MedEvac",
			"GAZ_Vodnik_MedEvac",
			"GAZ_Vodnik_MedEvac",
			"HMMWV_DZ",
			"HMMWV_DZ",
			"HMMWV_DZ",
			"HMMWV_M1035_DES_EP1",
			"HMMWV_M1035_DES_EP1",
			"HMMWV_M1035_DES_EP1",
			"SUV_Camo",
			"SUV_Charcoal",
			"SUV_Green",
			"SUV_TK_CIV_EP1",
			"SUV_Yellow",
			"ArmoredSUV_PMC_DZE",
			"Kamaz",
			"M1030_US_DES_EP1",
			"MtvrRefuel_DES_EP1_DZ",
			"Offroad_DSHKM_Gue_DZE",
			"Offroad_DSHKM_Gue_DZE",
			"V3S_Open_TK_CIV_EP1",
			"V3S_Open_TK_EP1",
			"LandRover_CZ_EP1",
			"LandRover_MG_TK_EP1_DZE",
			"LandRover_Special_CZ_EP1_DZE",
			"LandRover_TK_CIV_EP1"
		] call BIS_fnc_selectRandom;

		_numUnits = floor (random 2) + 3;

		[_campId, _safePos, _direction, _vehicleClass, _numUnits, _timeout] spawn survivor_camp;
		_campId = (_campId + 1); // Increment it safely by 1. The camps are not expected to cycle through 2 billion respawns.
	};

	sleep 20;

};
