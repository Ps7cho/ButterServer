///UpdateHealth(client);
var client = argument0;
var knockback = argument1

buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
buffer_write(objServer.bufferSend, buffer_u8, networkEvents.hit);
buffer_write(objServer.bufferSend, buffer_u16, client.client_id);
buffer_write(objServer.bufferSend, buffer_u16, travelDirection);
buffer_write(objServer.bufferSend, buffer_u8, knockback);
buffer_write(objServer.bufferSend, buffer_bool, client.stunned);

with(objClient){
	network_send_packet(self.socket_id,	objServer.bufferSend, buffer_tell(objServer.bufferSend));
}
