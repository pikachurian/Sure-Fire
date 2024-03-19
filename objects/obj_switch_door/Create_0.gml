event_inherited();

opened = false;
triggerID = 0;
image_speed = 0;
sprite_index = spr_switch_trigger_blue;
image_index = image_number - 1;

//maskIndex = mask_index;

function SetDoorColor(_isBlue)
{
	if(_isBlue)
	{
		sprite_index = spr_switch_trigger_blue;
		opened = false;
		image_index = image_number - 1;
		image_alpha = 1;
	}else
	{
		sprite_index = spr_switch_trigger_red;
		opened = true;
		image_index = 0;
		image_alpha = 0.25;
	}
}

function Reaction()
{
	if(opened == false)
	{
		//SetOpened(true);
		image_speed = -1;
	}else
	{
		//SetOpened(false);
		image_speed = 1;
	}
}