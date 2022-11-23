function draw_set_align(str) {
	if (string_length(str) < 2) {
		return;	
	}
	
	var letter1 = string_char_at(str, 1);
	var letter2 = string_char_at(str, 2);
	
	var val = fa_top;
	var hal = fa_left;
	switch letter1 {
		case "t":
			val = fa_top;
			break;
		case "m":
			val = fa_middle;
			break;
		case "b":
			val = fa_bottom;
			break;
	}
	switch letter2 {
		case "l":
			hal = fa_left;
			break;
		case "c":
			hal = fa_center;
			break;
		case "r":
			hal = fa_right;
			break;
	}
	
	draw_set_valign(val);
	draw_set_halign(hal);
	
}