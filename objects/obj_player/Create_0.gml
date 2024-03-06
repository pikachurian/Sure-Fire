event_inherited();

isPlayer = true;

hpMax = 100;
hp = hpMax;

fric = 0.5;

bulletDamage = 10;
bulletSpeed = 4;//5;

spd = 2;
jumpSpd = 7;

//1 = right, -1 = left.
dir = 1;

walkSprite = spr_player;//spr_player_walk;
idleSprite = spr_player;//spr_player_idle;
hurtSprite = spr_player;//spr_player_hurt;
deadSprite = spr_player;//spr_player_dead;

//Player State.
enum PS 
{
	main,
	dead
}

state = PS.main;


function UpdateSprite()
{
	if(sprite_index == hurtSprite) ||
	(sprite_index == deadSprite)
		return;
		
	//Face direction.
	image_xscale = dir;
		
	sprite_index = idleSprite;
	if(hspd != 0) || (vspd != 0)
		sprite_index = walkSprite;
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