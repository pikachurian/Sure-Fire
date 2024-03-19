if(place_meeting(x, y, obj_player)) && (isCollected == false)
{
	isCollected = true;
	songID = audio_play_sound(sng_pickup, 20, false);
	obj_player.ChangeState(PS.pause);
	Collected();
}

if(audio_is_playing(songID) == false) && (songID != noone)
{
	songID = noone;
	obj_player.ChangeState(PS.main);
	//obj_json.SaveSave();
}

if(isCollected == false)
{
	y = startY + sin(tick / 10) * 25;
}

tick += 1;