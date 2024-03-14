triggered = false;
triggerID = 0;
image_speed = 0;

reactiveObjects = [obj_switch_door];

function Action()
{
	//Check if any objects are blocking a reactive object.
	for(var _i = 0; _i < array_length(reactiveObjects); _i ++)
	{
		with(reactiveObjects[_i])
		{
			if(place_meeting(x, y, obj_actor)) || (place_meeting(x, y, obj_bullet))
				return false;
		}
	}
	
	if(image_index == 1)
		image_index = 0;
	else
		image_index = 1;
	
	//Activate reactive objects.
	for(var _i = 0; _i < array_length(reactiveObjects); _i ++)
	{
		with(reactiveObjects[_i])
		{
			Reaction();
		}
	}
}