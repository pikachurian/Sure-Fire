/*obj_json.saveData.checkPoint = checkPointData;
obj_json.saveData.player.grappleUnlocked = obj_player.grappleUnlocked;
obj_json.saveData.player.movableArrowUnlocked = obj_player.movableArrowUnlocked;
obj_json.saveData.player.hp = obj_player.hp;
obj_json.saveData.player.x = obj_player.x;
obj_json.saveData.player.y = obj_player.y;
obj_json.saveData.theRoom = room;

obj_json.Save(obj_json.saveData, obj_json.saveFileName);*/
//show_debug_message("ROOM" + string(room))
if(room != rm_setup_json) && (room != rm_title)
	obj_json.SaveSave();
	
/*if(instance_exists(checkPointData.inst))
{
	with(checkPointData.inst)
	{
		image_index = image_index - 1;
	}
}*/

if(!instance_exists(obj_enemy)) && (room != rm_tf_left_shaft) && (room != rm_tf_grapple_pickup) && (room != rm_tf_movable_pickup) && (room != rm_title)
{
	if(audio_get_name(songPlaying) != "sng_lobby")
	{
		audio_stop_sound(songPlaying);
		songPlaying = audio_play_sound(sng_lobby, 3, true);
	}
}else
{
	if(instance_exists(obj_enemy)) && (audio_get_name(songPlaying) != "sng_battle")
	{
		audio_stop_sound(songPlaying);
		songPlaying = audio_play_sound(sng_battle, 3, true);
	}else if(!instance_exists(obj_enemy))
	{
		audio_stop_sound(songPlaying);
	}else audio_stop_sound(songPlaying);
}

if(room == rm_title)
{
	audio_stop_all();
	songPlaying = audio_play_sound(sng_title, 10, true);
}