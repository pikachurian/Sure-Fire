event_inherited();

rotateSpd = 1.5;//1;
spd = 10;

bulletTarget = BT.noone;
bulletSprite = spr_movable_arrow;
wallCollisionSprite = spr_arrow_collision;
explodeSprite = spr_movable_arrow;

pickupRange = 128;
collected = false;

pullSpd = 0;
pullAccel = 1;
pullSpdMax = 12;

//Gravity for when the arrow is not active.
hspd = 0;
vspd = 0;
grav = 1;
gravMax = 32;//16;

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

function Turn(_inputAxis)
{
	var _newDir = dir + (_inputAxis * rotateSpd);
	SetDirection(_newDir);
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
	
	bulletTarget = _struct.bulletTarget;
	bulletSprite = _struct.bulletSprite;
	wallCollisionSprite = _struct.wallCollisionSprite;
	explodeSprite = _struct.explodeSprite;
}

if(instance_exists(obj_json))
	LoadData(obj_json.saveData.movableArrow);*/