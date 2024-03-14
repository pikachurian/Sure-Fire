event_inherited();

rotateSpd = 1.5;//1;
spd = 25;
gravStartTime = 0.3 * game_get_speed(gamespeed_fps);
tick = 0;
rotateGrav = 0.01;
rotateVelocity = 0;
rotateVelocityMax = 10;

bulletTarget = BT.enemy;
bulletSprite = spr_arrow;
wallCollisionSprite = spr_arrow_collision;
explodeSprite = spr_arrow;

trailSpawnTime = 0.1 * game_get_speed(gamespeed_fps);
trailSpawnTick = 0;

homingRange = 540;
homingSpd = 0.6;

function UpdateRotateGravity()
{
	//Apply arrow gravity.
	if(image_angle > 90) && (image_angle < 270)
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
	rotateVelocity = clamp(rotateVelocity, -rotateVelocityMax, rotateVelocityMax);
}

function UpdateTrail()
{
	if(trailSpawnTick >= trailSpawnTime)
	{
		instance_create_depth(x, y, depth + 5, obj_arrow_trail);
		trailSpawnTick = 0;
	}else trailSpawnTick ++;
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