event_inherited();

state = ES.setup;//ES.setRoamGoal;
spd = 4;

goalMinDistance = 64;//32;
goalMaxDistance = 176;//128;
goalX = x;
goalY = y;
setGoalAttempts = 0;
setGoalAttemptsMax = 10;

waitTick = 0;
waitTime = 1 * game_get_speed(gamespeed_fps);
waitTimeMin = 1;//0.5 * game_get_speed(gamespeed_fps);
waitTimeMax = 2;//1.5 * game_get_speed(gamespeed_fps);
waitNextState = ES.setRoamGoal;

lastX = x;
lastY = y;

stuckTick = 0;
stuckTime = game_get_speed(gamespeed_fps) * 1;

detectPlayerRange = 720;

//The enemy will stop if its distance to the player is under or equal to this range.
minPlayerRange = 480;
fleePlayerRange = 240;

shootTime = game_get_speed(gamespeed_fps) * 3; //1;
shootTick = 0;

bulletDamage = 10;
bulletSpeed = 2;

hp = 20;
hpMax = 20;

waypoints = ds_list_create();
waypointOn = 0;
waypointID = 0;

distanceToFloor = 240;

walkSprite = spr_drone;//spr_enemy_beta;
idleSprite = spr_drone;//spr_enemy_beta;
hurtSprite = spr_drone;//spr_enemy_beta;
deadSprite = spr_drone;//spr_enemy_beta;
gunSprite = spr_drone_gun;

function LoadData(_struct)
{
	walkSprite = GetSprite(_struct.sprite);
	idleSprite = GetSprite(_struct.sprite);
	hurtSprite = GetSprite(_struct.sprite);
	hurtSprite = GetSprite(_struct.sprite);
	gunSprite = GetSprite(_struct.gunSprite);
	
	spd = _struct.spd;
	hp = _struct.hp;
	hpMax = _struct.hpMax;
}

function Hover()
{
	var _pixelsAboveGround = 0;
	for(var _i = 0; _i < distanceToFloor; _i ++)
	{
		if(WallAt(x, y + _i, id))
		{
			_pixelsAboveGround = _i;
			break;
		}
	}
	
	if(_pixelsAboveGround != 0)
		y = lerp(y, y - (distanceToFloor - _pixelsAboveGround), 0.2);
}

function UpdateWaypoints()
{
	if(instance_exists(obj_enemy_waypoint))
	{
		with(obj_enemy_waypoint)
		{
			if(waypointID == other.waypointID)
				ds_list_add(other.waypoints, id);
		}
	}
}

function GotoWaypoint(_index)
{
	waypointOn = _index;
	if(_index < ds_list_size(waypoints))
	{
		goalX = waypoints[|_index].x;
		goalY = waypoints[|_index].y;
	}else
	{
		goalX = x;
		goalY = y;
	}
}

//Increments that index, then sets goal to current waypoint index.
function GotoNextWaypoint()
{
	IncrementWaypointIndex();
		
	GotoWaypoint(waypointOn);
}

function IncrementWaypointIndex()
{
	waypointOn += 1;
	if(waypointOn >= ds_list_size(waypoints))
		waypointOn = 0;
}

function SetNewRandomGoal()
{
	/*var _goalX = x;
	var _goalY = y;
	
	for(var _i = 0; _i < 1; _i ++)
	{
		var _dist = random_range(goalMinDistance, goalMaxDistance);
		var _dir = random_range(0, 359);
		
		_goalX = x + lengthdir_x(_dist, _dir);
		_goalY = y + lengthdir_y(_dist, _dir);
		
		_goalX = clamp(_goalX, 0, room_width);
		_goalY = clamp(_goalY, 0, room_height);
		
		if(!place_meeting(_goalX, _goalY, obj_wall))
			break;
		else
		{
			_goalX = x;
			_goalY = y;
		}
	}
	
	goalX = _goalX;
	goalY = _goalY;
	
	stuckTick = 0;*/
}

function ChangeState(_state)
{
	switch(_state)
	{
		case ES.wait:
			//
			break;
			
		case ES.chasePlayer:
			shootTick = 0;
			break;
	}
	
	state = _state;
}

function MoveTowardsPoint(_x, _y)
{
	mp_potential_step(_x, _y, spd, false);
}

function Wait(_nextState, _time)
{
	waitTime = _time;
	waitTick = 0;
	waitNextState = _nextState;
	ChangeState(ES.wait);
}

function DetectPlayer()
{
	if(point_distance(x, y, obj_player.x, obj_player.y) <= detectPlayerRange)
	{
		ChangeState(ES.chasePlayer);
	}
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
	image_alpha = 0.2;
	ChangeState(ES.dead);
	instance_destroy();

}

function TakeDamage(_amount)
{
	if(state != ES.dead)
	{
		PlayHitFeedback();
		//audio_play_sound(sfx_enemy_hurt, 5, false);
		
		hp -= _amount;
		sprite_index = hurtSprite;
	
		if(hp <= 0)
			Die();
	}
}

function CheckBulletHit()
{
	if(state == ES.dead)
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