event_inherited();

rotateSpd = 1.5;//1;
spd = 10;

function Turn(_inputAxis)
{
	var _newDir = dir + (_inputAxis * rotateSpd);
	SetDirection(_newDir);
}