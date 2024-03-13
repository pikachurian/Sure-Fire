canGrapple = false;

function SetTarget(_x, _y)
{
	x = _x;
	y = _y;
	image_alpha = 1;
	
	canGrapple = true;
}

function CancelTarget()
{
	image_alpha = 0;
	
	canGrapple = false;
}