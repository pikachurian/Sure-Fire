event_inherited();

name = "REMOTE CONTROL ARROW";

function Collected()
{
	obj_player.movableArrowUnlocked = true;
	
	obj_player.sprite_index = spr_player_movable_get;
	
	image_alpha = 0.25;
}