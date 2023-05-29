draw_init(fnt_char_comb, c_white, "mc", 1);


hover_num = undefined;
for (var i = 0; i < array_length(optional_char); i ++) {
	
	var xoffset = opt_char_info[i].range * sin(time * opt_char_info[i].spd + opt_char_info[i].init_phase);
	var yoffset = opt_char_info[i].range * cos(time * opt_char_info[i].spd + opt_char_info[i].init_phase);
	
	if (not opt_char_selected[i]) {
		//draw Tian Zi Ge
		draw_sprite_ext(
			spr_cc_square,
			0,
			opt_char_pos[i][0] + xoffset,
			opt_char_pos[i][1] + yoffset,
			font_get_size(fnt_char_comb)/12 * text_scale/2.5,
			font_get_size(fnt_char_comb)/12 * text_scale/2.5,
			0,
			c_white,
			1
		);
		
		//Highlight if hovering
		var square_w = sprite_get_width(spr_cc_square) * font_get_size(fnt_char_comb)/12 * text_scale/2.5;
		
		//Detect optional characters
		if (is_in_interval(mouse_x, opt_char_pos[i][0] + xoffset - square_w/2, opt_char_pos[i][0] + xoffset + square_w/2, true))
		and (is_in_interval(mouse_y, opt_char_pos[i][1] + yoffset - square_w/2, opt_char_pos[i][1] + yoffset + square_w/2, true)) {
			if(is_undefined(hover_num)){
				hover_num = i;
			}
		}
		
		if (!is_undefined(hover_num) and i == hover_num) {
			draw_set_alpha(0.5);
			draw_set_color(c_yellow);
			draw_rectangle(
				opt_char_pos[i][0] + xoffset - square_w/2,
				opt_char_pos[i][1] + yoffset - square_w/2,
				opt_char_pos[i][0] + xoffset + square_w/2,
				opt_char_pos[i][1] + yoffset + square_w/2,
				0
			);
		}
		
		
		//Draw optional characters
		draw_init(fnt_char_comb, c_white, "mc", 1);
		draw_text_transformed(
			opt_char_pos[i][0] + xoffset,
			opt_char_pos[i][1] + yoffset,
			optional_char[i],
			text_scale,
			text_scale,
			0
		);
	}
}

var answer_l = string_length(correct_str);
for (var i = 0; i < answer_l; i++) {
	//draw Tian Zi Ge
	draw_sprite_ext(
		spr_cc_square,
		0,
		dis_w/(answer_l + 1) * (i + 1),
		dis_h/2,
		font_get_size(fnt_char_comb)/12 * text_scale/2.5,
		font_get_size(fnt_char_comb)/12 * text_scale/2.5,
		0,
		c_white,
		1
	);
	
	//draw answers
	if (!is_undefined(answer_nums[i])) {
		draw_init(fnt_char_comb, c_white, "mc", 1);
		draw_text_transformed(
			dis_w/(answer_l + 1) * (i + 1),
			dis_h/2,
			optional_char[answer_nums[i]],
			text_scale,
			text_scale,
			0
		);
	}
}