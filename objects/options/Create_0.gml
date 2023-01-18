option_text = [];
selected_num = 0;
selected = false;
name = "";

function select_next() {
	selected_num = (selected_num + 1) % array_length(option_text);
}

function select_previous() {
	var len = array_length(option_text);
	selected_num = (selected_num - 1 + len) % len;
}

function set_options(_option_text) {
	option_text = _option_text;
	selected_num = 0;
}

function set_name(_name) {
	name = _name;	
}

function select() {
	hide();
	selected = true;
	data_recorder.select_option(name, selected_num);
}

function is_selected() {
	return selected;
}

show_self = false;
function hide() {
	show_self = false;
}

function show() {
	show_self = true;
}
