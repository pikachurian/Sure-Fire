tick ++;

if(tick > time)
	instance_destroy();
	
if(!surface_exists(surfStart)) || (!surface_exists(surfEnd))
{
	if(room != nextRoom)
		room_goto(nextRoom);
		
	instance_destroy();
}