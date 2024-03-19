if(songID != noone)
{
	draw_set_font(fnt_sans);
	draw_set_color(c_black);
	draw_text(
		camera_get_view_width(view_camera[0]) / 2, 
		camera_get_view_height(view_camera[0]) / 2,
		"YOU GOT THE " + name + "!"
		);
		
	draw_set_color(c_white);
	draw_text(
		camera_get_view_width(view_camera[0]) / 2 - 16, 
		camera_get_view_height(view_camera[0]) / 2 - 16,
		"YOU GOT THE " + name + "!"
		);
}