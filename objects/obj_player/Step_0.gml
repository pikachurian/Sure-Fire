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

		
		//Grapple.
		CheckGrappleSurface();
		if(GetInput(INPUT.grapplePressed)) && (IsGrounded())
		{
			if(grappleTargetInstance.canGrapple == true) && (grappleTargetInstance.y < y)
				ChangeState(PS.grappling);	
		}
		
		//Aim bow.
		if(GetInput(INPUT.shootPressed))
		{
			if(dir == 1)
				shootAngle = 0;
			else if(dir == -1)
				shootAngle = 180;
		}
		
		if(GetInput(INPUT.shoot))
		{
			if(GetInput(INPUT.horizontalAxis) != 0) || (GetInput(INPUT.verticalAxis) != 0)
			{
				var _newShootAngle = point_direction(0, 0, GetInput(INPUT.horizontalAxis), GetInput(INPUT.verticalAxis));
		
				if(IsGrounded())
				{
					if(_newShootAngle > 181) && (_newShootAngle < 359)
					{
						if(GetInput(INPUT.horizontalAxis) == 1)
							shootAngle = 0;
						else if(GetInput(INPUT.horizontalAxis) == -1)
							shootAngle = 180;
					}else shootAngle = _newShootAngle;
				}else shootAngle = _newShootAngle;
			}
			show_debug_message(string(shootAngle));
			//Freeze Movement.
			shootHeldTick ++;
			if(shootHeldTick >= shootHeldTime)
				hspd = 0;
		}
		//Fire bow.
		if(GetInput(INPUT.shootReleased))
		{
			var _arrowInstance = instance_create_depth(x, y, depth - 10, obj_basic_arrow);
			if(dir == -1)
				_arrowInstance.SetDirection(180);
			_arrowInstance.SetDirection(shootAngle);
			ds_list_add(shotArrows, _arrowInstance);
			obj_camera.shakeStrength = 10;
			
			shootHeldTick = 0;
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
	
		MoveAndSlide();
		CheckBulletHit();
		UpdateForce();
			
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