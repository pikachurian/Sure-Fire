if(active)
{
	if(tick >= gravStartTime)
		UpdateRotateGravity();
	
	SetDirection(image_angle + rotateVelocity);
	
	UpdateMovement();

	UpdateWallCollision();
}

tick ++;