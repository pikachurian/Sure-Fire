switch(sprite_index)
{
	case chargingArrowSprite:
	case jumpSprite:
		image_speed = 0;
		image_index = image_number - 1;
		break;
}

/*if(sprite_index == hurtSprite)
{
	sprite_index = idleSprite;
	UpdateSprite();
}else if(sprite_index == deadSprite)
{
	image_speed = 0;
	image_index = image_number - 1;
}*/

if(sprite_index == deadSprite)
{
	image_speed = 0;
	image_index = image_number - 1;
	ChangeState(PS.main);
	if(obj_game_master.checkPointData.theRoom != noone)
		obj_game_master.LoadCheckPoint();
	else
		obj_json.LoadSave();
	hp = hpMax;
}