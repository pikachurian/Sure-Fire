if(place_meeting(x, y, obj_player))
{
	if(startX != -1)
		obj_player.x = startX;
		
	if(startY != -1)
		obj_player.y = startY;
		
	//RoomGotoTransition(nextRoom, transitionDir, 60);
	room_goto(nextRoom);
}
