event_inherited();

isPlayer = true;

hpMax = 100;
hp = hpMax;

//This gives the player invulnerability for a short time after taking damage.
invinceTick = 0;
invinceTime = 1 * game_get_speed(gamespeed_fps);

fric = 0.5;


spd = 12;//10;
jumpSpd = 24;

//1 = right, -1 = left.
dir = 1;

shootAngle = 0;
shootHeldTick = 0;
shootHeldTime = 0.15 * game_get_speed(gamespeed_fps);

//Goes from 0.0 to 1.0.
shootStrength = 0;
shootStrengthAccel = 0.02;//0.01;
shootStrengthMin = 0.2;
shootMovableStrengthMin = 0.8;

grappleRange = 720;//500;
grappleSpd = 50;
grappleTargetInstance = instance_create_depth(-1000, -1000, depth - 20, obj_grapple_target);


movableArrowInstance = noone;
shotArrows = ds_list_create();
arrowsMax = 1;//3;
arrowsInstMax = 30;//10;

canShootArrow = true;
//canShootMovableArrow = true;

walkSprite = spr_player_walking;//spr_player;//spr_player_walk;
idleSprite = spr_player_idle;//spr_player_idle;
jumpSprite = spr_player_jump;
hurtSprite = spr_player_idle;//spr_player_hurt;
deadSprite = spr_player_dead;//spr_player_dead;
chargingArrowSprite = spr_player_charging;
collisionSprite = spr_player_collision;
arrowAimingSprite = spr_arrow_aiming;

shootSFX = sfx_arrow_shoot;
grappleSFX = sfx_grapple;
stepSFX = sfx_step;

grappleSFXID = noone;
stepSFXID = noone;
stepSFXTime = 0.3 * game_get_speed(gamespeed_fps);
stepSFXTick = 0;
stepSFXMinPitch = 0.5;
stepSFXMaxPitch = 1.5;

grappleUnlocked = true;//false;
movableArrowUnlocked = true;//false;

//Player State.
enum PS 
{
	main,
	dead,
	controlMovableArrow,
	grappling,
	chargingBasicArrow,
	chargingMovableArrow,
	pause
}

state = PS.main;

/*function LoadData(_struct)
{
	spd = _struct.spd;
	jumpSpd = _struct.jumpSpd;
	grav = _struct.grav;
	gravMax = _struct.gravMax;
}*/


//Handles the logic for shooting and aiming an arrow.
function ShootArrowLogic()
{
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
		//show_debug_message(string(shootAngle));
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
}

function CleanUpArrows()
{
	if(ds_list_size(shotArrows) >= arrowsInstMax)
	{
		instance_destroy(shotArrows[|0]);
		ds_list_delete(shotArrows, 0);
	}
}

function UpdateShootAngle()
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
}

function PullArrowLogic(_arrowObjectIndex, _heldInputEnum, _releasedInputEnum)
{
	//Pull shot arrow to player.
	if(GetInput(_heldInputEnum))
	{
		if(instance_exists(_arrowObjectIndex))
		{
			with(_arrowObjectIndex)
			{
				Pull();
			}
			canShootArrow = false;
		}
	}
	
	//Cancel pull.
	if(GetInput(_releasedInputEnum))
	{
		if(instance_exists(_arrowObjectIndex))
		{
			with(_arrowObjectIndex)
			{
				CancelPull();
			}
		}
	}
}

function UpdateSprite()
{
	/*if(sprite_index == hurtSprite) ||
	(sprite_index == deadSprite)
		return;*/
		
		
	image_speed = 1;
	//Face direction.
	image_xscale = dir;
	
	if(isGrounded == true)
	{
		if(hspd != 0) || (vspd != 0)
			sprite_index = walkSprite;
		else
			sprite_index = idleSprite;
	}else
	{
		if(sprite_index != jumpSprite)
		{
			sprite_index = jumpSprite;
			image_index = 0;
		}
	}
}

function CheckGrappleSurface()
{
	if(instance_exists(obj_grapple_surface))
	{
		/*var _inst = instance_nearest(x, y, obj_grapple_surface);
		if(point_distance(x, y, _inst.x, _inst.y) <= grappleRange)
			grappleTargetInstance.SetTarget(_inst.x, _inst.y);
		else
			grappleTargetInstance.CancelTarget();*/
		var _surfaces = ds_priority_create();
		/*
		for(var _i = 0; _i < instance_number(obj_grapple_surface); _i ++)
		{
			var _inst = instance_find(obj_grapple_surface, _i);
			if(_inst != noone)
			{
				var _distance = point_distance(x, y, _inst.x, _inst.y);
				if(_distance <= grappleRange)
					ds_priority_add(_surfaces, _inst, _distance);
			}
		}*/
		with(obj_grapple_surface)
		{
			if(y < other.y + 64)
			{
				var _distance = point_distance(other.x, other.y, x, y);
				if(_distance <= other.grappleRange)
					ds_priority_add(_surfaces, id, _distance);
			}
		}
		
		if(!ds_priority_empty(_surfaces))
		{

			var _surf = ds_priority_delete_min(_surfaces);
			grappleTargetInstance.SetTarget(_surf.x, _surf.y);
			ds_priority_destroy(_surfaces);
			return true;
		}
		grappleTargetInstance.CancelTarget();
		ds_priority_destroy(_surfaces);
		return false
	}else
	{
		grappleTargetInstance.CancelTarget();
		return false;
	}
}

function TakeDamage(_amount)
{
	if(state != PS.dead) && (invinceTick >= invinceTime)
	{
		//audio_play_sound(sfx_player_hurt, 8, false);AAAAAA
		
		sprite_index = hurtSprite;
	
		hp -= _amount;
		
		invinceTick = 0;
	
		if(hp <= 0)
			Die();
	}
}


function Die()
{
	ChangeState(PS.dead);
	sprite_index = deadSprite;
	image_speed = 1;
	image_index = 0;
	//instance_create_depth(x, y, depth, obj_game_over);AAAAAAAAA
}

function ChangeState(_state)
{
	state = _state;
}


function LoadSaveStruct(_struct)
{
	x = _struct.x;
	y = _struct.y;
	hp = _struct.hp;
	movableArrowUnlocked = _struct.movableArrowUnlocked;
	grappleUnlocked = _struct.grappleUnlocked;
}

//if(instance_exists(obj_json))
//	LoadData(obj_json.saveData.player);