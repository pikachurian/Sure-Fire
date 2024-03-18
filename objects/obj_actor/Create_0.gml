isPlayer = false;

hspd = 0;
vspd = 0;

hpMax = 30;
hp = 30;

addedForceX = 0;
addedForceY = 0;
forceFriction = 0.9;

spd = 2;

jumpSpd = 7;

grav = 1;
gravMax = 32;

isGrounded = false;

function LoadData(_struct)
{
	grav = _struct.grav;
	gravMax = _struct.gravMax;
}

function ApplyGravity()
{
	vspd = min(vspd + grav, gravMax);
}

function IsGrounded()
{
	if(place_meeting(x, y + 1, obj_wall))
		return true;
		
	var _door = instance_place(x, y + 1, obj_door);
	if(_door != noone) && (_door.opened != true)
		return true;
		
	return false;
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
	
	PushOutOfWall();
	
	//Update isGrounded.
	if(WallAt(x, y + 1, id))
		isGrounded = true;
	else
		isGrounded = false;
}

function PushOutOfWall()
{
	if(WallAt(x, y, id))
	{
		while(WallAt(x, y, id))
			y -= 1;
	}
}

function UpdateForce()
{
	//X collisions.
	if(place_meeting(x + addedForceX, y, obj_wall))
	{
		addedForceX *= -1;
	}
	
	x += addedForceX;
	
	//Y collisions.
	if(place_meeting(x, y + addedForceY, obj_wall))
	{
		addedForceY *= -1;
	}
	
	y += addedForceY;
	
	addedForceX *= forceFriction;
	addedForceY *= forceFriction;
}

function TakeDamage(_amount)
{
	hp -= _amount;
	
	if(hp <= 0)
		Die();
}

function Die()
{
	instance_destroy();
}

function CheckBulletHit()
{
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
					
					//Add force to this actor.
					var _length = _bullets[|_i].force;
					var _direction = _bullets[|_i].image_angle;
					var _forceX = lengthdir_x(_length, _direction);
					var _forceY = lengthdir_y(_length, _direction);
					AddForce(_forceX, _forceY);
		
					_bullets[|_i].Destroy();
				
					break;
				}
			}
		}
	}
}

function AddForce(_x, _y)
{
	addedForceX = _x;
	addedForceY = _y;
}