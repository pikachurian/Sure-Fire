draw_self();
draw_sprite(gunSprite, 0, x, y);

draw_set_font(fnt_basic);
draw_set_color(c_teal)
draw_text(x, y, string(x) + "/" + string(goalX) + " | " + string(y) + "/" + string(goalY))