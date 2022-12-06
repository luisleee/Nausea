
for (var i = 0; i < array_length(vars); i++){
	draw_init(fnt_test, c_black, "tl", 1);
	draw_text_transformed(103, 103 + 50 * i, vars[i].name + ": " + string(vars[i].val), 4, 4, 0);
	draw_set_color(c_white);
	draw_text_transformed(100, 100 + 50 * i, vars[i].name + ": " + string(vars[i].val), 4, 4, 0);
}