///DestroyBullet(BulletID);
var bullet = argument0;

buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
buffer_write(objServer.bufferSend, buffer_u8, networkEvents.bullet);
buffer_write(objServer.bufferSend, buffer_u16, bullet);
		
with(objClient){
	network_send_packet(self.socket_id,	objServer.bufferSend, buffer_tell(objServer.bufferSend));
}
