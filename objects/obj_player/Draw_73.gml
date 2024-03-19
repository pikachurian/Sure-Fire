//Draw health bar.
if(room != rm_title)
{
	var _viewX = camera_get_view_x(view_camera[0]);
	var _viewY = camera_get_view_y(view_camera[0]);
	
	draw_set_alpha(0.9);
	draw_sprite_part(
		spr_player_health_bar, 
		0, 
		0, 
		0, 
		640 * (hp / hpMax),
		640,
		_viewX, 
		_viewY
		);
	draw_sprite(spr_player_health_bar_frame, 0, _viewX, _viewY);
	draw_set_alpha(1);
}
