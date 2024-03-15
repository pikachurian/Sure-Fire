if(active)
{
	UpdateMovement();

	UpdateWallCollision();
}else if(collected == false)
{
	if(point_distance(x, y, obj_player.x, obj_player.y) <= pickupRange)
	{
		collected = true;
	}else if(unstuck == true)
	{
		ApplyGravity();
		MoveAndSlide();
	}
}else
{
	x = lerp(x, obj_player.x, 0.2);
	y = lerp(y, obj_player.y, 0.2);
	
	if(place_meeting(x, y, obj_player))
	{
		obj_player.movableArrowInstance = noone;
		instance_destroy();
	}
}