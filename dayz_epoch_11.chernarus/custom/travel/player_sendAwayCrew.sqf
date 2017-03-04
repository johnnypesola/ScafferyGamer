/****************************************************************
 * Player and vehicle travel
 * By Pastorn 2016
 ****************************************************************/

private["_initiator","_board","_dest","_inst"];

_initiator = PV_travel_boardFerry select 0;
_board = PV_travel_boardFerry select 1;
_dest = PV_travel_boardFerry select 2;

_inst = 11;	// Default is chernarus

switch (_dest) do {
	case "chernarus": 	{ _inst = 11; };
	case "napf": 		{ _inst = 24; };
	case "namalsk": 	{ _inst = 15; };
};

if (!_board) then {

	if (_initiator) then {
		cutText ["You already have a vehicle in transit. Who do you think you are, the universal exports CEO? Get lost.","PLAIN"];
	};

} else {

	cutText ["Ferry called for transport to " + _dest + "! Please log onto destination server " + _dest + " to receive your transported vehicle.", "PLAIN DOWN"];
	endMission "END1";
};
