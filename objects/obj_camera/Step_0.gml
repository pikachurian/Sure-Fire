if(instance_exists(target))
{
	var _targetX = x;
	var _targetY = y;
	
	if(target == obj_player)
	{
		var _length = 0;//point_distance(target.x, target.y, mouse_x, mouse_y) * 0.25;
		var _direction = 0;//point_direction(target.x, target.y, mouse_x, mouse_y);
		
		if(obj_player.dir == -1)
			_direction = 180;
		
		_targetX = target.x + lengthdir_x(_length, _direction);
		_targetY = target.y + lengthdir_y(_length, _direction);
		
		_targetX -= viewWidth / 2;
		_targetY -= viewHeight / 2;
	}else
	{		
		_targetX = target.x - viewWidth / 2;
		_targetY = target.y - viewHeight / 2;
	}
	
	x = lerp(x, _targetX, 0.2);
	y = lerp(y, _targetY, 0.2);
	
}

//Zoom.
var _alpha = 0.2;

var _newWidth = lerp(viewWidth, zoom * defaultViewWidth, _alpha);
var _newHeight = lerp(viewHeight, zoom * defaultViewHeight, _alpha);

camera_set_view_size(cam, _newWidth, _newHeight);

x = lerp(x, x + (viewWidth - zoom * defaultViewWidth) / 2, _alpha);
y = lerp(y, y + (viewHeight - zoom * defaultViewHeight) / 2, _alpha);

viewWidth = _newWidth;
viewHeight = _newHeight;

//zoom -= 0.001

//Clamp position.
x = clamp(x, 0, room_width - viewWidth);
y = clamp(y, 0, room_height - viewHeight);

//Screen shake.
x += random_range(-shakeStrength, shakeStrength);
y += random_range(-shakeStrength, shakeStrength);

shakeStrength *= shakeDecay;

x = round(x);
y = round(y);
	
camera_set_view_pos(view_camera[0], x, y);
