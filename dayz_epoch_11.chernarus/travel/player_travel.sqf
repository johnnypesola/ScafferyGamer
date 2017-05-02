/****************************************************************
 * Player and vehicle travel
 * By Pastorn 2016
 ****************************************************************/

private["_caller", "_veh", "_dest","_inst","_worldspace","_doNotGenerateKey","_keyID","_timeout"];

_caller = _this select 0;
_veh = _this select 1;
_dest = _this select 2;

_inst = 11;	// Default is chernarus

switch (_dest) do {
	case "chernarus": 	{ _inst = 11; };
	case "napf": 		{ _inst = 24; };
	case "namalsk": 	{ _inst = 15; };
};

_doNotGenerateKey = true;
_keyID = _veh getVariable ["CharacterID", "0"];
_worldspace = [direction _veh, getPos _veh];

PV_travel_boardFerry = [true, false, ""];
PV_travel_transportVeh = [_veh, typeOf _veh, _worldspace, _doNotGenerateKey, _keyID, _caller, _inst];
publicVariableServer "PV_travel_transportVeh";

_timeout = time + 10;
waitUntil { time > _timeout };
if (!(PV_travel_boardFerry select 1)) then {
	diag_log "FERRY: Call ferry failed!";
} else {
	diag_log "FERRY: Timeout, PUBLISH board ferry status has not been received!";
};
