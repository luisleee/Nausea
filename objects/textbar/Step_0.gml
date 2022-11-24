/// typewriter effect
if (char_count < string_length(current_text)) {
	var punc_halt = get_halt_time(string_char_at(current_text, char_count));
	var pre_floor = floor(char_count);
	char_count += char_spd / punc_halt;
	var post_floor = floor(char_count);
	if(pre_floor != post_floor){
		if (post_floor % 2 == 0) {
			audio_play_sound(snd_sfx_text, 0, 0);
		}
	}
}
