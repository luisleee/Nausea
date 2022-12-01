options = [];
selected = 0;
name = "";

function select_next() {
	selected = (selected + 1) % array_length(options);
}

function select_previous() {
	var len = array_length(options);
	selected = (selected - 1 + len) % len;
}

function set_options(_options) {
	options = _options;
	selected = 0;
}

function set_name(_name) {
	name = _name;	
}

function select() {
	hide();
	data_recorder.select_option(name, selected);
}

function hide() {
	visible = false;
}

function show() {
	visible = true;
}

hide();