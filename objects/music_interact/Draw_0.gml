var dis_w = display_get_gui_width();
var dis_h = display_get_gui_height();
var now_time = current_time - start_time;
draw_init(fnt_default, c_white, "tl", 1);


show_perform();

draw_set_alpha(0);
draw_set_color(c_red);
draw_rectangle(0, dis_h/2 - 0.75 * judgement_area[2], dis_w, dis_h/2 + 0.75 * judgement_area[2], 0);
draw_set_color(c_aqua);
draw_rectangle(0, dis_h/2 - 0.75 * judgement_area[1], dis_w, dis_h/2 + 0.75 * judgement_area[1], 0);
draw_set_color(c_lime);
draw_rectangle(0, dis_h/2 - 0.75 * judgement_area[0], dis_w, dis_h/2 + 0.75 * judgement_area[0], 0);


for (var track_num = 0; track_num < array_length(tracks); track_num++) {
	if (tracks[track_num].track_mode == RHYTHM_TRACK_MODES.NOTE) {
		var xx = room_width/5 * (track_num + 1);
		for (var i = 0; i < array_length(tracks[track_num].notes); i++) {
			var note_time = tracks[track_num].notes[i] - relative_start;
			var distance = 0.75 * (now_time - note_time);
			var note_col = c_white;
			var icon_index = 0;
			if (!is_undefined(note_judgement[track_num][i])) {
				switch note_judgement[track_num][i] {
					case "Perfect":
						note_col = c_lime;
						icon_index = 1;
						break;
					case "Good":
						note_col = c_aqua;
						icon_index = 2;
						break;
					case "Bad":
						note_col = c_red;
						icon_index = 3;
						break;
					case "Miss":
						note_col = c_olive;
						icon_index = 4;
						break;
				}	
			}
			
			if (distance <= dis_h/2) {
				if (is_undefined(tracks[track_num].icon)) {
					draw_set_color(c_black);
					draw_circle(
						xx,
						dis_h/2 - distance,
						24,
						0
					);
					draw_set_color(note_col);
					draw_circle(
						xx,
						dis_h/2 - distance,
						20,
						0
					);
				} else {
					draw_sprite_ext(
						tracks[track_num].icon,
						icon_index,
						xx,
						dis_h/2 - distance,
						4,
						4,
						0,
						c_white,
						1
					);
				}
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
	}
}
	
	

