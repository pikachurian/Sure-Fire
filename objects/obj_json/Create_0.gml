saveFileName = "todd.json";//"save.todd";

saveData = 
{
	actor : 
	{
		grav : 1,
		gravMax : 32
	},
	
	player : 
	{
		spd : 10,
		jumpSpd : 24,
		grav : 1,
		gravMax : 32
	},
	
	basicArrow :
	{
		rotateSpd : 1.5,
		spd : 25,
		rotateGrav : 0.5,

		bulletTarget : BT.enemy,
		bulletSprite : spr_arrow_delta,
		wallCollisionSprite : spr_arrow_delta,
		explodeSprite : spr_arrow_delta
	},
	
	movableArrow : 
	{
		rotateSpd : 1.5,
		spd : 10,
		
		bulletTarget : BT.enemy,
		bulletSprite : spr_arrow_delta,
		wallCollisionSprite : spr_arrow_delta,
		explodeSprite : spr_arrow_delta
	},
	
	droneEnemy :
	{
		spd : 4,
		hp : 20,
		hpMax : 20,
		sprite : "spr_drone",
		gunSprite : "spr_drone_gun"
	}
}

function Save()
{
	//Create file.
	var _string = json_stringify(saveData, true);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, saveFileName);
	buffer_delete(_buffer);
	
	show_debug_message("Game Saved: " + _string);
}

function Load()
{
	if(file_exists(saveFileName))
	{
		var _buffer = buffer_load(saveFileName);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
		saveData = _loadData;
		//Load data.
		/*obj_player.LoadData(_loadData.player);
		if(instance_exists(obj_movable_arrow))
			obj_movable_arrow.LoadData(saveData.movableArrow);
		if(instance_exists(obj_basic_arrow))
			obj_basic_arrow.LoadData(saveData.basicArrow);*/
		
		show_debug_message("Game Loaded: " + _string);
	
		return true;
	}
	return false;
}

if(Load() == false)
{
	Save();
}


