transitionDir = DIR.right;
nextRoom = rm_test_0;
tick = 0;
time = 0.5 * game_get_speed(gamespeed_fps);

surfStart = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
surfEnd = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));

surface_set_target(surfStart);
gpu_set_blendenable(false);
gpu_set_colorwriteenable(true, true, true, false);
draw_clear(c_black);
draw_surface(application_surface, 0, 0);
gpu_set_blendenable(true);
gpu_set_colorwriteenable(true, true, true, true);
surface_reset_target();