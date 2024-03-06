switch(state)
{
	case PS.main:
		hspd = GetInput(INPUT.horizontalAxis) * spd;
		
		//Update dir.
		if(hspd != 0)
			dir = sign(hspd);
		
		//Jumping
		if(GetInput(INPUT.jumpPressed)) && (IsGrounded())
			vspd = -jumpSpd;
		else
			ApplyGravity();
		
		MoveAndSlide();
		CheckBulletHit();
		UpdateForce();
		
		//Fire bow.
		if(GetInput(INPUT.shootPressed))
		{
			ChangeState(PS.controlMovableArrow);
			movableArrowInstance = instance_create_depth(x, y, depth - 10, obj_movable_arrow);
			obj_camera.target = movableArrowInstance;
		}
			
		UpdateSprite();
		break;
		
	case PS.controlMovableArrow:
		movableArrowInstance.Turn(-GetInput(INPUT.horizontalAxis));
		
		//Leave state.
		if(movableArrowInstance.active == false)
		{
			ChangeState(PS.main);
			obj_camera.target = id;
		}
		break;
}