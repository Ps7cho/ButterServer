/// @description 
var move_xinput = 0;
var move_yinput = 0;


if stunned {
	var object = collision_circle( x, y, 10, objClient, true, true);
	if object != noone {
		x = room_width/2;
		y = room_height/2;
		alarm[0] = 1;
		stunned = false;
		Stunned(client_id, stunned);
		object.points ++;
		updateScoreBoard();
	}
}


for ( var i = 0; i < array_length_1d(movement_inputs); i++){
    var this_key = movement_inputs[i];
    if keyboard_check(this_key) {
        var this_angle = i*90;
        move_xinput += lengthdir_x(1, this_angle);
        move_yinput += lengthdir_y(1, this_angle);
    }
}
 
var moving = ( point_distance(0,0,move_xinput,move_yinput) > 0 );
if moving  {
	if !stunned{
	    var move_dir = point_direction(0,0,move_xinput,move_yinput);
	    move(move_speed*global.seconds_passed,  move_dir);
	}
}


		buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
		buffer_write(objServer.bufferSend, buffer_u8, networkEvents.position);
		buffer_write(objServer.bufferSend, buffer_u16, client_id);
		buffer_write(objServer.bufferSend, buffer_u16, x);
		buffer_write(objServer.bufferSend, buffer_u16, y);
		buffer_write(objServer.bufferSend, buffer_bool, stunned);
		
		with objClient{
			network_send_packet(self.socket_id, objServer.bufferSend, buffer_tell(objServer.bufferSend));
		}