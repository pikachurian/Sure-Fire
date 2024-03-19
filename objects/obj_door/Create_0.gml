opened = false;
triggerID = 0;
image_speed = 0;

//maskIndex = mask_index;

function Reaction()
{
	if(opened == false) && (image_speed == 0)
	{
		//opened = true;
		//image_alpha = 0.5;
		//solid = false;
		
		image_speed = 1;
		//mask_index = spr_empty;
	}
}

function SetOpened(_openedState)
{
	opened = _openedState;
	if(opened == true)
	{
		image_alpha = 0.5;
		solid = false;
	}
	else
	{
		image_alpha = 1;
		solid = true;
	}
}