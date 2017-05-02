/****************************************************************
 * Player and vehicle travel
 * By Pastorn 2016
 ****************************************************************/
player_travelMenu = [
	["", true],
	["Napf", [],"",-5,[["expression","[player, vehicle player,""napf""] execVM ""travel\player_travel.sqf"""]], "1", "1"]
];

showCommandingMenu "#USER:player_travelMenu";
