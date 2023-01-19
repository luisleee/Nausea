if (!show_self) {
	exit;
}

/// typewriter effect
char_count = floor(char_real_count);

if (char_count < string_length(raw_text)) {
	var punc_halt = get_halt_time(string_char_at(raw_text, char_count));
	var effect_halt = text_effects[char_count].halt;
	var total_halt = punc_halt + effect_halt;
	char_real_count += char_spd / total_halt;
	var new_char_count = floor(char_real_count);
	if (char_count != new_char_count) {
		if (total_halt > 1 or char_count % 2 == 0) {
			audio_play_sound(snd_sfx_text, 0, 0);
		}
	}
}

if (is_fully_displayed() and auto_play and alarm_get(0) == -1) {
	alarm_set(0, fps);
}

subimg += 0.2;
