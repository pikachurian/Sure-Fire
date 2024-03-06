switch(state)
{
	case PS.main:
		hspd = GetInput(INPUT.horizontalAxis) * spd;
		
		//Jumping
		if(GetInput(INPUT.jumpPressed)) && (IsGrounded())
			vspd = -jumpSpd;
		else
			ApplyGravity();
		
		MoveAndSlide();
		CheckBulletHit();
		UpdateForce();
		
		//Fire bow.
			
		UpdateSprite();
		break;
}