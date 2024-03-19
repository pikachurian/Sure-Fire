if(songID != noone)
{
	var _viewWidth = camera_get_view_width(view_camera[0]);
	var _viewX = camera_get_view_x(view_camera[0]);
	var _viewHeight = camera_get_view_height(view_camera[0]);
	var _viewY = camera_get_view_y(view_camera[0]);
	
	var _x = _viewX + _viewWidth / 2;
	var _y = _viewY + _viewHeight / 2;
	
	draw_set_font(fnt_sans);
	draw_set_color(c_black);
	draw_text(
		_x,//camera_get_view_width(view_camera[0]) / 2, 
		_y,//camera_get_view_height(view_camera[0]) / 2,
		"YOU GOT THE " + name + "!"
		);
		
	draw_set_color(c_white);
	draw_text(
		_x - 16,//camera_get_view_width(view_camera[0]) / 2 - 16, 
		_y - 16,//camera_get_view_height(view_camera[0]) / 2 - 16,
		"YOU GOT THE " + name + "!"
		);
}