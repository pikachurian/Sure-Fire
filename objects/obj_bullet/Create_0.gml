//Bullet Target.
enum BT 
{
	player,
	enemy,
	noone
}

bulletTarget = BT.noone;
bulletSprite = spr_arrow_delta;
wallCollisionSprite = spr_arrow_delta;//spr_bullet_wall_collision;
explodeSprite = spr_arrow_delta;//spr_enemy_bullet_explode;

//360 degrees
dir = 0;
spd = 4;
damage = 10;
force = 10;//2; //Used to knock back target.

active = true;

function UpdateMovement()
{
	x += lengthdir_x(spd, dir);
	y += lengthdir_y(spd, dir);
}

function SetDirection(_dir)
{
	dir = _dir;
	image_angle = dir;
}

function Destroy()
{
	image_index = 0;
	image_speed = 1;
	active = false;
	sprite_index = explodeSprite;
}

function UpdateWallCollision()
{
	//Wall collision.
	var _imageIndex = image_index;
	sprite_index = wallCollisionSprite;
	
	if(place_meeting(x, y, obj_wall))
		Destroy();
	else
	{
		sprite_index = bulletSprite;
		image_index = _imageIndex;
	}	
	
	//Door collision.
	var _door = instance_place(x, y, obj_door);
	if(_door != noone) && (_door.opened == false)
		Destroy();
	else
	{
		sprite_index = bulletSprite;
		image_index = _imageIndex;
	}	
}