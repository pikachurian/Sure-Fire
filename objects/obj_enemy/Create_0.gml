event_inherited();

spd = 1;

detectPlayerRange = 256;

//The enemy will stop if its distance to the player is under or equal to this range.
minPlayerRange = 64;

shootTime = game_get_speed(gamespeed_fps) * 3; //1;
shootTick = 0;

hp = 20;
hpMax = 20;

isDead = false;


walkSprite = spr_enemy_beta;
idleSprite = spr_enemy_beta;
hurtSprite = spr_enemy_beta;
deadSprite = spr_enemy_beta;

function PlayerInRange()
{
	if(point_distance(x, y, obj_player.x, obj_player.y) <= detectPlayerRange)
	{
		return true;
	}
	return false;
}

function UpdateSprite()
{
	if(sprite_index != hurtSprite) &&
	(sprite_index != deadSprite)
	{
		//Face player.
		image_xscale = 1;
		if(obj_player.x < x)
			image_xscale = -1;
		
		sprite_index = idleSprite;
		if(hspd != 0) || (vspd != 0)
			sprite_index = walkSprite;
	}
}

function Die()
{
	sprite_index = deadSprite;
	isDead = true;
}

function TakeDamage(_amount)
{
	if(isDead == false)
	{
		//audio_play_sound(sfx_enemy_hurt, 5, false);
		
		hp -= _amount;
		sprite_index = hurtSprite;
	
		if(hp <= 0)
			Die();
	}
}

function CheckBulletHit()
{
	if(isDead == true)
		return;
		
	var _bullets = ds_list_create();
	var _bulletsCount = instance_place_list(x, y, obj_bullet, _bullets, false);
	
	
	if(_bulletsCount > 0)
	{
		for(var _i = 0; _i < _bulletsCount; _i ++)
		{
			//Check bullet target against isPlayer.
			if(isPlayer) && (_bullets[|_i].bulletTarget == BT.player) ||
			(!isPlayer) && (_bullets[|_i].bulletTarget == BT.enemy)
			{
				if(_bullets[|_i].active)
				{
					//Take damage.
					TakeDamage(_bullets[|_i].damage);
					
					//Add force to this enemy.
					var _length = _bullets[|_i].force;
					var _direction = _bullets[|_i].image_angle;
					var _forceX = lengthdir_x(_length, _direction);
					var _forceY = lengthdir_y(_length, _direction);
					AddForce(_forceX, _forceY);
				
					_bullets[|_i].Destroy();
					_bullets[|_i].unstuck = true;

				
					break;
				}
			}
		}
	}
}