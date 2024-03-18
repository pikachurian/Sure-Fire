switch(state)
{
	case PS.main:
		hspd = GetInput(INPUT.horizontalAxis) * spd;
		
		//Update dir.
		if(hspd != 0)
			dir = sign(hspd);
		
		//Jumping
		if(GetInput(INPUT.jumpPressed)) && (isGrounded == true)
		{
			vspd = -jumpSpd;
		}else
			ApplyGravity();

	
		
		//Grapple.
		if(grappleUnlocked == true)
		{
			CheckGrappleSurface();
			if(GetInput(INPUT.grapplePressed)) && (isGrounded == true) && (point_distance(x, y, grappleTargetInstance.x, grappleTargetInstance.y) <= grappleRange)
			{
				//Play sound.
				grappleSFXID = audio_play_sound(grappleSFX, 10, false);
				
				if(grappleTargetInstance.canGrapple == true) && (grappleTargetInstance.y < y)
					ChangeState(PS.grappling);	
			}
		}
		
		//Shoot arrow logic.
		if(GetInput(INPUT.shootPressed))
		{
			if(dir == 1)
				shootAngle = 0;
			else if(dir == -1)
				shootAngle = 180;
				
			shootStrength = 0;
			ChangeState(PS.chargingBasicArrow);
		}
		
		//Fire movable arrow.
		if(movableArrowUnlocked == true)
		{
			if(GetInput(INPUT.specialPressed))
			{	
				if(dir == 1)
					shootAngle = 0;
				else if(dir == -1)
					shootAngle = 180;
				ChangeState(PS.chargingMovableArrow);
			}
		}
		
		var _sprite = sprite_index;
		var _imageIndex = image_index;
		sprite_index = collisionSprite;
		MoveAndSlide();
		CheckBulletHit();
		UpdateForce();
		sprite_index = _sprite;
		image_index = _imageIndex;
			
		UpdateSprite();
		
		//Walking sound effects.
		if(isGrounded)
		{
			if(GetInput(INPUT.leftPressed)) || (GetInput(INPUT.rightPressed))
			{
				stepSFXTick = 0;
				var _pitch = random_range(stepSFXMinPitch, stepSFXMaxPitch);
				audio_play_sound(stepSFX, 8, false, 1, 0, _pitch);
			}
		
			if(GetInput(INPUT.horizontalAxis) != 0)
			{
				if(stepSFXTick >= stepSFXTime)
				{
					stepSFXTick = 0;
					var _pitch = random_range(stepSFXMinPitch, stepSFXMaxPitch);
					audio_play_sound(stepSFX, 8, false, 1, 0, _pitch);
				}else stepSFXTick += 1;
			}
		}
		break;
		
	case PS.chargingBasicArrow:
		sprite_index = chargingArrowSprite;
		UpdateShootAngle();
		
		shootStrength = min(shootStrength + shootStrengthAccel, 1);
		
		//Fire bow.
		if(GetInput(INPUT.shootReleased))
		{
			if(shootStrength >= shootStrengthMin)
			{
				var _arrowInstance = instance_create_depth(x, y, depth - 10, obj_basic_arrow);
				if(dir == -1)
					_arrowInstance.SetDirection(180);
				_arrowInstance.SetDirection(shootAngle);
				_arrowInstance.SetArrowStrength(shootStrength);
				ds_list_add(shotArrows, _arrowInstance);
				obj_camera.shakeStrength = 10;
				
				//Play sound.
				audio_play_sound(shootSFX, 10, false);
			}
			image_speed = 1;
			shootStrength = 0;
			ChangeState(PS.main);
		}
		break;
		
	case PS.chargingMovableArrow:
		sprite_index = chargingArrowSprite;
		UpdateShootAngle();
		
		shootStrength = min(shootStrength + shootStrengthAccel, 1);
		
		if(GetInput(INPUT.specialReleased))
		{	
			if(shootStrength >= shootMovableStrengthMin)
			{
				var _arrowInstance = instance_create_depth(x, y, depth - 10, obj_movable_arrow);
				if(dir == -1)
					_arrowInstance.SetDirection(180);
				_arrowInstance.SetDirection(shootAngle);
				if(movableArrowInstance != noone)
					instance_destroy(movableArrowInstance);
				movableArrowInstance = _arrowInstance;
				obj_camera.zoom = 0.75;
				obj_camera.target = movableArrowInstance;
				
				image_speed = 1;
				shootStrength = 0;

				ChangeState(PS.controlMovableArrow);
			}else
			{
				image_speed = 1;
				shootStrength = 0;
				ChangeState(PS.main);
			}
		}
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
		
		var _sprite = sprite_index;
		var _imageIndex = image_index;
		sprite_index = collisionSprite;
		if(place_meeting(x, y, obj_wall)) && (place_meeting(x, y, obj_grapple_surface))
		{
			while(place_meeting(x, y, obj_wall))
				y -= 1;
				
			audio_stop_sound(grappleSFXID);
				
			ChangeState(PS.main);
		}
		
		sprite_index = _sprite;
		image_index = _imageIndex;
		break;
}

if(GetInput(INPUT.shootReleased))
	canShootArrow = true;
	
CleanUpArrows();