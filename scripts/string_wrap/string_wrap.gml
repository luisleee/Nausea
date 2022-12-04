/// @desc Wrap a string with punctuation
/// @param {string} str The string
/// @param {real} width Maximum width of the string
/// @param {real} str_scale String scale
/// @returns {string} Wrapped string
function string_wrap(str, width, str_scale) {
	var wrapped_text = "";
	var total_width = 0;
	var char_w = string_width("啊") * str_scale;
	for (var i = 1; i <= string_length(str); i++) {
		var next_char = string_char_at(str, i);
		if(next_char == "\n"){
			total_width = 0;
		}
		if(next_char != "\n"){
			if (total_width * str_scale >= width - char_w / 2) {
				if (not is_punctuation(next_char)) {
					wrapped_text += "^";
					total_width = 0;
				}
			}
			total_width += string_width(next_char);
		}
		wrapped_text += next_char;	
	}
	return wrapped_text;
}