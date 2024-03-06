// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Global(){

}

randomize();

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

