function text_fill_screen(str, str_scale, scr_l, mode){
	var filled_str = str;
	if mode == "v" {
		while(string_height(filled_str) * str_scale < scr_l * 2) {
			filled_str += "\n\n" + str;
		}
	}
	if mode == "h" {
		while(string_width(filled_str) * str_scale < scr_l * 2) {
			filled_str += " " + str;
		}
	}
	return filled_str;
}


function text_fill_screen_num(str, str_scale, scr_l, mode){
	var filled_str = str;
	var n = 1;
	if mode == "v" {
		while(string_height(filled_str) * str_scale < scr_l * 2) {
			filled_str += "\n\n" + str;
			n ++;
		}
	}
	if mode == "h" {
		while(string_width(filled_str) * str_scale < scr_l * 2) {
			filled_str += " " + str;
			n++;
		}
	}
	return n;
}

