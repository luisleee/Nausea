function string_chars(str) {
	var arr = [];
	for (var i = 1; i <= string_length(str); i++) {
		array_push(arr, string_char_at(str, i));
	}
	return arr;
}