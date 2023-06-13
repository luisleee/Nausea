var entries = variable_struct_get_names(vars);
array_foreach(entries, function(entry, i) {
	draw_init(fnt_default, c_black, "tl", 1);
	draw_text_transformed(103, 103 + 50 * i, entry + ": " + string(variable_struct_get(vars, entry)), 4, 4, 0);
	draw_set_color(c_white);
	draw_text_transformed(100, 100 + 50 * i, entry + ": " + string(variable_struct_get(vars, entry)), 4, 4, 0);
});