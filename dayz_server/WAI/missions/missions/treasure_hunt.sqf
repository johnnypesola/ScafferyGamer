private ["_position","_randompos","_box","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum"];

_position = [] call wai_find_pos;
diag_log format["WAI: Mission Treasure Started At %1",_position];
_box = createVehicle ["USOrdnanceBox",[(_position select 0),(_position select 1),-0.3], [], 0, "CAN_COLLIDE"]; // Lowering it 0.3 metres into the ground so it's a bit hidden
[_box] call spawn_treasure_box;

// Randomize marker position a bit
_randompos = [ ((_position select 0) + random 200 - 100), ((_position select 1) + random 200 - 100) ];

[_randompos,"Crate"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";
//[nil,nil,rTitleText,"Someone has lost a crate with possibly valuable content. See if you can find it!", "PLAIN",10] call RE;

_missiontimeout = true;
_cleanmission = false;
_playerPresent = false;
_starttime = floor(time);
while {_missiontimeout} do {
	sleep 5;
	_currenttime = floor(time);
	{if((isPlayer _x) AND (_x distance _position <= 150)) then {_playerPresent = true};}forEach playableUnits;
	if (_currenttime - _starttime >= wai_mission_timeout) then {_cleanmission = true;};
	if ((_playerPresent) OR (_cleanmission)) then {_missiontimeout = false;};
};
if (_playerPresent) then {
	waitUntil
	{
		sleep 5;
		_playerPresent = false;
		{if((isPlayer _x) AND (_x distance _position <= 30)) then {_playerPresent = true};}forEach playableUnits;
		(_playerPresent)
	};
	diag_log format["WAI: Mission Treasure Ended At %1",_position];
	//[nil,nil,rTitleText,"Survivors have secured the treasure!", "PLAIN",10] call RE;
} else {
	clean_running_hero_mission = True;
	deleteVehicle _box;
	
	diag_log format["WAI: Mission Treasure timed out At %1",_position];
	//[nil,nil,rTitleText,"Survivors did not secure the crate in time!", "PLAIN",10] call RE;
};

heromissionrunning = false;
