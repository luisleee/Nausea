function text_fill_screen(str, str_scale, scr_l, mode){
	filled_str = str;
	if mode == "v" {
		while(string_height(filled_str) * str_scale < scr_l * 2) {
			filled_str += "\n" + str;
		}
	}
	if mode == "h" {
		while(string_width(filled_str) * str_scale < scr_l * 2) {
			filled_str += " " + str;
		}
	}
	return filled_str;
}