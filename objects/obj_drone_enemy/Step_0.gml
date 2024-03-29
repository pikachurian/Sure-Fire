CheckBulletHit();
UpdateSprite();
UpdateForce();

switch(state)
{
	case ES.setup:
		//LoadData(obj_json.saveData.droneEnemy);
		ChangeState(ES.setRoamGoal);
		break;
		
	case ES.setRoamGoal:
		UpdateWaypoints();
		GotoWaypoint(waypointOn);
		ChangeState(ES.roam);
		
		DetectPlayer();
		break;
		
	case ES.roam:
		MoveTowardsPoint(goalX, goalY);
		
		//Quit movement if reached goal.
		if(point_distance(x, y, goalX, goalY) <= 4)
		{
			Wait(ES.setRoamGoal, random_range(waitTimeMin, waitTimeMax));
			IncrementWaypointIndex();
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
		/*else if(point_distance(x, y, obj_player.x, obj_player.y) < fleePlayerRange)
		{
			//Run away from player.
			var _dir = point_direction(obj_player.x, obj_player.y, x, y);
			var _goalX = x + lengthdir_x(spd, _dir);
			var _goalY = y + lengthdir_y(spd, _dir);
			MoveTowardsPoint(_goalX, _goalY);
		}*/
		
		//Stop chasing if out of range.
		if(point_distance(x, y, obj_player.x, obj_player.y) > detectPlayerRange)
		{
			Wait(ES.setRoamGoal, waitTimeMax * 0.8);
		}
		
		Hover();
		//Update shoot and aim.
		break;
		
	case ES.dead:
		ApplyGravity();
		MoveAndSlide();
		break;
}

lastX = x;
lastY = y;