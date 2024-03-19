if(keyboard_check_pressed(vk_lalt))
	game_restart();
	
if(keyboard_check_pressed(vk_f4))
	window_set_fullscreen(!window_get_fullscreen());
	
if(keyboard_check_pressed(ord("L")))
	LoadCheckPoint();
	
/*if(keyboard_check_pressed(ord("C")))
	obj_json.ClearSave();*/
	
switch(state)
{
	case GS.setup:
		room_goto_next();
		obj_json.saveData = obj_json.Load(obj_json.saveFileName);
		ChangeState(GS.main);
		
		break;
		
	case GS.main:
		if(room == rm_title)
		{
			obj_land_shark.image_alpha = 0;
			if(obj_json.saveData.won == true)
				obj_land_shark.image_alpha = 1;
			if(keyboard_check_pressed(ord("C")))
				obj_json.ClearSave();
				
			if(keyboard_check_pressed(vk_enter))
			{
				room_goto(rm_start);
				
				obj_player.x = 800;
				obj_player.y = 1376;
			}
		}
		break;
}

if(audio_get_name(songPlaying) == "sng_battle") && (!instance_exists(obj_enemy))
{
	audio_stop_sound(songPlaying);
	songPlaying = audio_play_sound(sng_lobby, 3, true);
}