/*obj_json.saveData.checkPoint = checkPointData;
obj_json.saveData.player.grappleUnlocked = obj_player.grappleUnlocked;
obj_json.saveData.player.movableArrowUnlocked = obj_player.movableArrowUnlocked;
obj_json.saveData.player.hp = obj_player.hp;
obj_json.saveData.player.x = obj_player.x;
obj_json.saveData.player.y = obj_player.y;
obj_json.saveData.theRoom = room;

obj_json.Save(obj_json.saveData, obj_json.saveFileName);*/
//show_debug_message("ROOM" + string(room))
if(room != rm_setup_json)
	obj_json.SaveSave();
	
/*if(instance_exists(checkPointData.inst))
{
	with(checkPointData.inst)
	{
		image_index = image_index - 1;
	}
}*/