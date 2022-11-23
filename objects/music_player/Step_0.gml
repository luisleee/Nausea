/// play on loop
// play the intro
var intro_len_in_ms = music_len_in_ms(cur_music.bpm, cur_music.intro_beats);
var main_len_in_ms = music_len_in_ms(cur_music.bpm, cur_music.main_beats);
var delta = current_time - start_time;

if (intro_play_process == playState.before) {
	audio_play_sound(cur_music.intro, 0, 0);
	intro_play_process = playState.playing;
}

if (intro_play_process == playState.playing) {
	if (delta >= intro_len_in_ms) {
		audio_play_sound(cur_music.main, 0, 0);
		start_time = current_time;
		intro_play_process = playState.played;
	}
}

if (intro_play_process == playState.played) {
	if (delta >= main_len_in_ms) {
		audio_play_sound(cur_music.main, 0, 0);
		start_time = current_time;
	}
}
