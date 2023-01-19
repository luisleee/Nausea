music_pieces = [
	new BackgroundMusic("day", snd_ost_day_intro, snd_ost_day_main, 2 * 3, 32 * 3, 93),
	new BackgroundMusic("road", undefined, snd_ost_on_the_road, 0, 16 * 4, 108),
];
volume = 1;

function get_music_by_name(name) {
	var len = array_length(music_pieces);
	for (var i = 0; i < len; i++) {
		if (music_pieces[i].name == name) {
			return music_pieces[i];
		}
	}
	return undefined;
}

intro_play_process = PLAY_STATE.NOT_PLAYING;
cur_music = undefined;
start_time = current_time;
cur_track = noone;

function set_music(name) {
	var music = get_music_by_name(name);
	assert("Music is available", !is_undefined(music));
	
	audio_stop_sound(cur_track);
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

