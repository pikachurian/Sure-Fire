// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Input(){

}

enum INPUT
{
	left,
	right,
	up,
	down,
	leftPressed,
	rightPressed,
	horizontalAxis,
	verticalAxis,
	shootPressed,
	shoot,
	shootReleased,
	jump,
	jumpPressed,
	jumpReleased,
	loadPressed,
	savePressed,
	specialPressed,
	special,
	specialReleased,
	grapplePressed
}

function GetInput(_inputEnum)
{
	var _input = 0;
	switch(_inputEnum)
	{
		case INPUT.left:
			_input = keyboard_check(ord("A"));
			break;
			
		case INPUT.right:
			_input = keyboard_check(ord("D"));
			break;
			
		case INPUT.up:
			_input = keyboard_check(ord("W"));
			break;
			
		case INPUT.down:
			_input = keyboard_check(ord("S"));
			break;
			
		case INPUT.leftPressed:
			_input = keyboard_check_pressed(ord("A"));
			break;
			
		case INPUT.rightPressed:
			_input = keyboard_check_pressed(ord("D"));
			break;
			
		case INPUT.jumpPressed:
			_input = keyboard_check_pressed(vk_space);
			break;
			
		case INPUT.jumpReleased:
			_input = keyboard_check_released(vk_space);
			break;
			
		case INPUT.jump:
			_input = keyboard_check(vk_space);
			break;
			
		case INPUT.horizontalAxis:
			_input = GetInput(INPUT.right) - GetInput(INPUT.left);
			break;
			
		case INPUT.verticalAxis:
			_input = GetInput(INPUT.down) - GetInput(INPUT.up);
			break;
			
		case INPUT.shootPressed:
			_input = keyboard_check_pressed(ord("J"));
			break;
		
		case INPUT.shoot:
			_input = keyboard_check(ord("J"));
			break;
			
		case INPUT.shootReleased:
			_input = keyboard_check_released(ord("J"));
			break;
			
		case INPUT.specialPressed:
			_input = keyboard_check_pressed(ord("K"));
			break;
			
		case INPUT.special:
			_input = keyboard_check(ord("K"));
			break;
			
		case INPUT.specialReleased:
			_input = keyboard_check_released(ord("K"));
			break;
			
		case INPUT.savePressed:
			_input = keyboard_check_pressed(ord("9"));
			break;
			
		case INPUT.loadPressed:
			_input = keyboard_check_pressed(ord("0"));
			break;
			
		case INPUT.grapplePressed:
			_input = keyboard_check_pressed(ord("I"));
			break;
	}
	
	return _input;
}