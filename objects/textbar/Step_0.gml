/// typewriter effect
char_count = floor(char_real_count);

var cur_line = parse_text(current_text);
var raw_text = cur_line.raw_text;

if (char_count < string_length(raw_text)) {
	var punc_halt = get_halt_time(string_char_at(raw_text, char_count));
	var pre_floor = floor(char_real_count);
	char_real_count += char_spd / (punc_halt + cur_line.effects[char_count].halt);
	var post_floor = floor(char_real_count);
	if(pre_floor != post_floor){
		if (char_count % 2 == 0) {
			audio_play_sound(snd_sfx_text, 0, 0);
		}
	}
}

debugger.show_var_value("alarm[0]", alarm[0]);

if (is_fully_displayed() and auto_play and alarm_get(0) == -1) {
	alarm_set(0, fps);
}

subimg += 0.2;
