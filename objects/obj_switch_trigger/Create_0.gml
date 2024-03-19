triggered = false;
triggerID = 0;

reactiveObjects = [obj_switch_door];
blueSprite = spr_switch_trigger_blue;
redSprite = spr_switch_trigger_red;
sprite_index = blueSprite;
image_speed = 0;
image_index = image_number - 1;


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
	
	/*if(sprite_index == blueSprite)
		sprite_index = redSprite
	else
		sprite_index = blueSprite
		
	image_speed = 1;
	image_index = 0;*/
	
	//Activate reactive objects.
	for(var _i = 0; _i < array_length(reactiveObjects); _i ++)
	{
		with(reactiveObjects[_i])
		{
			Reaction();
		}
	}
	
	//Flip all targets' color.
	with(obj_switch_trigger)
	{
		if(sprite_index == blueSprite)
			sprite_index = redSprite
		else
			sprite_index = blueSprite
		
		image_speed = 1;
		image_index = 0;
	}
}