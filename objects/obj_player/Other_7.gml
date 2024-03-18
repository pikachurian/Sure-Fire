switch(sprite_index)
{
	case chargingArrowSprite:
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
}