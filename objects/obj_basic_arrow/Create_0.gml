event_inherited();

rotateSpd = 1.5;//1;
spd = 25;
rotateGrav = 0.5;

bulletTarget = BT.enemy;
bulletSprite = spr_arrow;
wallCollisionSprite = spr_arrow;
explodeSprite = spr_arrow;

function LoadData(_struct)
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
	LoadData(obj_json.saveData.basicArrow);