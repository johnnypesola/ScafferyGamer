if (false) then {
// player is in combat and cant pack his bike
    cutText [format["You are in combat and cannot re-pack your bike."], "PLAIN DOWN"];
} else {
    if (typeOf cursorTarget == "Old_bike_TK_INS_EP1" || typeOf cursorTarget == "Old_bike_TK_CIV_EP1") then {
    // player is looking at a bike and the target has a bike classname
    // delete it first to avoid player changing to another target
        deletevehicle cursorTarget;
        player removeAction s_player_deploybike2;
        player playActionNow "Medic";
        r_interrupt = false;
        player addWeapon "ItemToolbox";      
        _dis=10;
        _sfx = "repair";
        [player,_sfx,0,false,_dis] call dayz_zombieSpeak;
        [player,_dis,true,(getPosATL player)] spawn player_alertZombies;
        sleep 6;
        cutText [format["You have packed your bike and been given back your toolbox"], "PLAIN DOWN"];
        r_interrupt = false;
        player switchMove "";
        player playActionNow "stop";
    } else {
        // player is not looking at a bike, or target does not have a bike classname
        cutText [format["You have to be facing your bike to re-pack it!"], "PLAIN DOWN"];
    };
};

