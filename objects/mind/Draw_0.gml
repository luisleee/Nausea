var display_w = display_get_gui_width();
var display_h = display_get_gui_height();
var text_scale = 3.5/1600 * display_w;

draw_init(fnt_default, c_white, "mc", 1);

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
		}
	
	}
	//draw the symbols
	draw_set_alpha(apa);
	
	if (data_recorder.mind_symbols_unlocked[i]) {
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
draw_surface(showcase_surface, x, y);



if not show_self {
	exit;
}


// draw the hovering one's description
// todo: extract functions


if (now_hover_num != undefined and apa == 1 and data_recorder.mind_symbols_unlocked[now_hover_num]) {
	draw_init(fnt_default, c_white, "mc", 1);
	var hover_symbol = global.mind_symbols[now_hover_num];

	var show_text = split(hover_symbol.full_desc(), "、");
	draw_text_transformed(mouse_x, mouse_y, show_text, text_scale, text_scale, 0);
/*	for (var i = 0; i < array_length(data_recorder.ms_marks); i++) {
		var this_mark = data_recorder.ms_marks[i];
		var mark2desc = {
			no: "desc",
			un: "un_desc",
			re: "re_desc",
			val: "val_desc"
		};
		if (this_mark == "no") {
			var descs = split(hover_symbol.desc, "、");
			for (var j = 0; j < array_length(descs); j++) {
				draw_text_transformed(mouse_x + j * 60, mouse_y, descs[j], text_scale, text_scale, 0);
			}
		} else {
			var col = get_ms_color(spr_ms_marks, i - 1);
			draw_set_color(col);
			var descs = split(variable_struct_get(hover_symbol, variable_struct_get(mark2desc, this_mark)), "、");
			for (var j = 0; j < array_length(descs); j++) {
				if (descs[j] != "undefined") {
					draw_text_transformed(mouse_x + j * 60, mouse_y + i * 60, descs[j], text_scale, text_scale, 0);
				}
			}
			
		}
	}
	*/
	
	//add the hovering one if pressed
	if (mouse_check_button_pressed(mb_left)) {
		var now_placement = placement[now_placing_num];
		if (!is_undefined(now_placement) && now_placement.spr == hover_symbol.spr) {
			var available_marks = now_placement.symbol.available_marks();
			var _len = array_length(available_marks);
			if (array_length(available_marks) != 1) {
				var idx = array_find_item(available_marks, now_placement.mark);
				var next_mark = available_marks[(idx + 1) % _len];
				now_placement.mark = next_mark;
				
				var sounds = {
					no: snd_sfx_ms_remove,
					un: snd_sfx_ms_un,
					re: snd_sfx_ms_re,
					val: snd_sfx_ms_val,
				}
				var snd = variable_struct_get(sounds, next_mark);
				audio_play_sound(snd, 0, 0);
			}
		} else {
			placement[now_placing_num] = new AnswerSymbol(hover_symbol, "no");
			display_particle(get_ms_color(hover_symbol.spr));
			audio_play_sound(snd_sfx_ms_place, 0, 0);
		}
	}
}

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
			
			var mark2index = {
				no: 0,
				un: 1,
				re: 2,
				val: 3,
			}
			var ms_mask_index = variable_struct_get(mark2index, placement[i].mark);
			
			draw_answer_symbol(spr_ms_masks, ms_mask_index, i);
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

