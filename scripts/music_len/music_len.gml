function music_len_in_ms(bpm, beats) {
	return beats * 60 * 1000 / bpm;
}