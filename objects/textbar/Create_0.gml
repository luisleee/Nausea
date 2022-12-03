auto_play = false;

char_spd = 0.45;
char_count = 1;
char_real_count = 1;
current_text = "";
person_name = "我";
person_portrait = undefined;



function is_fully_displayed() {
	var raw_text = parse_text(current_text).raw_text;
	return char_count >= string_length(raw_text);
}

function display_to_end() {
	var raw_text = parse_text(current_text).raw_text;
	char_real_count = string_length(raw_text);
	alarm_set(0, -1);
	auto_play = false;
}

function set_text(_text) {
	current_text = _text;
	char_real_count = 1;
}

function set_name(_name) {
	person_name = _name;
}

function set_portrait(_portrait) {
	person_portrait = _portrait;
}

function Line (_raw_text, _effects) constructor {
	raw_text = _raw_text;
	effects = _effects;
}

subimg = 0;