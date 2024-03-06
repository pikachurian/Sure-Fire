if(active)
{
	var _newDir = dir + (-GetInput(INPUT.horizontalAxis) * rotateSpd);
	SetDirection(_newDir);
	
	UpdateMovement();

	UpdateWallCollision();
}