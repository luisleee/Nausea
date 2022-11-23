///play on loop
//play the intro
if(intro_play_process == playState.before){
	audio_play_sound(cur_music.intro, 0, 0);
	intro_play_process = playState.playing;
}

if(intro_play_process == playState.playing){
	if(current_time - cur_time >= cur_music.intro_len * 60000/cur_music.bpm){
		audio_play_sound(cur_music.main,0,0);
		cur_time = current_time;
		intro_play_process = playState.played;
	}
}

if(intro_play_process == playState.played){
	if(current_time - cur_time >= cur_music.main_len * 60000/cur_music.bpm){
		audio_play_sound(cur_music.main,0,0);
		cur_time = current_time;
	}
}
