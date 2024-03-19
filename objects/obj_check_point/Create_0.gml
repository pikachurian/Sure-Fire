image_speed = 0;
//image_index = 0;
show_debug_message(string(obj_game_master.checkPointData.inst) + "|" + string(id))
if(obj_game_master.checkPointData.inst == id)
{
	image_index = image_index - 1;
}else image_index = 0;

function Action(_arrowInst)
{
	if(_arrowInst.object_index == obj_basic_arrow) && (obj_game_master.checkPointData.inst != id)
	{
		with(obj_game_master)
		{
			checkPointData.x = other.x;
			checkPointData.y = other.y;
			checkPointData.theRoom = room;
			checkPointData.inst = other.id;
			//show_debug_message(string(checkPointData.inst) + "LLLLLLLLLLLLLLLL" );
		}
		
		image_speed = 1;
		if(sign(x - _arrowInst.x) < 0)
			image_xscale = -1;

		//Destroy triggering arrow instance.
		ds_list_delete(obj_player.shotArrows, ds_list_find_index(obj_player.shotArrows, _arrowInst));
		instance_destroy(_arrowInst);
		
		obj_player.hp = obj_player.hpMax;
		obj_json.SaveSave();
	}else if(_arrowInst.object_index == obj_basic_arrow)
	{
		obj_player.hp = obj_player.hpMax;
		obj_json.SaveSave();
	}
}