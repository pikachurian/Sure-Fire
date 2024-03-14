event_inherited();

opened = false;
triggerID = 0;
image_speed = 0;

//maskIndex = mask_index;

function Reaction()
{
	if(opened == false)
	{
		SetOpened(true);
	}else
	{
		SetOpened(false);
	}
}