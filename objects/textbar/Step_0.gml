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
			audio_play_sound(snd_sfx_text, 0, 0);
		}
	}
}

if (is_fully_displayed() and auto_play and alarm_get(0) == -1) {
	alarm_set(0, fps);
}

if (mind_mode and is_fully_displayed() and !animation_fully_displayed()) {
	draw_set_font(fnt_default);
			
	var x_goal = display_w/2 - string_width(raw_text)/2 * text_scale - display_text_x;
	var y_goal = display_h/2 - string_height(raw_text)/2 * text_scale - display_text_y;
	mind_process += 0.01;
	var zoom_channel = animcurve_get_channel(ac_textbar_mind, 0);
	mind_yoffset = animcurve_channel_evaluate(zoom_channel, mind_process) * y_goal;
	mind_xoffset = animcurve_channel_evaluate(zoom_channel, mind_process) * x_goal;
	textbar_apa = 1 - animcurve_channel_evaluate(zoom_channel, mind_process);
	mind_background_apa = animcurve_channel_evaluate(zoom_channel, mind_process);
	default_text_col = make_color_hsv(0, 0, mind_process * 255);
			
	if (animation_fully_displayed()) {
		default_text_col = c_white;
		audio_play_sound(snd_sfx_ms_place, 0, 0);
		set_text(raw_text);
		display_to_end();
		mind.show();
	}
}

subimg += 0.2;
time += 0.1;
