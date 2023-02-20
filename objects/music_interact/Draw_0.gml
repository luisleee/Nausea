var dis_w = display_get_gui_width();
var dis_h = display_get_gui_height();
draw_init(fnt_default, c_white, "tl", 1);

var range1 =  0.75 * 20;
draw_set_color(c_lime);
draw_rectangle(0, dis_h/2 - range1, dis_w, dis_h/2 + range1, 0);

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
	if (distance <= dis_h/2) {
		draw_set_alpha(1 - 0.005 * distance * (distance > 0));
		draw_circle(
			dis_w/2 /*+ w - string_width(lyrics[lyric_page][i]) * text_scale/2*/,
			dis_h/2 - distance * (distance < 0),
			10 + 0.5 * distance * (distance > 0),
			0
		);
	}
}
	

