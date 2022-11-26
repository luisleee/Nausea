options = [];
selected = 0;
function next() {
	selected = (selected + 1) % array_length(options);
}

function previous() {
	var len = array_length(options);
	selected = (selected - 1 + len) % len;
}

function set_options(_options) {
	options = _options;
}

function hide() {
	visible = false;	
}

function show() {
	visible = true;
}

hide();