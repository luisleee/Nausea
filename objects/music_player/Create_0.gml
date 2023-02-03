music_pieces = [
	new BackgroundMusic("day", snd_ost_day_intro, snd_ost_day_main, 2 * 3, 32 * 3, 93),
	new BackgroundMusic("road", undefined, snd_ost_on_the_road, 0, 16 * 4, 108),
	new BackgroundMusic("mind", undefined, snd_ost_mind, 0, (6 * 8 + 1 + 2) * 2, 130),
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



function music_initialize() {
	intro_play_process = PLAY_STATE.NOT_PLAYING;
	cur_music = undefined;
	start_time = current_time;
	cur_track = noone;
}
music_initialize();

function set_music(name) {
	var music = get_music_by_name(name);
	assert("Music is available", !is_undefined(music));
	
	audio_stop_sound(cur_track);
	cur_music = music;
	intro_play_process = PLAY_STATE.BEFORE;
	start_time = current_time;
}

function remove_music(remove_pattern, _others) {
	switch remove_pattern {
		case "fade":
			var fade_time = variable_struct_get(_others, "time");
			audio_sound_gain(cur_track, 0, fade_time);
			alarm[0] = fade_time;
			break;
		case "cut":
			audio_stop_sound(cur_track);
			music_initialize();
			break;
	}
}

enum PLAY_STATE{
	NOT_PLAYING,
	BEFORE,
	PLAYING,
	PLAYED,
}

