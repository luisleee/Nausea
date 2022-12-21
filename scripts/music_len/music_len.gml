/// @desc Calculate the length of a piece of music in microseconds
/// @param {real} bpm The BPM of music
/// @param {real} beats The length of music in beats
/// @returns {real} The length of music in ms
function music_len_in_ms(bpm, beats) {
	return beats * 60 * 1000 / bpm;
}