if(!isServer) exitWith {};

diag_log "WAI: Starting AI Missions Monitor";

markerready = true;
markerbanditready = true;
heromissionrunning = false;
banditmissionrunning = true;
_result = 1;

sleep (120);

while {true} do
{
	_cnt = {alive _x} count playableUnits;
	if(!heromissionrunning) then {_result = 1};
	if(!banditmissionrunning) then {_result = 1};
	
	if ((!heromissionrunning) && (_cnt >= 1)) then {
		if (markerready)  then
		{
			clean_running_hero_mission = False;
			_mission = wai_missions call BIS_fnc_selectRandom;
			execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_mission];
			heromissionrunning = true;
			diag_log format["WAI: Starting Hero mission %1",_mission];
			_result = 0;
		};
	};
	if ((!banditmissionrunning) && (_cnt >= 1)) then {
		if (markerbanditready) then 
		{
			clean_running_bandit_mission = False;
			_missionBandit = wai_missions_bandit call BIS_fnc_selectRandom;
			execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_missionBandit];
			banditmissionrunning = true;
			diag_log format["WAI: Starting Bandit mission %1", _missionBandit];
			_result = 0;

		};
	};
	if ((_result == 0) || (_cnt < 1)) then
	{
		sleep 60;
	};    
};
