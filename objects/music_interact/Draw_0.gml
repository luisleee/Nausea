var dis_w = display_get_gui_width();
var dis_h = display_get_gui_height();
draw_init(fnt_default, c_white, "tl", 1);

draw_set_color(c_red);
draw_rectangle(0, dis_h/2 - 0.75 * judgement_area[2], dis_w, dis_h/2 + 0.75 * judgement_area[2], 0);
draw_set_color(c_aqua);
draw_rectangle(0, dis_h/2 - 0.75 * judgement_area[1], dis_w, dis_h/2 + 0.75 * judgement_area[1], 0);
draw_set_color(c_lime);
draw_rectangle(0, dis_h/2 - 0.75 * judgement_area[0], dis_w, dis_h/2 + 0.75 * judgement_area[0], 0);

var w = 0;
for (var i = 0; i < array_length(lyrics[lyric_page]); i++) {
	if (i < lyric_word) {
		draw_set_color(c_white);
		//if (note_num2word_num(judge_num) == i)draw_set_color(c_lime);
		draw_text_transformed(100 + w, 100, lyrics[lyric_page][i], text_scale, text_scale, 0);
		
	}
	w += string_width(lyrics[lyric_page][i]) * text_scale;
	
	
}


for (var i = 0; i < array_length(note_start); i++) {
	var distance = 0.75 * (current_time - start_time - (note_start[i /*+ note_num_addup(lyric_page)*/] - relative_start));
	var note_col = c_white;
	if (!is_undefined(note_judgement[i])) {
		switch note_judgement[i] {
			case "Perfect":
				note_col = c_lime;
				break;
			case "Good":
				note_col = c_aqua;
				break;
			case "Bad":
				note_col = c_red;
				break;
			case "Miss":
				note_col = c_olive;
				break;
		}	
	}
	
	if (distance <= dis_h/2) {
		draw_set_color(c_black);
		draw_circle(
			dis_w/2 ,
			dis_h/2 - distance,
			24,
			0
		);
		draw_set_color(note_col);
		draw_circle(
			dis_w/2 ,
			dis_h/2 - distance,
			20,
			0
		);
		/*
		draw_set_alpha(1 - 0.005 * distance * (distance > 0));
		draw_circle(
			dis_w/2 + w - string_width(lyrics[lyric_page][i]) * text_scale/2,
			dis_h/2 - distance * (distance < 0),
			10 + 0.5 * distance * (distance > 0),
			0
		);*/
	}
}
	

