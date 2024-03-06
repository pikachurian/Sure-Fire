cam = view_camera[0];
viewWidth = camera_get_view_width(cam);
viewHeight = camera_get_view_height(cam);

target = obj_player;

shakeStrength = 0;
shakeDecay = 0.9;

function Shake(_strength = 20)
{
	shakeStrength = _strength;
}