/// destroy the server
network_destroy(server);
buffer_delete(bufferSend);
ds_list_destroy(socketlist);
ds_map_destroy(clientMap);

