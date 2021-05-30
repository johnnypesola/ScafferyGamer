//Let Zeds know
[player,4,true,(getPosATL player)] spawn player_alertZombies;

//display gui (temp hint)

waitUntil {alive player};

scaffery_toggle_showDebugMonitor = true;

while {true} do
{
	if (scaffery_toggle_showDebugMonitor) then {
		_kills = 		player getVariable["zombieKills",0];
		_killsH = 		player getVariable["humanKills",0];
		_killsB = 		player getVariable["banditKills",0];
		_humanity =		player getVariable["humanity",0];
		
		hintSilent parseText format ["
		<t size='1.25' font='Bitstream' align='center' color='#D60000'>DayZ Epoch</t><br/>
		<t size='1.15' font='Bitstream' align='center' color='#D60000'>scaffery.pesola.se</t><br/>
		<t size='1.0 'font='Bitstream' align='center' color='#D60000'>%1</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Players Online: </t><t size='0.95 'font='Bitstream' align='right'>%2</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='0.95' font='Bitstream' align='right'>%3</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='0.95' font='Bitstream' align='right'>%4</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Zombies Killed: </t><t size='0.95' font='Bitstream' align='right'>%5</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Humanity: </t><t size='0.95' font='Bitstream' align='right'>%6</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Blood: </t><t size='0.95' font='Bitstream' align='right'>%7</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='0.95' font='Bitstream' align='right'>%8</t><br/>",
		name player,(count playableUnits),_killsH,_killsB,_kills,round _humanity,r_player_blood,(round diag_fps)
		];
	};
	sleep 1;
	
};

/*
player createDiarySubject ["MyDiary","My Diary"];
player createDiaryRecord ["MyDiary",["Stats", "Zombies Killed: <execute expression='player getVariable['zombieKills', 0]'</execute>"]];
player createDiaryRecord ["MyDiary",["Stats", "Headshots: <execute expression='player getVariable['headShots', 0]'</execute>"]];
player createDiaryRecord ["MyDiary",["Stats", "Murders: <execute expression='player getVariable['humanKills', 0]'</execute>"]];
player createDiaryRecord ["MyDiary",["Stats", "Bandits Killed: <execute expression='player getVariable['banditKills', 0]'</execute>"]];
player createDiaryRecord ["MyDiary",["Stats", "Humanity: <execute expression='player getVariable['humanity', 0]'</execute>"]];
*/
