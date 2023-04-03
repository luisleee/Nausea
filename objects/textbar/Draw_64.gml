//draw transition
draw_set_alpha(trans_apa);
if (trans_pattern == "color_fade") {
	var col = variable_struct_get(trans_infos, "color");
	draw_set_color(make_color_rgb(col[0], col[1], col[2]));
}
draw_rectangle(0, 0, display_w, display_h, 0);