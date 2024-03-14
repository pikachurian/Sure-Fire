if(active)
{
	//Apply rotation gravity.
	if(tick >= gravStartTime)
		UpdateRotateGravity();
	
	//Update rotation using velocity.
	SetDirection(image_angle + rotateVelocity);
	
	//Homing.
	//if(instance_exists(obj_enemy))
	//{
		//var _inst = instance_nearest(x, y, obj_enemy);
		//if(point_distance(x, y, _inst.x, _inst.y) <= homingRange)
		//{
			var _targets = ds_priority_create(); //instance_place_list(x, y, obj_enemy, true);
			/*var _inst = instance_nearest(x, y, obj_enemy);
			if(point_distance(x, y, _inst.x, _inst.y) <= homingRange)
			{
				var _targetDir = point_direction(x, y, _inst.x, _inst.y);
				var _newDir = Approach(image_angle, _targetDir, homingSpd);//lerp(image_angle, _targetDir, 0.2);
				SetDirection(_newDir);
			}*/
			
			//Get all potential targets.
			for(var _i = 0; _i < array_length(homingTargetObjects); _i ++)
			{
				for(var _j = 0; _j < instance_number(homingTargetObjects[_i]); _j ++)
				{
					var _inst =  instance_find(homingTargetObjects[_i], _j);
					var _distance = point_distance(x, y, _inst.x, _inst.y);
					
					if(point_distance(x, y, _inst.x, _inst.y) <= homingRange)
						ds_priority_add(_targets, _inst, _distance);
				}
			}
		
			//Home in.
			for(var _i = 0; _i < ds_priority_size(_targets); _i ++)
			{
				var _inst = ds_priority_delete_min(_targets);
				
				var _canHit = true;
				
				if(_inst.object_index == obj_enemy) && (_inst.isDead == true)
					_canHit = false;
					
				if(_inst.object_index == obj_basic_trigger) && (_inst.triggered == true)
					_canHit = false;	
					
				if(_canHit == true)
				{
					var _targetDir = point_direction(x, y, _inst.x, _inst.y);
					//var _newDir = Approach(image_angle, _targetDir, homingSpd);//lerp(image_angle, _targetDir, 0.2);
					var _facingMinusTarget = image_angle - _targetDir
					var _angleDifference = _facingMinusTarget;
					
					if(abs(_facingMinusTarget) > 180)
					{
						if(image_angle > _targetDir)
							_angleDifference = -1 * ((360 - image_angle) + _targetDir);
						else
							_angleDifference = ((360 - _targetDir) + image_angle);
					}
					
					var _newDir = image_angle;
					if(_angleDifference > 0)
						_newDir -= homingSpd;
					else
						_newDir += homingSpd;
					
					SetDirection(_newDir);
				}
			}
		
			ds_priority_destroy(_targets);
		//}
	//}
	
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