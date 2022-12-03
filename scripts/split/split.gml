/// @desc Split string with single-character separator
/// @param {string} str Source string
/// @param {string} separator Single-character separator
/// @returns {array<string>} Splited strings
function split(str, separator) {
	var cur_str = "";
	var strs = [];
	for (var i = 1; i <= string_length(str); i++) {
		var ch = string_char_at(str, i);
		if (ch == separator) {
			array_push(strs, cur_str);
			cur_str = "";
		} else {
			cur_str += ch;
		}
	}
	if (cur_str != "") {
		array_push(strs, cur_str);
	}
	return strs;
}