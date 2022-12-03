/// @desc Get halt time depending on whether the char is a punctuation.
/// @param {any*} the char to judge
/// @returns {real} halt value
function get_halt_time(char) {
	var halt = 1;
	var halt_puncs = ["。", "，", "！", "？", "…", "—", "：", "；"];
	if (array_includes(halt_puncs, char)) {
		halt = 6;
	}
	return halt;
}
