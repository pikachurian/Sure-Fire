draw_self();

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
}