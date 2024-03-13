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