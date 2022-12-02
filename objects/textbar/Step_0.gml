/// typewriter effect
char_count = floor(char_real_count);

if (char_count < string_length(current_text)) {
	var punc_halt = get_halt_time(string_char_at(current_text, char_count));
	var pre_floor = floor(char_real_count);
	char_real_count += char_spd / punc_halt;
	var post_floor = floor(char_real_count);
	if(pre_floor != post_floor){
		if (char_count % 2 == 0) {
			audio_play_sound(snd_sfx_text, 0, 0);
		}
	}
}

subimg += 0.2;
