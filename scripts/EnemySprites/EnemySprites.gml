// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EnemySprites(){

}

//Enemy Sprites
enum ESPRITE
{
	drone,
	shrimpGun,
	droneGun,
	beta
}

function GetSprite(_spriteName)
{
	switch(_spriteName)
	{
		case "spr_drone": return spr_drone;
		case "spr_shrimp_gun": return spr_shrimp_gun;
		case "spr_drone_gun": return spr_drone_gun;
		case "spr_enemy_beta": return spr_enemy_beta;
	}
	
	return spr_player;
}