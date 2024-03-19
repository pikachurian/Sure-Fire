if(keyboard_check_pressed(vk_lalt))
	game_restart();
	
if(keyboard_check_pressed(vk_f4))
	window_set_fullscreen(!window_get_fullscreen());
	
if(keyboard_check_pressed(ord("L")))
	LoadCheckPoint();
	
if(keyboard_check_pressed(ord("C")))
	obj_json.ClearSave();
	
switch(state)
{
	case GS.setup:
		room_goto_next();
		obj_json.LoadSave();
		ChangeState(GS.main);
		break;
}

if(audio_get_name(songPlaying) == "sng_battle") && (!instance_exists(obj_enemy))
{
	audio_stop_sound(songPlaying);
	songPlaying = audio_play_sound(sng_lobby, 3, true);
}