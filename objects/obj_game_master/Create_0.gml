creationRoom = room;
songPlaying = noone;

checkPointData = 
{
	inst : noone,
	x : 0,
	y : 0,
	theRoom : noone
}

//Game State.
enum GS 
{
	setup,
	main
}

state = GS.setup;

//Ending.
whiteScreenAlpha = 0;
whiteScreenAlphaRate = 0.0012;

endingScreenShakeMax = 100;



function LoadCheckPoint()
{
	if(checkPointData.theRoom != noone)
	{
		room_goto(checkPointData.theRoom);
		obj_player.x = checkPointData.x;
		obj_player.y = checkPointData.y;
	}
}

function LoadSaveStruct(_struct)
{
	checkPointData = _struct;
}

function ChangeState(_state)
{
	state = _state;
}
