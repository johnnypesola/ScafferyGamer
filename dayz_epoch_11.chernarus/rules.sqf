private ["_messages","_timeout"];

_messages = [
	["DayZ Epoch", "Welcome "+(name player)],
	["World", worldName],
	["Teamspeak", "TBA"],
	["Website/Forums", "http://scaffery.pesola.se"],
	["Server Rules", "Duping, glitching or using any<br />exploit will result in a<br />permanent ban."],
	["Server Rules", "No talking in side."],
	["Server Rules", "Hackers will be banned permanently<br />Respect others"],
	["News", "Scaffery Servers 1.0.6.1 are up!<br />Please visit or travel also<br />to Scaffery Napf Server ;-)<br />"],
	["Tips", "Press F3 to adjust view distance.<br />Press F5 to create/join group.<br />Press F6 to disable DebugMonitor.<br />"]
];
 
_timeout = 5;
{
	private ["_title","_content","_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.40' color='#a81e13' align='right' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.60' color='#FFFFFF' align='right'>%2</t>"), _title, _content];
	[
		_titleText,
		[safezoneX + safezoneW - 0.8,0.50],     //DEFAULT: 0.5,0.35
		[safezoneY + safezoneH - 0.8,0.7],      //DEFAULT: 0.8,0.7
		_timeout,
		0.5
	] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.1);
} forEach _messages;
