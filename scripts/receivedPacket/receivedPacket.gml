///receivedPacket(buffer, socketSelf);

var buffer = argument[0];
var socket_id = argument[1];
var msgid = buffer_read(buffer, buffer_u8)
var client_current = clientMap[? string(socket_id)];
var client_id_current = client_current.client_id;
switch(msgid){ 
//Ping
	case networkEvents.ping:
		var time = buffer_read(buffer, buffer_u32);
		
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(bufferSend, buffer_u8, networkEvents.ping);
		buffer_write(bufferSend, buffer_u32, time);
		network_send_packet(socket_id, bufferSend, buffer_tell(bufferSend));
	break;	
	
	case networkEvents.shoot:
		with(client_current){
			shooting = buffer_read(buffer, buffer_bool);
			if shooting = true{
				pointx = buffer_read(buffer, buffer_u16);
				pointy = buffer_read(buffer, buffer_u16);
			}
		}
	break;

// player inputs
	case networkEvents.input: 
		var key = buffer_read(buffer, buffer_u8);
		var pressed = buffer_read(buffer, buffer_bool);
		key = Wrap(key+2,0,3);
	//Inputs(client_id_current, key, pressed);
		with(client_current){
			movement_inputs[key] = pressed;
		}
		
	break;
	
	case networkEvents.name:
		var name = buffer_read(buffer, buffer_string);
		client_current.name = name;
		
		buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
		buffer_write(objServer.bufferSend, buffer_u8, networkEvents.name);
		buffer_write(objServer.bufferSend, buffer_u16, client_id_current);
		buffer_write(objServer.bufferSend, buffer_string, name);	
		
		with (objClient){
			network_send_packet(self.socket_id, objServer.bufferSend, buffer_tell(objServer.bufferSend));
		}
	
	break;
	
	case networkEvents.lookingDirection:
		var Dir = buffer_read(buffer, buffer_u8);
		client_current.image_index = Dir;
		
		buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
		buffer_write(objServer.bufferSend, buffer_u8, networkEvents.lookingDirection);
		buffer_write(objServer.bufferSend, buffer_u16, client_id_current);
		buffer_write(objServer.bufferSend, buffer_u8, Dir);	
		
		with (objClient){
			if client_id != client_id_current {
				network_send_packet(self.socket_id, objServer.bufferSend, buffer_tell(objServer.bufferSend));
			}
		}
	
	
	break;

// disconnect 
	case networkEvents.disconnect: 
		instance_destroy(client_current);
		//maybe save some info?   Naw
		
	break;
	
}
