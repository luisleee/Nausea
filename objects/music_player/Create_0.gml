enum playState{
	before,
	playing,
	played,
}

function set_music(music_piece) {
	cur_music = music_piece;
	intro_play_process = playState.before;
	start_time = current_time;
}
