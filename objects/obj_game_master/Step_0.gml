//if(keyboard_check_pressed(vk_lalt))
	//game_restart();
	
if(keyboard_check_pressed(vk_f4))
	window_set_fullscreen(!window_get_fullscreen());
	
//if(keyboard_check_pressed(ord("L")))
	//LoadCheckPoint();
	
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
		switch(room)
		{
			case rm_title:
				//Victory reward.
				obj_land_shark.image_alpha = 0;
				if(obj_json.saveData.won == true)
					obj_land_shark.image_alpha = 1;
				
				//Credits show.
				obj_title.sprite_index = spr_title_with_credits;
				if(obj_json.saveData.player.grappleUnlocked == false)
					obj_title.sprite_index = spr_title;
				
				if(keyboard_check_pressed(ord("C")))
					obj_json.ClearSave();
				
				if(keyboard_check_pressed(vk_enter))
				{
					obj_json.LoadSave();
				
					//obj_player.x = 500;
					//obj_player.y = 1222;
					room_goto(obj_json.saveData.theRoom);
					show_debug_message(rm_start);
				}
				break;
				
			case rm_ending:
				with(obj_json)
				{
					saveData = Load(saveFileName);
					if(saveData.won == false)
						saveData.won = true;
					
					Save(saveData, saveFileName);
				}
					
				whiteScreenAlpha = min(whiteScreenAlpha + whiteScreenAlphaRate, 1);
				obj_camera.shakeStrength = lerp(0, endingScreenShakeMax, whiteScreenAlpha);
				if(whiteScreenAlpha >= 0.9)
				{
					room_goto(rm_title);
					whiteScreenAlpha = 0;
					obj_player.ChangeState(PS.main);
					obj_camera.shakeStrength = 0;
				}
				break;
		}
		break;
}

if(audio_get_name(songPlaying) == "sng_battle") && (AllEnemiesDead())
{
	audio_stop_sound(songPlaying);
	songPlaying = audio_play_sound(sng_lobby, 3, true);
}