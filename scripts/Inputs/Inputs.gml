///Inputs(client, key, bool);
var client = argument0;
var key = argument1;
var pressed = argument2;

		buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
		buffer_write(objServer.bufferSend, buffer_u8, networkEvents.input);
		buffer_write(objServer.bufferSend, buffer_u16, client);
		buffer_write(objServer.bufferSend, buffer_u8, key);		
		buffer_write(objServer.bufferSend, buffer_bool, pressed);
		
		with (objClient){
			if client_id != client {
				network_send_packet(self.socket_id, objServer.bufferSend, buffer_tell(objServer.bufferSend));
			}
		}
