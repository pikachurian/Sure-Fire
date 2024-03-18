triggered = false;
triggerID = 0;

reactiveObjects = [obj_door];
image_index = image_number - 1;
image_speed = 0;

function Action()
{
	if(triggered == false)
	{
		triggered = true;
		image_alpha = 0.5;
		image_speed = 1;
		image_index = 0;
		
		for(var _i = 0; _i < array_length(reactiveObjects); _i ++)
		{
			with(reactiveObjects[_i])
			{
				if(triggerID == other.triggerID)
				{
					Reaction();
				}
			}
		}
	}
}