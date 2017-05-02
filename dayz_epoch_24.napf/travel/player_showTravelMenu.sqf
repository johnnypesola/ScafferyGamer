/****************************************************************
 * Player and vehicle travel
 * By Pastorn 2016
 ****************************************************************/
player_travelMenu = [
	["", true],
	["Chernarus", [],"",-5,[["expression","[player, vehicle player,""chernarus""] execVM ""travel\player_travel.sqf"""]], "1", "1"]
];

showCommandingMenu "#USER:player_travelMenu";
