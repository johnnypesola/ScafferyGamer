if(!isServer) exitWith {};

diag_log "WAI: Starting AI Missions Monitor";

heromarkerready = true;
banditmarkerready = true;
insurancemarkerready = true;
heromissionrunning = false;
banditmissionrunning = false;
insurancemissionrunning = false;
insurancemissions = [];
_result = 1;

sleep (60);

while {true} do
{
	_cnt = {alive _x} count playableUnits;
	if(!heromissionrunning) then {_result = 1};
	if(!banditmissionrunning) then {_result = 1};
	if(!insurancemissionrunning) then {_result = 1};
	
	if ((!heromissionrunning) && (_cnt >= 1)) then {
		if (heromarkerready)  then
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
		if (banditmarkerready) then 
		{
			clean_running_bandit_mission = False;
			_missionBandit = wai_missions_bandit call BIS_fnc_selectRandom;
			execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_missionBandit];
			banditmissionrunning = true;
			diag_log format["WAI: Starting Bandit mission %1", _missionBandit];
			_result = 0;

		};
	};
	if ((!insurancemissionrunning) && (count insurancemissions > 0) && (_cnt >= 1)) then {
		if (insurancemarkerready) then 
		{
			clean_running_insurance_mission = False;
			_missionParams = insurancemissions select 0;
			_tmpArr = [];
			{
				if (!([_missionParams, insurancemissions select _forEachIndex] call BIS_fnc_areEqual)) then {
					_tmpArr = _tmpArr + (insurancemissions select _forEachIndex);
				};
			} forEach insurancemissions;
			_missionInsurance = wai_missions_insurance call BIS_fnc_selectRandom;
			insurancemissions = _tmpArr;
			_missionParams execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_missionInsurance];
			insurancemissionrunning = true;
			diag_log format["WAI: Starting Insurance mission %1", _missionInsurance];
			_result = 0;

		};
	};

	if ((_result == 0) || (_cnt < 1)) then
	{
		sleep 60;
	} else {
		sleep 3;
	};
};
