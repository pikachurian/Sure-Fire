/*obj_json.saveData.checkPoint = checkPointData;
obj_json.saveData.player.grappleUnlocked = obj_player.grappleUnlocked;
obj_json.saveData.player.movableArrowUnlocked = obj_player.movableArrowUnlocked;
obj_json.saveData.player.hp = obj_player.hp;
obj_json.saveData.player.x = obj_player.x;
obj_json.saveData.player.y = obj_player.y;
obj_json.saveData.theRoom = room;

obj_json.Save(obj_json.saveData, obj_json.saveFileName);*/
//show_debug_message("ROOM" + string(room))

//Saving.
if(room != rm_setup_json) && (room != rm_title) && (room != rm_ending) && (room != rm_click_to_start)
	obj_json.SaveSave();
	

//Music logic.
if(AllEnemiesDead()) 
&& (room != rm_tf_left_shaft) 
&& (room != rm_tf_grapple_pickup) 
&& (room != rm_tf_movable_pickup) 
&& (room != rm_title) 
&& (room != rm_ending) 
&& (room != rm_click_to_start)
{
	if(audio_get_name(songPlaying) != "sng_lobby")
	{
		audio_stop_sound(songPlaying);
		songPlaying = audio_play_sound(sng_lobby, 3, true);
	}
}else
{
	if(AllEnemiesDead() == false) && (audio_get_name(songPlaying) != "sng_battle")
	{
		audio_stop_sound(songPlaying);
		songPlaying = audio_play_sound(sng_battle, 3, true);
	}else if(AllEnemiesDead() == false)
	{
		//audio_stop_sound(songPlaying);
	}else audio_stop_sound(songPlaying);
}

switch(room)
{
	case rm_title:
		audio_stop_all();
		songPlaying = audio_play_sound(sng_title, 10, true);
		break;
		
	case rm_ending:
		obj_player.ChangeState(PS.pause);
		obj_player.image_xscale = 1;
		obj_player.sprite_index = obj_player.idleSprite;
		obj_player.MoveAndSlide();
		break;
}

/*if(room == rm_title)
{
	audio_stop_all();
	songPlaying = audio_play_sound(sng_title, 10, true);
}*/