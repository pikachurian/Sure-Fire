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
			var _newDir = lerp(image_angle, _targetDir, 0.2);
			SetDirection(_newDir);
		}
	}
	
	UpdateMovement();

	UpdateWallCollision();
	
	UpdateTrail();
}

tick ++;