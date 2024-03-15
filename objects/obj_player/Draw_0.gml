draw_self();

//Draw health bar.
DrawBar(
	(hp / hpMax),
	x - 128,
	y - 128,
	128,
	16,
	4,
	c_green,
	c_grey
);