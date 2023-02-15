if (!show_self) {
	exit;
}

/// typewriter effect
char_count = floor(char_real_count);

if (char_count < string_length(raw_text)) {
	var punc_halt = get_halt_time(string_char_at(raw_text, char_count));
	var effect_halt = text_effects[char_count].halt;
	var total_halt = punc_halt + effect_halt;
	char_real_count += char_spd / total_halt;
	var new_char_count = floor(char_real_count);
	if (char_count != new_char_count) {
		if (total_halt > 1 or char_count % 2 == 0) {
			if (not symbol_mode) {
				audio_play_sound(snd_sfx_text, 0, 0);
			}
		}
	}
}

if (is_fully_displayed() and auto_play and alarm_get(0) == -1) {
	alarm_set(0, fps);
}

if (is_fully_displayed() and !animation_fully_displayed()) {
	draw_set_font(fnt_default);
	var xoffset_goal = display_w/2 - string_width(raw_text)/2 * text_scale - display_text_x;
	var yoffset_goal = display_h/2 - string_height(raw_text)/2 * text_scale - display_text_y;
	mind_process += 0.01 * (mind_mode - 0.5) * 2;
	var zoom_channel = animcurve_get_channel(ac_textbar_mind, 0);
	mind_xoffset = animcurve_channel_evaluate(zoom_channel, mind_process) * xoffset_goal;
	mind_yoffset = animcurve_channel_evaluate(zoom_channel, mind_process) * yoffset_goal;
	textbar_apa = 1 - animcurve_channel_evaluate(zoom_channel, mind_process);
	mind_background_apa = animcurve_channel_evaluate(zoom_channel, mind_process);
	default_text_col = make_color_hsv(0, 0, mind_process * 255);
			
	if (mind_mode and animation_fully_displayed()) {
		default_text_col = c_white;
		audio_play_sound(snd_sfx_ms_place, 0, 0);
		set_text(raw_text);
		display_to_end();
		mind.show();
		mind.flash();
		music_player.set_music("mind");
	}
	
	if (!mind_mode and animation_fully_displayed()) {
		set_text(string_replace(raw_text, "<float=1>", "") + "。");
		audio_play_sound(snd_sfx_ms_place, 0, 0);
		display_to_end();
		music_player.remove_music("fade", {time: 150});
		mind.flash();
	}
}



if (symbol_mode) {
	if (symbol_background_apa < 1) {
		symbol_background_apa += 0.07;
		if (symbol_background_apa > 1) {
			symbol_background_apa = 1;
		}
	}
	if (symbol_show_process < 1) {
		symbol_show_process += 0.05;
		if (symbol_show_process > 1) {
			symbol_show_process = 1;
		}
	}
} else {
	if (symbol_background_apa > 0) {
		symbol_background_apa -= 0.07;
		if (symbol_background_apa < 0) {
			symbol_background_apa = 0;
		}
	}
}

if (trans_mode) {
	if (trans_pattern == "color_fade") {
		if (trans_phase == 1) {
			if (trans_apa < 1) {
				trans_apa += trans_spd;
			}
		}
		if (trans_phase == 2) {
			if (trans_apa > 0) {
				trans_apa -= trans_spd;
			} else {
				transition_init();
			}
		}
		
	}
}

subimg += 0.2;
time += 0.1;
