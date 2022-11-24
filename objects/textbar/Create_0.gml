char_spd = 0.45;
char_count = 1;
current_text = "";

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