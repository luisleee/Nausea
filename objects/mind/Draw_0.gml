var display_w = display_get_gui_width();
var display_h = display_get_gui_height();
var text_scale = 3.5/1600 * display_w;

draw_init(fnt_default, c_white, "mc", 1);

var last_hover_num = now_hover_num;
now_hover_num = undefined;

if (!surface_exists(showcase_surface)) {
	showcase_surface = surface_create(max_number_w * (symbol_w + sep_w), 2.2 * (symbol_h + sep_h));
}

surface_set_target(showcase_surface);
draw_clear_alpha(c_white, 0);

for (var i = 0; i < symbol_number; i++) {
	var this_symbol = global.mind_symbols[i];
	
	var xoffset = (symbol_w + sep_w) * (i % max_number_w);
	var yoffset = (symbol_h + sep_h) * floor(i / max_number_w) - showcase_scroll_offset;
	
	
	if (mouse_in_surface()) {
		//detect now hovering one
		if (point_in_rectangle(
			mouse_x,
			mouse_y,
			x + xoffset,
			y + yoffset,
			x + xoffset + symbol_w,
			y + yoffset + symbol_h
		)) {
			now_hover_num = i;
			if (now_hover_num != last_hover_num) {
				des_reset();
			}
		}
	
	}
	
	


	//draw the symbols
	draw_set_alpha(apa);
	
	if (data_recorder.symbol_unlocked(i)) {
		draw_symbol(spr_ms_background, 0, xoffset, yoffset);
		draw_symbol(this_symbol.spr, 0, xoffset, yoffset);
		draw_symbol(spr_ms_frame, 0, xoffset, yoffset);
	
		//draw the marks
		var marks = this_symbol.available_marks();
		var draw_mark_index = array_map(marks, function(mk) {
			var mark2index = {
				no: -1,
				un: 0,
				re: 1,
				val: 2,
			};
			return variable_struct_get(mark2index, mk);
		});
		
		for (var j = 0; j < array_length(draw_mark_index); j++) {
			var idx = draw_mark_index[j];
			if (idx != -1) {
				draw_symbol(spr_ms_marks, idx, xoffset, yoffset);
			}
		}
	}
}
gpu_set_blendmode(bm_subtract);
var offset_max_h = showcase_height - surface_height;
draw_sprite_stretched(spr_showcase_mask, 1, 0, 0, surface_width, showcase_shadow_h);
draw_sprite_stretched(spr_showcase_mask, 0, 0, surface_height, surface_width, showcase_shadow_h);


gpu_set_blendmode(bm_normal);
surface_reset_target();




if not show_self {
	exit;
}


//Draw the Descriptions
var desc_scale = text_scale;

if (now_hover_num != undefined and apa == 1 and data_recorder.mind_symbols_unlocked[now_hover_num]) {
	draw_init(fnt_mind_desc, c_white, "tl", 1);
	var hover_symbol = global.mind_symbols[now_hover_num];

	var raw_text = hover_symbol.wordsonly_desc();
	var desc_words_hor = string_split(raw_text, " ");
	raw_text = string_gap_insert(raw_text, "\n"); 
	var raw_desc_words = string_split(raw_text, "\n \n");
	var desc_words = string_split(raw_text, "\n \n");
	//show_debug_message(raw_desc_words)
	
	var show_text = text_fill_screen(raw_text, desc_scale/2, display_h, "v");
	for (var i = 0; i < text_fill_screen_num(raw_text, desc_scale/2, display_h, "v"); i ++) {
		desc_words = array_concat(desc_words, raw_desc_words);
	}
	//show_debug_message(": " + show_text)
	//show_debug_message(desc_words)
	
	for (var i = 0; i < des_column; i ++) {
		draw_set_color(c_lime)
		
		var y_drawn = 0;
	
		draw_set_alpha(1);
		for (var j = 0; j < array_length(desc_words); j++) {
			var word_num = array_length(raw_desc_words);
			var now_word_num = j % word_num;
			draw_set_color(c_white);
			
			if (string_pos(desc_words_hor[now_word_num], hover_symbol.re_desc)) {
				draw_set_color(c_blue);
			}
			if (string_pos(desc_words_hor[now_word_num], hover_symbol.un_desc)) {
				draw_set_color(c_red);
			}
			if (string_pos(desc_words_hor[now_word_num], hover_symbol.val_desc)) {
				draw_set_color(c_yellow);
			}
			var a = sin(0.02 * des_t + des_apa_offset[i] + now_word_num * 2 * pi/3); //-1<=a<=1
	
			draw_set_alpha((a + 1)/3);
			draw_text_transformed(
				display_w/(des_column) * (i) + (display_w/(des_column) - string_width("我") * desc_scale)/2,
				des_y[i] + y_drawn,
				desc_words[j],
				desc_scale,
				desc_scale,
				0
			);
			y_drawn += string_height(desc_words[j] + "\n ") * desc_scale;
		}
		draw_set_alpha(1)
			
		
		des_y[i] += des_spd[i];
		if (des_y[i] > 0) {
			des_y[i] -= string_height(raw_text + "\n\n") * desc_scale;
		}
		if (des_y[i] + string_height(show_text + "\n\n") * desc_scale < display_h) {
			des_y[i] += string_height(raw_text + "\n\n") * desc_scale;
		}
	}
	
}

if (is_hovering_on()) {
	draw_init(fnt_default, c_white, "mc", 1);
	var hover_symbol = data_recorder.get_symbol(now_hover_num);

	// add the hovering one if pressed
	if (mouse_check_button_pressed(mb_left)) {
		var now_placement = placement[now_placing_num];
		if (!is_undefined(now_placement) && now_placement.spr == hover_symbol.spr) {

			var available_marks = now_placement.symbol.available_marks();
			if (array_length(available_marks) != 1) {
				var next_mark = now_placement.symbol.next_available_mark(now_placement.mark);
				now_placement.mark = next_mark;
				
				play_sound_of_mark(next_mark);
			}
		} else {
			placement[now_placing_num] = new AnswerSymbol(hover_symbol, "no");
			display_particle(get_ms_color(hover_symbol.spr));
			audio_play_sound(snd_sfx_ms_place, 0, 0);
		}
	}
}

//Draw the showcase surface
draw_surface(showcase_surface, x, y);

if (answer_mode) {
	//draw the answering place
	var xori = (room_width - max_concept_num * (symbol_w + answer_sep_w) + answer_sep_w)/2;
	var yori = answer_place_y;
	draw_set_alpha(1);
	for (var i = 0; i < max_concept_num; i++) {
		if (i != now_placing_num) {
			draw_answer_symbol(spr_ms_void, 0, i);
		}
		
		if (placement[i] != undefined) {
			draw_answer_symbol(spr_ms_background, 0, i);
			draw_answer_symbol(placement[i].spr, 0, i);
			
			draw_ith_mask(i);
			draw_answer_symbol(spr_ms_frame, 0, i);
		}
		
		if (i == now_placing_num) {
			var spr = placement[i] == undefined ? spr_ms_void_placing : spr_ms_placed;
			draw_answer_symbol(spr, image_index, i);
		}
	}
	//draw the answer
	var yoffset_goal = display_h/2 - judge_display_y;
	var zoom_channel = animcurve_get_channel(ac_textbar_mind, 0);
	var judge_display_yoffset = animcurve_channel_evaluate(zoom_channel, judge_process) * yoffset_goal;
	
	draw_set_color(c_white);
	draw_text_transformed(
		room_width/2,
		judge_display_y + judge_display_yoffset,
		judge_display,
		text_scale,
		text_scale,
		0
	);
}

