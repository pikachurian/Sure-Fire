opened = false;
triggerID = 0;

//maskIndex = mask_index;

function Reaction()
{
	if(opened == false)
	{
		opened = true;
		image_alpha = 0.5;
		solid = false;
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