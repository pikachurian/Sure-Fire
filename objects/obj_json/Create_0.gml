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
		//Load data.
		obj_player.LoadData(_loadData.player);
		
		show_debug_message("Game Loaded: " + _string);
	
		return true;
	}
	return false;
}

if(Load() == false)
{
	Save();
}