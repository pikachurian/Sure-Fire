CheckBulletHit();
UpdateSprite();
UpdateForce();

/*switch(state)
{
	case ES.setRoamGoal:
		SetNewRandomGoal();
		ChangeState(ES.roam);
		
		DetectPlayer();
		break;
		
	case ES.roam:
		MoveTowardsPoint(goalX, goalY);
		
		//Quit movement if reached goal.
		if(point_distance(x, y, goalX, goalY) <= 4)
		{
			Wait(ES.setRoamGoal, random_range(waitTimeMin, waitTimeMax));
			break;
		}
			
		
		//Quit movement if the enemy is stuck for too long.
		if(x == lastX) && (y == lastY)
		{
			stuckTick += 1;
			
			if(stuckTick >= stuckTime)
			{
				Wait(ES.setRoamGoal, random_range(waitTimeMin, waitTimeMax));
			}
		}
		
		DetectPlayer();
		break;
		
	case ES.wait:
		if(waitTick >= waitTime)
		{
			ChangeState(waitNextState);
		}else waitTick ++;
		
		DetectPlayer();
		break;
		
	case ES.chasePlayer:
		if(point_distance(x, y, obj_player.x, obj_player.y) > minPlayerRange)
			MoveTowardsPoint(obj_player.x, obj_player.y);
		
		//Stop chasing if out of range.
		if(point_distance(x, y, obj_player.x, obj_player.y) > detectPlayerRange)
		{
			Wait(ES.setRoamGoal, waitTimeMax * 0.8);
		}
		
		UpdateShootAndAim();
		break;
}*/

lastX = x;
lastY = y;