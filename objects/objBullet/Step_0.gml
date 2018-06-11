/// @description Insert description here

var client = instance_place(x,y,objClient);
if (client != noone){
	/// @description Hit
	if ID != client.client_id {

		instance_destroy();
		if client.stunned = false{
			var knockBack = random_range(200, 300);
			with(client){
					var xx = client.x + lengthdir_x(knockBack, other.travelDirection);
					var yy = client.y + lengthdir_y(knockBack, other.travelDirection);
					var building = place_meeting(xx,yy,objBuildingParent);
					if building{
						client.stunned = true;
						client.alarm[2] = 180;
					}
				move_contact_solid(other.travelDirection,knockBack);
			}
			Knockback(client, knockBack);
		}
		//DestroyBullet(id);
	}
}

var building = instance_position(x,y, objBuildingParent);
if building != noone{
	
	instance_destroy();
	//UpdateHealth(client); need to update building health on all the clients
	//DestroyBullet(id);
	
}

/*
if instance_exists(objRobot){
	var robot = instance_place(x,y,objRobot);
	if robot != noone{
		if robot.Team != Team {
			robot.Health -= 20;
			if robot.Health <= 0{
				scrRobot(0,0,Team,0, -1, robot.id);	
			}
			instance_destroy();
			
			scrDestroyBullet(id);
		}
	}
}
