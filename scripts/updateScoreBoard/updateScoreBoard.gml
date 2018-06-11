///updateScoreBoard();

var playerList = ds_list_create();
var scoreList = ds_list_create();
with objClient{
    var playerInfo = ds_map_create();
    ds_map_add(playerInfo, "name", self.name);
    ds_map_add(playerInfo, "score", self.points);

    ds_list_add(playerList, playerInfo);
    ds_list_add(scoreList, self.points);
}

ds_list_sort(scoreList, false);

var highScoreList = ds_list_create();
var scoreListSize = ds_list_size(scoreList);
for (var i = 0; i < scoreListSize; i++) {

    for (var playerIndex = 0; playerIndex < ds_list_size(playerList); playerIndex++) {
        var scoreInList = ds_list_find_value(scoreList, i);

        var playerScore = ds_map_find_value(ds_list_find_value(playerList, playerIndex), "score");
        if scoreInList == playerScore {
            var playerToAdd = ds_list_find_value(playerList, playerIndex);
            ds_list_add(highScoreList, playerToAdd);
            ds_list_mark_as_map(highScoreList, ds_list_size(highScoreList) - 1);
            ds_list_delete(playerList, playerIndex);
            break;
        }
    }
}

var hiscoreMap = ds_map_create();
ds_map_add_list(hiscoreMap,"scores",highScoreList);
var highscoreJson = json_encode(hiscoreMap);

		buffer_seek(objServer.bufferSend, buffer_seek_start, 0);
		buffer_write(objServer.bufferSend, buffer_u8, networkEvents.highscore);
		buffer_write(objServer.bufferSend, buffer_string, highscoreJson);
		
		with objClient{
			network_send_packet(self.socket_id, objServer.bufferSend, buffer_tell(objServer.bufferSend));
		}