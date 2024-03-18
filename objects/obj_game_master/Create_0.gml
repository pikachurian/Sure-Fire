checkPointInst = noone;
checkPointX = 0;
checkPointY = 0;
checkPointRoom = noone;

function LoadCheckPoint()
{
	if(checkPointRoom != noone)
	{
		room_goto(checkPointRoom);
		obj_player.x = checkPointX;
		obj_player.y = checkPointY;
	}
}