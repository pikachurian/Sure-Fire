if(place_meeting(x, y, obj_player))
{
	//Damage player.
	obj_player.TakeDamage(damage);
	
	//Determine horizontal approach.
	var _forceX = sign(obj_player.x - x);
	if(_forceX == 0)
		_forceX = 1;
	_forceX *= hkb;
	
	var _forceY = sign(obj_player.y - y);
	if(_forceY == 0)
		_forceY = 1;
	_forceY *= vkb;
	
	if(obj_player.state != PS.dead)
		obj_player.AddForce(_forceX, _forceY);
}