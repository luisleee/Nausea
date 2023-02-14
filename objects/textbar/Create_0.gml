auto_play = false;

show_self = true;
textbar_apa = 1;
mind_background_apa = 0;

display_w = display_get_gui_width();
display_h = display_get_gui_height();
text_scale = 3.5/1600 * display_w;

display_text_x = 0;
display_text_y = 0;

function stop_auto_play() {
	alarm_set(0, -1);
	auto_play = false;
}

function show() {
	show_self = true;
}

function hide() {
	stop_auto_play();
	show_self = false;
}

char_spd = 0.45;
char_count = 1;
char_real_count = 1;

person_name = "我";
person_portrait = undefined;

raw_text = "";
text_effects = [];

function is_fully_displayed() {
	return char_count >= string_length(raw_text);
}
function animation_fully_displayed() {
	return (not mind_mode and mind_process == 0) or (mind_mode and mind_process >= 1);
}

function display_to_end() {
	char_real_count = string_length(raw_text);
	stop_auto_play();
}

function set_text(_text) {
	if (mind_mode) {
		_text = "<float=1>" + _text;
	}
	var obj = parse_text(_text);
	raw_text = obj.raw_text;
	text_effects = obj.effects;
	char_real_count = 1;
	if (mind_mode) {
		var x_goal = display_w/2 - string_width(raw_text)/2 * text_scale - display_text_x;
		var y_goal = display_h/2 - string_height(raw_text)/2 * text_scale - display_text_y;
		mind_yoffset = y_goal;
		mind_xoffset = x_goal;
	}
}

function set_name(_name) {
	person_name = _name;
}

function set_portrait(_portrait) {
	person_portrait = _portrait;
}

function set_symbol(_spr) {
	symbol_unlock = data_recorder.ms_spr2ms(_spr);
	symbol_show_process = 0;
	audio_play_sound(snd_sfx_ms_gain, 0, 0);
}

subimg = 0;
time = 0;

mind_mode = false;
mind_process = 0;
mind_xoffset = 0;
mind_yoffset = 0;

default_text_col = make_color_hsv(0, 0, 0);



symbol_mode = false;
symbol_unlock = undefined;
var border_w = 0.02 * display_w;
draw_set_font(fnt_default);
var desc_w = string_width("") * text_scale;

symbol_x = display_w/2 - desc_w/2 - display_text_x;
symbol_y = display_h - 250 - display_text_y;
symbol_background_apa = 0;
symbol_spr_x_goal = 8/80 * display_w;
symbol_spr_path_l = 200;
symbol_show_process = 0;