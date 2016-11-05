private "_myGroup";

_myGroup = group player;
{[_x] join grpNull;} count units _myGroup;
deleteGroup _myGroup;

systemChat "The group has been disbanded";