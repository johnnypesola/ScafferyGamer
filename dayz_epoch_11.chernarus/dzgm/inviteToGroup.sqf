if (player != leader group player) exitWith {systemChat "You are not the leader and can not invite people.";};

disableSerialization;

private ["_dialog","_playerListBox","_pTarget","_index","_playerData","_check","_hasInvite"];

_dialog = findDisplay 55510;
_playerListBox = _dialog displayCtrl 55511;
_index = lbCurSel _playerListBox;
_playerData = _playerListBox lbData _index;
_hasInvite = false;
_check = 0;
{
	if ((!isNull _x) && {isPlayer _x} && {str(_x) == _playerData}) exitWith {_pTarget = _x;_check = 1;};
} count playableUnits;

if (_check == 0) exitWith {systemChat "You must select someone to invite first.";};
if (_pTarget == player) exitWith {systemChat "You can not invite yourself.";};
if (count units group _pTarget > 1) exitWith {systemChat "This player is already in a group.";};

{if (_x select 1 == getPlayerUID _pTarget) then {_hasInvite = true;};} forEach currentInvites;
if (_hasInvite) exitWith {systemChat "This player already has a pending invite.";};
currentInvites set [count currentInvites,[getPlayerUID player,getPlayerUID _pTarget]];
publicVariableServer "currentInvites";

[nil,_pTarget,"loc", rTITLETEXT, format["You have received a group invite. Right click on radio to view."], "PLAIN", 0] call RE;

systemChat format["You have invited %1 to join the group",name _pTarget];
systemChat "Press left windows key to toggle group name tags";