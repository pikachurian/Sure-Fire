//saveFileName = "todd.json";//"save.todd";
saveFileName = "todd2.json";

//Starting stats for most objects.
#region Unused, but good for future reference.
/*startingData = 
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
}*/
#endregion

//Used to edit the game externally.
jsonData = noone;

saveDataDefault = 
{
	player : 
	{
		x : 800,
		y : 1376,
		hp : 100,
		grappleUnlocked : false,
		movableArrowUnlocked : false
	},
	
	theRoom : rm_start,
	
	checkPoint : 
	{
		inst : noone,
		theRoom : noone,
		x : 0,
		y : 0
	},
	
	won : false
}

saveData = saveDataDefault;

function Save(_struct, _fileName)
{
	//Create file.
	var _string = json_stringify(_struct);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, _fileName);
	buffer_delete(_buffer);
	
	show_debug_message("Game Saved: " + _string);
}

function Load(_fileName)
{
	if(file_exists(_fileName))
	{
		var _buffer = buffer_load(_fileName);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
		//saveData = _loadData;
		//Load data.
		/*obj_player.LoadData(_loadData.player);
		if(instance_exists(obj_movable_arrow))
			obj_movable_arrow.LoadData(saveData.movableArrow);
		if(instance_exists(obj_basic_arrow))
			obj_basic_arrow.LoadData(saveData.basicArrow);*/
		
		show_debug_message("Game Loaded: " + _string);
	
		return _loadData;
	}
	return noone;
}

function LoadSave()
{
	saveData = Load(saveFileName);
	//show_debug_message("AAAAAAAA "+string(saveData))
	obj_player.LoadSaveStruct(saveData.player);
	obj_game_master.LoadSaveStruct(saveData.checkPoint);
	room_goto(saveData.theRoom);
	//show_debug_message("ABABABA")
}

function SaveSave()
{
	saveData.checkPoint = obj_game_master.checkPointData;
	saveData.player.grappleUnlocked = obj_player.grappleUnlocked;
	saveData.player.movableArrowUnlocked = obj_player.movableArrowUnlocked;
	saveData.player.hp = obj_player.hp;
	saveData.player.x = obj_player.x;
	saveData.player.y = obj_player.y;
	saveData.theRoom = room;

	Save(saveData, saveFileName);
}

function ClearSave()
{
	if(file_exists(saveFileName))
	{
		file_delete(saveFileName);
		saveData = saveDataDefault;
		Save(saveData, saveFileName);
	}
}

//Load JSON data.
jsonData = Load("data.json");

/*if(Load() == false)
{
	Save();
}*/

//Load save.
if(file_exists(saveFileName))
{
	//show_debug_message("SAVE FOUND " + string(Load(saveFileName)));
	//LoadSave();
}else 
{
	//show_debug_message("CREATING NEW SAVE");
	Save(saveData, saveFileName);
}

if(os_browser != browser_not_a_browser)
	Save(saveData, saveFileName);
//show_debug_message("AHHHHHH")
