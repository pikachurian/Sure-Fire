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
			var _targetDir = point_direction(x, y, _inst.x, _inst.y);
			var _newDir = Approach(image_angle, _targetDir, homingSpd);//lerp(image_angle, _targetDir, 0.2);
			SetDirection(_newDir);
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