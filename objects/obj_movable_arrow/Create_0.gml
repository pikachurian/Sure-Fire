event_inherited();

rotateSpd = 1.5;//1;
spd = 10;

bulletTarget = BT.noone;
bulletSprite = spr_movable_arrow;
wallCollisionSprite = spr_arrow_collision;
explodeSprite = spr_movable_arrow;

function Turn(_inputAxis)
{
	var _newDir = dir + (_inputAxis * rotateSpd);
	SetDirection(_newDir);
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