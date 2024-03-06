draw_self();

//Draw health bar.
DrawBar(
	(hp / hpMax),
	x -32,
	y- 32,
	64,
	8,
	1,
	c_green,
	c_grey
);