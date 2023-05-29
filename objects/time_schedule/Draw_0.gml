gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
bar_sep = 100;
bar_h = 30;
block_w = 80;
block_h = 100;
block_sep = 20;

draw_init(fnt_default, c_white, "tl", 1);

//Draw the bar
draw_rectangle(bar_sep, gui_h/2 - bar_h/2, gui_w - bar_sep, gui_h/2 + bar_h/2, 0);
var time_scale = (gui_w - 2 * bar_sep) / (time_bar[1] - time_bar[0]);
var now_bar_off = 0;
for (var i = 0; i < array_length(schedule); i++) {
	draw_set_color(c_red);
	draw_rectangle(
		bar_sep + now_bar_off,
		gui_h/2 - bar_h/2,
		bar_sep + now_bar_off + schedule[i].duration * time_scale,
		gui_h/2 + bar_h/2,
		0
	);
	draw_set_color(c_black);
	draw_rectangle(
		bar_sep + now_bar_off + schedule[i].duration * time_scale - 5,
		gui_h/2 - bar_h/2,
		bar_sep + now_bar_off + schedule[i].duration * time_scale,
		gui_h/2 + bar_h/2,
		0
	)
	now_bar_off += schedule[i].duration * time_scale;
}

hovering_block = undefined;
var line_max_block = floor((gui_w - 2 * bar_sep) / (block_w + block_sep));
for (var i = 0; i < block_num; i ++) {
	var h_pos = i % line_max_block;
	var v_pos = get_quotient(i, line_max_block);
	var col = block_selected[i] ? c_gray : c_white;
	draw_set_color(col);
	draw_rectangle(
	bar_sep + h_pos * (block_w + block_sep),
	bar_sep + gui_h/2 + v_pos * (block_h + block_sep),
	bar_sep + h_pos * (block_w + block_sep) + block_w,
	bar_sep + gui_h/2 + block_h + v_pos * (block_h + block_sep),
	0
	);
	
	if (is_in_interval(
			mouse_x,
			bar_sep + h_pos * (block_w + block_sep),
			bar_sep + h_pos * (block_w + block_sep) + block_w,
			1)
		and
		is_in_interval(
			mouse_y,
			bar_sep + gui_h/2 + v_pos * (block_h + block_sep),
			bar_sep + gui_h/2 + block_h + v_pos * (block_h + block_sep),
			1)
		) {
			hovering_block = i;
		}
}

draw_set_color(c_white);
if(hovering_block != undefined) {
	draw_text_transformed(
		100,
		100,
		optional_blocks[hovering_block].name + " " + string(optional_blocks[hovering_block].duration) + "小时",
		4,
		4,
		0
	);
}
