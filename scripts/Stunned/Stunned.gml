///Stunned();

var client = argument0;
var stunned = argument1;


buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
buffer_write(objServer.bufferSend, buffer_u8, networkEvents.stunned);
buffer_write(objServer.bufferSend, buffer_u8, client);
buffer_write(objServer.bufferSend, buffer_bool, stunned);

with objClient{
	network_send_packet(self.socket_id, objServer.bufferSend, buffer_tell(objServer.bufferSend));
}