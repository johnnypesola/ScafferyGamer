if (getText(configFile >> "CfgMods" >> "DayZ" >> "dir") == "@DayZ_Epoch") then {
	waitUntil {uiSleep .25;(!isNil "PVDZE_plr_LoginRecord")};
} else {
	waitUntil {uiSleep .25;(!isNil "PVDZ_plr_LoginRecord")};
};

_loginGroup = group player;
if (count units _loginGroup > 1) then {[player] join grpNull;deleteGroup _loginGroup;};
{
	if ((!isNull _x) && {(_x getVariable["bodyUID","0"]) == (getPlayerUID player)}) then {
		_bodyGroup = _x getVariable["bodyGroup",grpNull];
		if (({alive _x} count units _bodyGroup) > 0) then {[player] join _bodyGroup;deleteGroup _loginGroup;};
	};
} count allDead;
//#include "\ca\editor\Data\Scripts\dikCodes.h"
//keyboard_keys set [DIK_LWIN,{if (tagName) then {tagName = false;titleText ["\n\nGroup name tags OFF","PLAIN DOWN"];titleFadeOut 4;} else {tagName = true;titleText ["\n\nGroup name tags ON","PLAIN DOWN"];titleFadeOut 4;};_handled = true;}];
//keyboard_keys set [(actionKeys "TacticalView") select 0,{_handled = true;}];
//keyboard_keys set [DIK_RWIN,{if (dialog) then {closeDialog 0;groupManagementActive = false;} else {execVM "dzgm\loadGroupManagement.sqf";};_handled = true;}];

acceptGroupInvite = compile preprocessFileLineNumbers "dzgm\acceptGroupInvite.sqf";
declineGroupInvite = compile preprocessFileLineNumbers "dzgm\declineGroupInvite.sqf";
disbandGroup = compile preprocessFileLineNumbers "dzgm\disbandGroup.sqf";
inviteToGroup = compile preprocessFileLineNumbers "dzgm\inviteToGroup.sqf";
kickFromGroup = compile preprocessFileLineNumbers "dzgm\kickFromGroup.sqf";
leaveGroup = compile preprocessFileLineNumbers "dzgm\leaveGroup.sqf";
mapLoop = compile preprocessFileLineNumbers "dzgm\mapLoop.sqf";
playerSelectChange = compile preprocessFileLineNumbers "dzgm\playerSelectChange.sqf";
updatePlayerList = compile preprocessFileLineNumbers "dzgm\updatePlayerList.sqf";
tagName = true;
	
if (isNil "dzgmInit") then {call compile preprocessFileLineNumbers "dzgm\icons.sqf";};
uiSleep 1;
[] spawn dzgmInit;
[] spawn mapLoop;
systemChat "Right click on radio or press RSHIFT to open group management";
