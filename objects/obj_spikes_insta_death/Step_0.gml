if(place_meeting(x, y, obj_player))
{
	//Reset the player's position in the room.
	obj_player.x = obj_json.saveData.player.x;
	obj_player.y = obj_json.saveData.player.y;
}