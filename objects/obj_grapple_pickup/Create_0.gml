event_inherited();

name = "GRAPPLE";

if(obj_player.grappleUnlocked)
{
	isCollected = true;
	image_alpha = 0.25;
}

function Collected()
{
	obj_json.SaveSave();
	obj_player.grappleUnlocked = true;
	obj_player.sprite_index = spr_player_grapple_get;
	image_alpha = 0.25;
}