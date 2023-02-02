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
	return mind_mode == false or mind_process == 1;
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

subimg = 0;
time = 0;

mind_mode = false;
mind_process = 0;
mind_xoffset = 0;
mind_yoffset = 0;

default_text_col = make_color_hsv(0, 0, 0);
