event_inherited();

isPlayer = true;

hpMax = 100;
hp = hpMax;

fric = 0.5;

//bulletDamage = 10;
//bulletSpeed = 4;//5;

spd = 10;
jumpSpd = 24;

//1 = right, -1 = left.
dir = 1;

shootAngle = 0;
shootHeldTick = 0;
shootHeldTime = 0.15 * game_get_speed(gamespeed_fps);

grappleRange = 500;
grappleSpd = 50;
grappleTargetInstance = instance_create_depth(0, 0, depth - 20, obj_grapple_target);


movableArrowInstance = noone;
shotArrows = ds_list_create();
arrowsMax = 3;

walkSprite = spr_player;//spr_player_walk;
idleSprite = spr_player;//spr_player_idle;
hurtSprite = spr_player;//spr_player_hurt;
deadSprite = spr_player;//spr_player_dead;

//Player State.
enum PS 
{
	main,
	dead,
	controlMovableArrow,
	grappling
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
}

function UpdateSprite()
{
	if(sprite_index == hurtSprite) ||
	(sprite_index == deadSprite)
		return;
		
	//Face direction.
	//image_xscale = dir;
		
	sprite_index = idleSprite;
	if(hspd != 0) || (vspd != 0)
		sprite_index = walkSprite;
}

function CheckGrappleSurface()
{
	if(instance_exists(obj_grapple_surface))
	{
		var _inst = instance_nearest(x, y, obj_grapple_surface);
		grappleTargetInstance.SetTarget(_inst.x, _inst.y);
	}else
	{
		grappleTargetInstance.CancelTarget();
	}
}

function TakeDamage(_amount)
{
	if(state != PS.dead)
	{
		//audio_play_sound(sfx_player_hurt, 8, false);AAAAAA
		
		sprite_index = hurtSprite;
	
		hp -= _amount;
	
		if(hp <= 0)
			Die();
	}
}


function Die()
{
	ChangeState(PS.dead);
	sprite_index = deadSprite;
	
	//instance_create_depth(x, y, depth, obj_game_over);AAAAAAAAA
}

function ChangeState(_state)
{
	state = _state;
}

//if(instance_exists(obj_json))
//	LoadData(obj_json.saveData.player);