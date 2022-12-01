enum PLAY_STATE{
	NOT_PLAYING,
	BEFORE,
	PLAYING,
	PLAYED,
}

intro_play_process = PLAY_STATE.NOT_PLAYING;

function set_music(music_piece) {
	cur_music = music_piece;
	intro_play_process = PLAY_STATE.BEFORE;
	start_time = current_time;
}

