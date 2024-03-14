// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Global(){

}

randomize();

//Direction.
enum DIR 
{
	left,
	right,
	up,
	down
}

global.playerStartX = -1;
global.playerStartY = -1;

//Percent determines how much of the bar should be filled.
//1 = full.  0.5 = half filled.
function DrawBar(_percent, _x, _y, _width, _height, _borderSize, _color, _borderColor)
{
	draw_set_color(_borderColor);
	draw_rectangle(
		_x - _borderSize,
		_y - _borderSize,
		_x + _width + _borderSize,
		_y + _height + _borderSize,
		false
	);
	
	draw_set_color(_color);
	if(_percent > 0)
	{
		draw_rectangle(
			_x,
			_y,
			_x + (_width * _percent),
			_y + _height,
			false
		);
	}
}

function Approach(_a, _b, _amount)
{
	// Moves "a" towards "b" by "amount" and returns the result.
	// Nice bcause it will not overshoot "b", and works in both directions.
 
	if (_a < _b)
	{
	    _a += _amount;
	    if (_a > _b)
	        return _b;
	}
	else
	{
	    _a -= _amount;
	    if (_a < _b)
	        return _b;
	}

	    return _a;
}

function RoomGotoTransition(_room, _transitionDirection, _time = -1)
{
	with(instance_create_depth(0, 0, 0, obj_room_transition))
	{
		nextRoom = _room;
		dir = _transitionDirection;
		
		if(_time > 0)
			time = _time;
	}
}
