music_pieces = [new BackgroundMusic("day", snd_ost_day_intro, snd_ost_day_main, 2 * 3, 32 * 3, 93)];
volume = 0.1;

function get_music_by_name(name) {
	var len = array_length(music_pieces);
	for (var i = 0; i < len; i++) {
		if (music_pieces[i].name == name) {
			return music_pieces[i];
		}
	}
	return undefined;
}

function set_music(name) {
	var music = get_music_by_name(name);
	assert("Music is available", !is_undefined(music))
	cur_music = music;
	intro_play_process = PLAY_STATE.BEFORE;
	start_time = current_time;
}

enum PLAY_STATE{
	NOT_PLAYING,
	BEFORE,
	PLAYING,
	PLAYED,
}

intro_play_process = PLAY_STATE.NOT_PLAYING;
cur_music = undefined;
start_time = current_time;