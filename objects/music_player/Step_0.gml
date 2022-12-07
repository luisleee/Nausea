/// play on loop
// play the intro


if (intro_play_process != PLAY_STATE.NOT_PLAYING) {
	var intro_len_in_ms = music_len_in_ms(cur_music.bpm, cur_music.intro_beats);
	var main_len_in_ms = music_len_in_ms(cur_music.bpm, cur_music.main_beats);
	var delta = current_time - start_time;
	
	if (intro_play_process == PLAY_STATE.BEFORE) {
		var s = audio_play_sound(cur_music.intro, 0, 0);
		audio_sound_gain(s, volume, 0);
		intro_play_process = PLAY_STATE.PLAYING;
		start_time = current_time;
	}
	
	if (intro_play_process == PLAY_STATE.PLAYING) {
		if (delta >= intro_len_in_ms) {
			var s = audio_play_sound(cur_music.main, 0, 0);
			audio_sound_gain(s, volume, 0);

			start_time = current_time;
			intro_play_process = PLAY_STATE.PLAYED;
		}
	}
	
	if (intro_play_process == PLAY_STATE.PLAYED) {
		if (delta >= main_len_in_ms) {
			var s = audio_play_sound(cur_music.main, 0, 0);
			audio_sound_gain(s, volume, 0);
			start_time = current_time;
		}
	}
}