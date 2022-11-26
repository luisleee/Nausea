char_spd = 0.45;
char_count = 1;
current_text = "";
person_name = "我";
person_portrait = noone;

function is_fully_displayed() {
	return char_count >= string_length(current_text);
}

function display_to_end() {
	char_count = string_length(current_text);
}

function set_text(_text) {
	current_text = _text;
	char_count = 1;
}

function set_name(_name) {
	person_name = _name;
}

function set_portrait(_portrait) {
	person_portrait = _portrait;
}