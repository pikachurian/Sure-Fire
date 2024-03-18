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
}

_arrow = instance_place(x, y, obj_movable_arrow);

if(_arrow != noone) && (_arrow.active == true)
{
	Action();
	_arrow.Destroy();
	var _dir = point_direction(_arrow.x, _arrow.y, x, y);
	_arrow.image_angle = _dir;
	_arrow.x += lengthdir_x(_arrow.sprite_width / 2, _dir);
	_arrow.y += lengthdir_y(_arrow.sprite_width / 2, _dir);
	obj_camera.shakeStrength = 12;
}