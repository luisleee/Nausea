/// @desc Get halt time depending on whether the char is a punctuation.
/// @param {string} char The char to judge
/// @returns {real} Halt value
function get_halt_time(char) {
	var halt = 1;
	var halt_puncs = ["。", "，", "！", "？", "…", "—", "：", "；"];
	if (array_includes(halt_puncs, char)) {
		halt = 6;
	}
	return halt;
}
