event_inherited();

name = "REMOTE CONTROL ARROW";
//about = "Hold and release K\nto shoot a controllable arrow.\nUse A and D to steer \nthe arrow.";
about = "Press K to shoot.\nA and D steer.";

if(obj_player.movableArrowUnlocked)
{
	isCollected = true;
	image_alpha = 0.25;
}

function Collected()
{
	obj_player.movableArrowUnlocked = true;
	obj_json.SaveSave();
	
	obj_player.sprite_index = spr_player_movable_get;
	
	image_alpha = 0.25;
}