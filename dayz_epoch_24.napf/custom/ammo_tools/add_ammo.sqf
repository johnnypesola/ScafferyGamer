Private ["_argv","_target","_ammoTypeToLoad","_qty","_paymentType","_cost","_numItems","_dis","_sfx","_finished","_finishedTime","_object"];
if (false) then {
	cutText [format["You are in combat and cannot add ammo."], "PLAIN DOWN"];
} else {
	_argv = _this select 3;
	_target = _argv select 0;
	_ammoTypeToLoad = _argv select 1;
	_qty = _argv select 2;
	_paymentType = _argv select 3;
	_cost = _argv select 4;
	_slot = _argv select 5;

	_numItems = { _x == _paymentType } count magazines player;

	if (_numItems >= _cost ) then {

		player removeAction s_player_addAmmoOption;
		closeDialog 602;
		for [{_n=0},{_n<_cost},{_n=_n+1}] do { player removeMagazine _paymentType; };
		player playActionNow "Medic";
		_dis=10;
		_sfx = "repair";
		[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
		[player,_dis,true,(getPosATL player)] spawn player_alertZombies;

		r_interrupt = false;
		r_doLoop = true;
		_finished = false;
		_finishedTime = diag_tickTime +8;

		while { r_doLoop } do {
			if (diag_tickTime >= _finishedTime) then {
				r_doLoop = false;
				_finished = true;
			};
			if (r_interrupt) then {
				r_doLoop = false;
			};
			sleep 0.1;
		};
		if (_finished) then {
			for [{_n=0},{_n<_qty},{_n=_n+1}] do { 
				_target addMagazineTurret [_ammoTypeToLoad,[-1]]; 
			};
			cutText [format["You've reloaded the vehicle gun with %1.", getText (configFile >> "CfgMagazines" >> _ammoTypeToLoad >> "displayName")], "PLAIN DOWN"];
			sleep 10;
		} else {
			r_interrupt = false;
			player switchMove "";
			for [{_n=0},{_n<_cost},{_n=_n+1}] do { player addMagazine _paymentType; };
			player playActionNow "stop";
			cutText ["Building cancelled!", "PLAIN DOWN"];
		};

	} else {
		cutText [format["You need %1 more of %2 to reload the vehicle gun.", (_cost - _numItems), getText (configFile >> "CfgMagazines" >> _paymentType >> "displayName")], "PLAIN DOWN"];
	};
};

