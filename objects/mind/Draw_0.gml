draw_init(fnt_default, c_white, "mc", 1);

var xoffset = 0;
var yoffset = 0;
now_hover_num = undefined;
for (var i = 0; i < symbol_number; i ++) {
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
	
	
	//draw the symbols
	draw_set_alpha(apa);
	if(data_recorder.mind_symbols_unlocked[i]) {
		draw_sprite_stretched(
			spr_ms_background,
			0,
			x + xoffset,
			y + yoffset,
			symbol_w,
			symbol_h
		);
		draw_sprite_stretched(
			global.mind_symbols[i].spr,
			0,
			x + xoffset,
			y + yoffset,
			symbol_w,
			symbol_h
		);
		draw_sprite_stretched(
			spr_ms_frame,
			0,
			x + xoffset,
			y + yoffset,
			symbol_w,
			symbol_h
		);
	
		//draw the marks
		var draw_mark_index = [];
		if (global.mind_symbols[i].un_desc != undefined) {
			array_push(draw_mark_index, 0);
		}
		if (global.mind_symbols[i].re_desc != undefined) {
			array_push(draw_mark_index, 1);
		}
		if (global.mind_symbols[i].val_desc != undefined) {
			array_push(draw_mark_index, 2);
		}
		for (var j = 0; j < array_length(draw_mark_index); j ++) {
			draw_sprite_stretched(
				spr_ms_marks,
				draw_mark_index[j],
				x + xoffset,
				y + yoffset,
				symbol_w,
				symbol_h
			);	
		}
	}
	
	//add the offsets
	xoffset += symbol_w + sep_w;
	if((i + 1) % max_number_w == 0) {
		yoffset += symbol_h + sep_h;
		xoffset = 0;
	}
}



//draw the hovering one's description
if(now_hover_num != undefined and apa == 1 and data_recorder.mind_symbols_unlocked[now_hover_num]) {
	var show_text = global.mind_symbols[now_hover_num].desc;
	if (global.mind_symbols[now_hover_num].un_desc != undefined) {
		show_text += "\n否定：" + string(global.mind_symbols[now_hover_num].un_desc);
	}
	if (global.mind_symbols[now_hover_num].re_desc != undefined) {
		show_text += "\n逆转：" + string(global.mind_symbols[now_hover_num].re_desc);
	}
	if (global.mind_symbols[now_hover_num].val_desc != undefined) {
		show_text += "\n量化：" + string(global.mind_symbols[now_hover_num].val_desc);
	}
	
	draw_text_transformed(room_width/2, 1000, show_text, 4, 4, 0);
	
	//add the hovering one if pressed
	if (mouse_check_button_pressed(mb_left)) {
		if(placement[now_placing_num] == undefined){
			placement[now_placing_num] = new AnswerSymbol(global.mind_symbols[now_hover_num], "");
			display_particle(c_red);
			audio_play_sound(snd_sfx_ms_place, 0, 0);
		} else if (placement[now_placing_num].spr == global.mind_symbols[now_hover_num].spr) {
			var marks = ["", "un", "re", "val"];
			var now_mark_num = array_length(marks);
			var now_mark = placement[now_placing_num].mark;
			for (var i = 0; i < array_length(marks); i ++) {
				if (placement[now_placing_num].mark == marks[i]) {
					now_mark_num = i;
				}
				if(i > now_mark_num) {
					switch marks[i] {
						case "un":
						if(placement[now_placing_num].un_desc != undefined) {
							placement[now_placing_num].mark = marks[i];
							i = array_length(marks);
							audio_play_sound(snd_sfx_ms_un, 0, 0);
						}
						break;
						case "re":
						if(placement[now_placing_num].re_desc != undefined) {
							placement[now_placing_num].mark = marks[i];
							i = array_length(marks);
							audio_play_sound(snd_sfx_ms_re, 0, 0);
						}
						break;
						case "val":
						if(placement[now_placing_num].val_desc != undefined) {
							placement[now_placing_num].mark = marks[i];
							i = array_length(marks);
							audio_play_sound(snd_sfx_ms_val, 0, 0);
						}
						break;
					}
				}
			}
			if (placement[now_placing_num].mark == now_mark) {
				if(now_mark != "") {
					placement[now_placing_num].mark = "";
					audio_play_sound(snd_sfx_ms_remove, 0, 0);
				}
			}
		} else {
			placement[now_placing_num] = new AnswerSymbol(global.mind_symbols[now_hover_num], "");
			display_particle(c_red);
			audio_play_sound(snd_sfx_ms_place, 0, 0);
		}
	}

}

//draw the answering place
var xori = (room_width - max_concept_num * (symbol_w + answer_sep_w) + answer_sep_w)/2;
var yori = answer_place_y;
draw_set_alpha(1);
for (var i = 0; i < max_concept_num; i ++) {
	if(i != now_placing_num) {
		draw_sprite_stretched(
			spr_ms_void,
			0,
			xori + i * (symbol_w + answer_sep_w),
			yori,
			symbol_w,
			symbol_h
		);
	}
	
	if(placement[i] != undefined) {
		draw_sprite_stretched(
			spr_ms_background,
			0,
			xori + i * (symbol_w + answer_sep_w),
			yori,
			symbol_w,
			symbol_h
		);
		draw_sprite_stretched(
			placement[i].spr,
			0,
			xori + i * (symbol_w + answer_sep_w),
			yori,
			symbol_w,
			symbol_h
		);
		var ms_mask_index = 0;
		switch placement[i].mark {
			case "un":
			ms_mask_index = 1;
			break;
			case "re":
			ms_mask_index = 2;
			break;
			case "val":
			ms_mask_index = 3;
			break;
		}
		draw_sprite_stretched(
			spr_ms_masks,
			ms_mask_index,
			xori + i * (symbol_w + answer_sep_w),
			yori,
			symbol_w,
			symbol_h
		);
		draw_sprite_stretched(
			spr_ms_frame,
			0,
			xori + i * (symbol_w + answer_sep_w),
			yori,
			symbol_w,
			symbol_h
		);
	}
	
	if(i == now_placing_num) {
		var spr = placement[i] == undefined ? spr_ms_void_placing : spr_ms_placed;
		draw_sprite_stretched(
			spr,
			image_index,
			xori + i * (symbol_w + answer_sep_w),
			yori,
			symbol_w,
			symbol_h
		);
	}
	
	
}

draw_text_transformed(room_width/2, room_height/2 - 50, question, 4, 4, 0);
draw_text_transformed(room_width/2, room_height/2 + 50, judge_display, 4, 4, 0);

//draw_getpixel_ext()
