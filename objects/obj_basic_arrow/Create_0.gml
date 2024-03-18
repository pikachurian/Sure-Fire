event_inherited();

bowStrength = 1.5;
bowStrengthMin = 0.5;
bowStrengthMax = 1.5;

rotateSpd = 1.5;//1;
spdMax = 40;
spdMin = 25;
spd = spdMax;//25;
gravStartTimeMax = 0.3 * game_get_speed(gamespeed_fps);
gravStartTimeMin = 0.05 * game_get_speed(gamespeed_fps);
gravStartTime = gravStartTimeMax;//0.2 * game_get_speed(gamespeed_fps);//0.3 * game_get_speed(gamespeed_fps);
tick = 0;
rotateGrav = 0.05;//0.01;
rotateVelocity = 0;
rotateVelocityMax = 20;//10;

bulletTarget = BT.enemy;
bulletSprite = spr_arrow;
wallCollisionSprite = spr_arrow_collision;
explodeSprite = spr_arrow;

trailSpawnTime = 0.1 * game_get_speed(gamespeed_fps);
trailSpawnTick = 0;

homingRange = 540;
homingSpdMin = 1;
homingSpdMax = 2;
homingSpd = homingSpdMax;//0.6;
homingTargetObjects = [obj_enemy, obj_trigger];

pickupRange = 128;//320;
collected = false;

pullSpd = 0;
pullAccel = 1;
pullSpdMax = 32;//12;

//Gravity for when the arrow is not active.
hspd = 0;
vspd = 0;
grav = 1;
gravMax = 16;

unstuck = false;

function ApplyGravity()
{
	vspd = min(vspd + grav, gravMax);
}

//Pull this arrow to the player.
function Pull()
{
	if(active == false)
	{
		unstuck = true;
		vspd = 0;
		var _dir = point_direction(x, y, obj_player.x, obj_player.y);
		pullSpd = min(pullSpd + pullAccel, pullSpdMax);
	
		x += lengthdir_x(pullSpd, _dir);
		y += lengthdir_y(pullSpd, _dir);
	}
}

function CancelPull()
{
	pullSpd = 0;
}

function UpdateRotateGravity()
{
	//Apply arrow gravity.
	/*if(image_angle > 90) && (image_angle < 270)
	{
		//Arrow facing left.	
		rotateVelocity = min(rotateVelocity + rotateGrav, 270)
		//SetDirection(min(image_angle + rotateGrav, 270));
	}else
	{
		//Arrow facing right.
		//SetDirection(max(image_angle - rotateGrav, -90));
		rotateVelocity = max(rotateVelocity - rotateGrav, -90)
	}
	rotateVelocity = clamp(rotateVelocity, -rotateVelocityMax, rotateVelocityMax);*/
	rotateVelocity = min(rotateVelocity + rotateGrav, rotateVelocityMax);
	SetDirection(RotateTowards(image_angle, 270, rotateVelocity));
}

function UpdateTrail()
{
	if(trailSpawnTick >= trailSpawnTime)
	{
		instance_create_depth(x, y, depth + 5, obj_arrow_trail);
		trailSpawnTick = 0;
	}else trailSpawnTick ++;
}

//Move using hspd and vspd.
function MoveAndSlide()
{
	//X collisions.
	if(place_meeting(x + hspd, y, obj_wall))
	{
		while(!place_meeting(x + sign(hspd), y, obj_wall))
			x += sign(hspd);
			
		hspd = 0;
	}
	
	//X Door collisions.
	var _door = instance_place(x + hspd, y, obj_door);
	if(_door != noone)
	{
		if(_door.opened == false)
		{
			while(!place_meeting(x + sign(hspd), y, obj_door))
				x += sign(hspd);
				
			hspd = 0;
		}
	}
	
	x += hspd;
	
	//Y collisions.
	if(place_meeting(x, y + vspd, obj_wall))
	{
		while(!place_meeting(x, y + sign(vspd), obj_wall))
			y += sign(vspd);
			
		vspd = 0;
	}
	
	//X Door collisions.
	var _door = instance_place(x, y + vspd, obj_door);
	if(_door != noone)
	{
		if(_door.opened == false)
		{
			while(!place_meeting(x, y + sign(vspd), obj_door))
				y += sign(vspd);
				
			vspd = 0;
		}
	}
	
	y += vspd;
}

/*function LoadData(_struct)
{
	rotateSpd = _struct.rotateSpd;
	spd = _struct.spd;
	rotateGrav = _struct.rotateGrav;
	
	bulletTarget = _struct.bulletTarget;
	bulletSprite = _struct.bulletSprite;
	wallCollisionSprite = _struct.wallCollisionSprite;
	explodeSprite = _struct.explodeSprite;
}

if(instance_exists(obj_json))
	LoadData(obj_json.saveData.basicArrow);*/