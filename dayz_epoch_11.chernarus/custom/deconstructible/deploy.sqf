if (false) then {
    cutText [format["You are in combat and cannot build a bike."], "PLAIN DOWN"];
} else {
    player removeAction s_player_deploybike;
    closeDialog 602;
    player removeWeapon "ItemToolbox";
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
    _object = "Old_bike_TK_INS_EP1" createVehicle (position player);
    _object setVariable ["ObjectID", "1", true];
    _object setVariable ["ObjectUID", "1", true];
    player reveal _object;
    cutText [format["You've used your toolbox to build a bike."], "PLAIN DOWN"];
    sleep 10;
    cutText [format["Warning: Spawned bikes DO NOT SAVE after server restart!"], "PLAIN DOWN"];
} else {
    r_interrupt = false;
    player switchMove "";
    player playActionNow "stop";
    player addWeapon "ItemToolbox";
    cutText ["Building cancelled!", "PLAIN DOWN"];
    };
};

