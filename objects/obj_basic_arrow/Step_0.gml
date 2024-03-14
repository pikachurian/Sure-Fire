if(active)
{
	//Apply rotation gravity.
	if(tick >= gravStartTime)
		UpdateRotateGravity();
	
	//Update rotation using velocity.
	SetDirection(image_angle + rotateVelocity);
	
	//Homing.
	if(instance_exists(obj_enemy))
	{
		var _inst = instance_nearest(x, y, obj_enemy);
		if(point_distance(x, y, _inst.x, _inst.y) <= homingRange)
		{
			var _enemies = ds_priority_create(); //instance_place_list(x, y, obj_enemy, true);
			/*var _inst = instance_nearest(x, y, obj_enemy);
			if(point_distance(x, y, _inst.x, _inst.y) <= homingRange)
			{
				var _targetDir = point_direction(x, y, _inst.x, _inst.y);
				var _newDir = Approach(image_angle, _targetDir, homingSpd);//lerp(image_angle, _targetDir, 0.2);
				SetDirection(_newDir);
			}*/
			//Get all enemies.
			for(var _i = 0; _i < instance_number(obj_enemy); _i ++)
			{
				var _inst =  instance_find(obj_enemy, _i);
				var _distance = point_distance(x, y, _inst.x, _inst.y);
				ds_priority_add(_enemies, _inst, _distance);
			}
		
			//Home in.
			for(var _i = 0; _i < ds_priority_size(_enemies); _i ++)
			{
				var _inst = ds_priority_delete_min(_enemies);
				if(_inst.isDead == false)
				{
					var _targetDir = point_direction(x, y, _inst.x, _inst.y);
					var _newDir = Approach(image_angle, _targetDir, homingSpd);//lerp(image_angle, _targetDir, 0.2);
					SetDirection(_newDir);
				}
			}
		
			ds_priority_destroy(_enemies);
		}
	}
	
	UpdateMovement();

	UpdateWallCollision();
	
	UpdateTrail();
}else if(collected == false)
{
	if(point_distance(x, y, obj_player.x, obj_player.y) <= pickupRange)
	{
		collected = true;
	}
}else
{
	x = lerp(x, obj_player.x, 0.2);
	y = lerp(y, obj_player.y, 0.2);
	
	if(place_meeting(x, y, obj_player))
	{
		ds_list_delete(obj_player.shotArrows, ds_list_find_index(obj_player.shotArrows, id));
		instance_destroy();
	}
}

tick ++;