auto_play = false;

show_self = true;

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

function display_to_end() {
	char_real_count = string_length(raw_text);
	stop_auto_play();
}

function set_text(_text) {
	var obj = parse_text(_text);
	raw_text = obj.raw_text;
	text_effects = obj.effects;
	char_real_count = 1;
}

function set_name(_name) {
	person_name = _name;
}

function set_portrait(_portrait) {
	person_portrait = _portrait;
}

subimg = 0;