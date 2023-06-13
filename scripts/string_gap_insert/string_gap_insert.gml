function string_gap_insert(str, in){
	var chars = string_chars(str);
	return array_join(chars, in);
}