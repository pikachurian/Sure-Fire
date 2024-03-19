event_inherited();

name = "GRAPPLE";

function Collected()
{
	obj_player.grappleUnlocked = true;
	obj_player.sprite_index = spr_player_grapple_get;
	image_alpha = 0.25;
}