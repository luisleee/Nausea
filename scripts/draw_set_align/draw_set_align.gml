/// @desc Set Align
/// @param {string} str (tmb)(lcr)
function draw_set_align(str) {
	if (string_length(str) < 2) {
		return;	
	}
	
	var letter1 = string_char_at(str, 1);
	var letter2 = string_char_at(str, 2);
	
	var vmap = {
		t: fa_top,
		m: fa_middle,
		b: fa_bottom,
	}
	var hmap = {
		l: fa_left,
		c: fa_center,
		r: fa_right,
	};
	
	var val = variable_struct_get(vmap, letter1);
	var hal = variable_struct_get(hmap, letter2);
	
	assert("Vertical align is valid", !is_undefined(val));
	assert("Horizontal align is valid", !is_undefined(hal));
	
	draw_set_valign(val);
	draw_set_halign(hal);
}