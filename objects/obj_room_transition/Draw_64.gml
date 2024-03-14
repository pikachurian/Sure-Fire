//Draw transition.
var _width = display_get_gui_width();
var _height = display_get_gui_height();

var _startX = 0;
var _startY = 0;

var _endX = 0;
var _endY = 0;

switch(transitionDir)
{
	case DIR.left:
		_endX = (1 - tick / time) * _width;
		_endY = 0;
		_startX = (-tick / time) * _width;
		_startY = 0;
		break;
		
	case DIR.right:
		_endX = (-1 + tick / time) * _width;
		_endY = 0;
		_startX = (tick / time) * _width;
		_startY = 0;
		break;
		
	case DIR.up:
		_endX = 0;
		_endY = (1 - tick / time) * _height;
		_startX = 0;
		_startY = (-tick / time) * _height;
		break;
		
	case DIR.down:
		_endX = 0;
		_endY = (-1 + tick / time) * _height;
		_startX = 0;
		_startY = (tick / time) * _height;
		break;
}

if(room != nextRoom)
	room_goto(nextRoom);
	
draw_surface_stretched(surfEnd, _endX, _endY, _width, _height);
draw_surface_stretched(surfStart, _startX, _startY, _width, _height);