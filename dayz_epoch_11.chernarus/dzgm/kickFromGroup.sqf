disableSerialization;

private ["_dialog","_pTarget","_index","_playerData","_check"];

_dialog = findDisplay 55510;
_groupListBox = _dialog displayCtrl 55512;
_index = lbCurSel _groupListBox;
_playerData = _groupListBox lbData _index;
_check = 0;
{
	if ((!isNull _x) && {isPlayer _x} && {str(_x) == _playerData}) exitWith {_pTarget = _x;_check = 1;};
} count playableUnits;

if (_pTarget == player) exitWith {systemChat "You can not kick yourself";};
if (_check == 0) exitWith {systemChat "You must select someone to kick first";};
[_pTarget] join grpNull;

systemChat format["You have kicked %1 from the group",name _pTarget];