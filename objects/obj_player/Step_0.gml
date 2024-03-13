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
			var _arrowInstance = instance_create_depth(x, y, depth - 10, obj_basic_arrow);
			if(dir == -1)
				_arrowInstance.SetDirection(180);
			ds_list_add(shotArrows, _arrowInstance);
		}
		
		//Fire movable arrow.
		if(GetInput(INPUT.specialPressed))
		{
			ChangeState(PS.controlMovableArrow);
			movableArrowInstance = instance_create_depth(x, y, depth - 10, obj_movable_arrow);
			obj_camera.target = movableArrowInstance;
			if(dir == -1)
				movableArrowInstance.SetDirection(180);
		}
			
		UpdateSprite();
		
		//For some unholy reason this code only works outside of UpdateSprite.
		image_xscale = dir;
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