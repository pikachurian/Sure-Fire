image_speed = 0;

if(obj_game_master.checkPointInst == id)
{
	image_index = image_index - 1;
}else image_index = 0;

function Action(_arrowInst)
{
	if(_arrowInst.object_index == obj_basic_arrow) && (obj_game_master.checkPointInst != id)
	{
		obj_game_master.checkPointInst = id;
		obj_game_master.checkPointRoom = room;
		obj_game_master.checkPointX = x;
		obj_game_master.checkPointY = y;
		
		image_speed = 1;
		if(sign(x - _arrowInst.x) < 0)
			image_xscale = -1;

		//Destroy triggering arrow instance.
		ds_list_delete(obj_player.shotArrows, ds_list_find_index(obj_player.shotArrows, _arrowInst));
		instance_destroy(_arrowInst);
		
	}
}