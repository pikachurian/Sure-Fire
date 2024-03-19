event_inherited();

spd = 5;//1;


hp = 20;
hpMax = 20;

isDead = false;

//1 = right, -1 = left
dir = 1;

damage = 10;

//knock back/force values.
//Relative to player approach.
hkb = 40;
vkb = 40;

walkSprite = spr_roomba;
idleSprite = spr_roomba;
hurtSprite = spr_roomba_hit_slow
deadSprite = spr_roomba_dead;


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