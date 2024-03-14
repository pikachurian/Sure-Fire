triggered = false;
triggerID = 0;

reactiveObjects = [obj_door];

function Action()
{
	if(triggered == false)
	{
		triggered = true;
		image_alpha = 0.5;
		
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