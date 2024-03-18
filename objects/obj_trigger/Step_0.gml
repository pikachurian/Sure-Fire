
for(var _i = 0; _i < instance_number(obj_basic_arrow); _i ++)
{
	with(instance_find(obj_basic_arrow, _i))
	{
		/*
		var _arrow = instance_place(x, y, obj_basic_arrow);

		if(_arrow != noone) && (_arrow.active == true)
		{
			Action();
			_arrow.Destroy();
			var _dir = point_direction(_arrow.x, _arrow.y, x, y);
			_arrow.image_angle = _dir;
			_arrow.x += lengthdir_x(_arrow.sprite_width / 2, _dir);
			_arrow.y += lengthdir_y(_arrow.sprite_width / 2, _dir);
			obj_camera.shakeStrength = 12;
			//_arrow.x = x - _arrow.sprite_width;
			//_arrow.y = y + image_angle;
		}*/
		if(active == true) && (place_meeting(x, y, other))
		{
			other.Action(id);
			Destroy();
			var _dir = point_direction(x, y, other.x, other.y);
			image_angle = _dir;
			x += lengthdir_x(sprite_width / 2, _dir);
			y += lengthdir_y(sprite_width / 2, _dir);
			obj_camera.shakeStrength = 12;
			break;
		}
	}
}

for(var _i = 0; _i < instance_number(obj_movable_arrow); _i ++)
{
	/*
	if(_arrow != noone) && (_arrow.active == true)
	{
		Action();
		_arrow.Destroy();
		var _dir = point_direction(_arrow.x, _arrow.y, x, y);
		_arrow.image_angle = _dir;
		_arrow.x += lengthdir_x(_arrow.sprite_width / 2, _dir);
		_arrow.y += lengthdir_y(_arrow.sprite_width / 2, _dir);
		obj_camera.shakeStrength = 12;
	}*/
	with(instance_find(obj_movable_arrow, _i))
	{
		if(active == true) && (place_meeting(x, y, other))
		{
			other.Action(id);
			Destroy();
			var _dir = point_direction(x, y, other.x, other.y);
			image_angle = _dir;
			x += lengthdir_x(sprite_width / 2, _dir);
			y += lengthdir_y(sprite_width / 2, _dir);
			obj_camera.shakeStrength = 12;
			break;
		}
	}
}