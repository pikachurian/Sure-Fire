surface_set_target(surfEnd);
gpu_set_blendenable(false);
gpu_set_colorwriteenable(true, true, true, false);
draw_clear(c_black);
draw_surface(application_surface, 0, 0);
gpu_set_blendenable(true);
gpu_set_colorwriteenable(true, true, true, true);
surface_reset_target();