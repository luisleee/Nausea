/// @desc Split string with single-character seperator
/// @param {string} str Source string
/// @param {string} seperator Single-character seperator
/// @returns {array<string>} Splited strings
function split(str, seperator) {
	var cur_str = "";
	var strs = [];
	for (var i = 1; i <= string_length(str); i++) {
		var ch = string_char_at(str, i);
		if (ch == seperator) {
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