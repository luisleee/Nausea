enum playState{
	notPlaying,
	before,
	playing,
	played,
}

intro_play_process = playState.notPlaying;

function set_music(music_piece) {
	cur_music = music_piece;
	intro_play_process = playState.before;
	start_time = current_time;
}

