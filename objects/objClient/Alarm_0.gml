/// @description Rubberband check

		buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
		buffer_write(objServer.bufferSend, buffer_u8, networkEvents.rubberband);
		buffer_write(objServer.bufferSend, buffer_u16, client_id);
		buffer_write(objServer.bufferSend, buffer_u16, x);
		buffer_write(objServer.bufferSend, buffer_u16, y);
		buffer_write(objServer.bufferSend, buffer_u8, ruberband); //Distance for rubberband <255
		
		network_send_packet(socket_id, objServer.bufferSend, buffer_tell(objServer.bufferSend));
		
		
		
	alarm[0] = 60;
	

