var _arrow = instance_place(x, y, obj_basic_arrow);

if(_arrow != noone) && (_arrow.active == true)
{
	Action();
	_arrow.Destroy();
}

_arrow = instance_place(x, y, obj_movable_arrow);

if(_arrow != noone) && (_arrow.active == true)
{
	Action();
	_arrow.Destroy();
}