private ["_player","_entity","_entities","_exitLoop"];

_player = player;
if (player getVariable["combattimeout",0] >= diag_tickTime) exitWith {"You are in combat." call dayz_rollingMessages;};

// Request server to pull out my corpse
PV_pullOutCorpse = [_player];
publicVariableServer "PV_pullOutCorpse";
