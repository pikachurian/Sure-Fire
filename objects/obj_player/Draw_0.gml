//draw_self();

//Draw health bar.
/*DrawBar(
	(hp / hpMax),
	x - 128,
	y - 128,
	128,
	16,
	4,
	c_green,
	c_grey
);*/

switch(state)
{
	case PS.chargingBasicArrow:
		//Draw aiming visual.
		draw_sprite_ext(arrowAimingSprite, 0, x, y, 1, 1, shootAngle, c_white, 0.8);
		
		draw_self();
		
		//Draw shoot strength bar.
		var _color = c_red;
		if(shootStrength >= shootStrengthMin)
			_color = c_ltgrey;
		DrawBar(
			(shootStrength / 1),
			x - 128,
			y - 128,
			128,
			16,
			4,
			_color,
			c_dkgrey
		);
		break;
		
	case PS.grappling:
		draw_set_color(c_white);
		draw_line_width(x, y, grappleTargetInstance.x, grappleTargetInstance.y, 4);
		draw_self(); 
		break;
		
	default:
		draw_self();
		break;
}