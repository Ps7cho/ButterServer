/// check for clients and data

var type_event = ds_map_find_value(async_load, "type");
switch(type_event){



	case network_type_connect:
		ServerHandleConnect(async_load[? "socket"]);
		var socket = ds_map_find_value(async_load, "socket")
		ds_list_add(socketlist, socket);
	break;
	
	
	
	case network_type_data:
			var buffer = ds_map_find_value(async_load, "buffer");
			var socket_id = ds_map_find_value(async_load, "id");
			buffer_seek(bufferSend, buffer_seek_start, 0);
			receivedPacket(buffer, socket_id);
	break;
	
	
	
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket");
		var findsocket = ds_list_find_index(socketlist, socket);
			buffer_seek(bufferSend, buffer_seek_start, 0);
			buffer_write(bufferSend, buffer_u8, networkEvents.disconnect);
			buffer_write(bufferSend, buffer_u16, clientMap[? string(socket)].client_id);
			
			with(objClient){
				network_send_packet(self.socket_id, other.bufferSend, buffer_tell(other.bufferSend));
			}	

			
			
		if (findsocket >=0) {
			ds_list_delete(socketlist, findsocket);
		}
		with (clientMap[? (string(socket))]){
			instance_destroy();
		}
		ds_map_delete(clientMap, string(socket));
		
	break;	
}
