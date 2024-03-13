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
		
		//Grapple.
		CheckGrappleSurface();
		if(GetInput(INPUT.grapplePressed)) && (IsGrounded())
		{
			if(grappleTargetInstance.canGrapple == true) && (grappleTargetInstance.y < y)
				ChangeState(PS.grappling);	
		}
		
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
			obj_camera.zoom = 0.75;
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
			obj_camera.zoom = 1;
		}
		break;
		
	case PS.grappling:
		var _dir = point_direction(x, y, grappleTargetInstance.x, grappleTargetInstance.y);
		x += lengthdir_x(grappleSpd, _dir);
		y += lengthdir_y(grappleSpd, _dir);
		
		if(place_meeting(x, y, obj_wall)) && (place_meeting(x, y, obj_grapple_surface))
		{
			while(place_meeting(x, y, obj_wall))
				y -= 1;
				
			ChangeState(PS.main);
		}
		break;
}