if(active)
{
	//Apply arrow gravity.
	if(image_angle > 90) && (image_angle < 270)
	{
		//Arrow facing left.	
		SetDirection(min(image_angle + rotateGrav, 270));
	}else
	{
		//Arrow facing right.
		SetDirection(max(image_angle - rotateGrav, -90));
	}
	
	UpdateMovement();

	UpdateWallCollision();
}