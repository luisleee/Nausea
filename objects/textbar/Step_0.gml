/// typewriter effect
if (char_count < string_length(current_text)) {
	char_count += char_spd;
	if (char_count % 2 == 0) {
		audio_play_sound(snd_sfx_text, 0, 0);
	}
}
