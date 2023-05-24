function string_gap_insert(str, in){
	var ori_s = str;
	var re_s = "";
	for (var i = 0; i < string_length(ori_s); i++) {
		re_s += string_char_at(ori_s, i + 1);
		if (i != string_length(ori_s) - 1) {
			re_s += in;
		}
	}
	return re_s;
}