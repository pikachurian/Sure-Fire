draw_self();

draw_set_font(fnt_basic);
draw_set_color(c_teal)
draw_text(x, y, string(x) + "/" + string(goalX) + " | " + string(y) + "/" + string(goalY))