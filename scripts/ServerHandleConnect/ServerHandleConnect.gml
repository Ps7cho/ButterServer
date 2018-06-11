///ServerHandleConnect(socket_id);
var socket_id = argument0;


//Spawn points loop;
var startx = (room_width/2);
var starty = (room_height/2);

l = instance_create_layer(startx, starty, "Instances", objClient);
l.socket_id = socket_id;
l.client_id = client_id_counter++;
//l.teamNumber = team.teamNumber;
//l.Team = team.teamNumber;

if (client_id_counter >= 65000){
	client_id_counter = 0;
}

clientMap[? string(socket_id)] = l;

var client_id_current = clientMap[? string(socket_id)].client_id;

	buffer_seek(bufferSend, buffer_seek_start, 0);
	buffer_write(bufferSend, buffer_u8, networkEvents.initialConnect);
	buffer_write(bufferSend, buffer_u16, client_id_current);
	buffer_write(bufferSend, buffer_u16, startx);
	buffer_write(bufferSend, buffer_u16, starty);
	network_send_packet(socket_id, bufferSend, buffer_tell(bufferSend));
	
// tell each client to make this new player
	buffer_seek(bufferSend, buffer_seek_start, 0);
	buffer_write(bufferSend, buffer_u8, networkEvents.connect);
	buffer_write(bufferSend, buffer_u16, client_id_current);
	buffer_write(bufferSend, buffer_u16, startx);
	buffer_write(bufferSend, buffer_u16, starty);
	
	with(objClient){
		if self.socket_id != socket_id{
			network_send_packet(self.socket_id, other.bufferSend, buffer_tell(other.bufferSend));
		}
	}
	
		//Make all the players.
	if instance_exists(objClient){
		with objClient{
			if self.socket_id != socket_id{
				buffer_seek(other.bufferSend, buffer_seek_start, 0);
				buffer_write(other.bufferSend, buffer_u8, networkEvents.connect);
				buffer_write(other.bufferSend, buffer_u16, client_id);
				buffer_write(other.bufferSend, buffer_u16, x);
				buffer_write(other.bufferSend, buffer_u16, y);
			
				network_send_packet(socket_id, other.bufferSend, buffer_tell(other.bufferSend));
				
				buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
				buffer_write(objServer.bufferSend, buffer_u8, networkEvents.name);
				buffer_write(objServer.bufferSend, buffer_u16, client_id);
				buffer_write(objServer.bufferSend, buffer_string, name);
				
				network_send_packet(socket_id, other.bufferSend, buffer_tell(other.bufferSend));
			}
		}
	}


	with objClient {
	//UpdateHealth(id);	
	}
	

	
	//Build all the buildings
	if instance_exists(objBuildingParent){
		with (objBuildingParent){
			buffer_seek(other.bufferSend, buffer_seek_start, 0);
			buffer_write(other.bufferSend, buffer_u8, networkEvents.building);
			buffer_write(other.bufferSend, buffer_u8, buildingType); //Building type (building.Generic)
			buffer_write(other.bufferSend, buffer_u16, x);
			buffer_write(other.bufferSend, buffer_u16, y);
			buffer_write(other.bufferSend, buffer_u16, id);
			
			network_send_packet(socket_id, other.bufferSend, buffer_tell(other.bufferSend));
		}
	}
	/*
	//Build all the Resources
	if instance_exists(objResourceParent){
		with (objResourceParent){
			buffer_seek(other.bufferSend, buffer_seek_start, 0);
			buffer_write(other.bufferSend, buffer_u8, networkEvents.building);
			buffer_write(other.bufferSend, buffer_u8, buildingType); //Building type (building.Generic)
			buffer_write(other.bufferSend, buffer_u16, x);
			buffer_write(other.bufferSend, buffer_u16, y);
			buffer_write(other.bufferSend, buffer_u16, id);
			buffer_write(other.bufferSend, buffer_s8, Team);
			buffer_write(other.bufferSend, buffer_u16, team.Credits);
			
			network_send_packet(socket_id, other.bufferSend, buffer_tell(other.bufferSend));
		}
	}
	*/
		//Build all the Walls
	if instance_exists(objWall){
		with (objWall){
			buffer_seek(other.bufferSend, buffer_seek_start, 0);
			buffer_write(other.bufferSend, buffer_u8, networkEvents.building);
			buffer_write(other.bufferSend, buffer_u8, buildingType); //Building type (building.Generic)
			buffer_write(other.bufferSend, buffer_u16, x);
			buffer_write(other.bufferSend, buffer_u16, y);
			buffer_write(other.bufferSend, buffer_u16, id);
			//buffer_write(other.bufferSend, buffer_s8, Team);
			//buffer_write(other.bufferSend, buffer_u16, team.Credits);
			
			network_send_packet(socket_id, other.bufferSend, buffer_tell(other.bufferSend));
		}
	}
	/*
		//Build all the Robots
	if instance_exists(objRobot){
		with (objRobot){
			scrRobot(x,y,Team,target, true, id);
		}
	}
	*/
	

