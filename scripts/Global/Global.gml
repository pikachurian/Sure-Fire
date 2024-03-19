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

//Enemy State.
enum ES 
{
	setRoamGoal,
	roam,
	wait,
	chasePlayer,
	dead,
	setup
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

//Check if checking instance would collide with a wall (solid object).
//Closed doors count as walls.
function WallAt(_x, _y, _checkingInstance)
{
	with(_checkingInstance)
	{
		if(place_meeting(_x, _y, obj_wall))
			return true;
			
		var _door = instance_place(_x, _y, obj_door);
		if(_door != noone) && (_door.opened == false)
			return true;
	}
	return false;
}


function RotateTowards(_currentAngle, _targetAngle, _spd)
{
	//var _targetDir = point_direction(x, y, _inst.x, _inst.y);
	//var _newDir = Approach(image_angle, _targetDir, homingSpd);//lerp(image_angle, _targetDir, 0.2);
	var _facingMinusTarget = _currentAngle - _targetAngle;
	var _angleDifference = _facingMinusTarget;
					
	if(abs(_facingMinusTarget) > 180)
	{
		if(_currentAngle > _targetAngle)
			_angleDifference = -1 * ((360 - _currentAngle) + _targetAngle);
		else
			_angleDifference = ((360 - _targetAngle) + _currentAngle);
	}
			
	var _newDir = _currentAngle;
	if(_angleDifference > 0)
		_newDir -= _spd;
	else
		_newDir += _spd;
						
	return _newDir
					
}

//function AreAllEnemiesDead()
function AllEnemiesDead()
{
	for(var _i = 0; _i < instance_number(obj_enemy); _i ++)
	{
		var _inst = instance_find(obj_enemy, _i);
		if(_inst.isDead == false)
			return false;
	}
	return true;
}