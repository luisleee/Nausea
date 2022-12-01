chain = [];
current_index = 0;

function is_fully_displayed() {
	return textbar.is_fully_displayed() && current_index >= array_length(chain) - 1;
}

function set_chain(_chain) {
	chain = _chain;
	current_index = 0;
	display_current();
}

function next() {
	if (!textbar.is_fully_displayed()) {
		textbar.display_to_end();
		return;
	}
	var current_item = chain[current_index];
	if (current_item.type == ITEM_TYPE.OPTION) {
		options_painter.select();
	}
	
	current_index++;
	display_current();
}

function display_current() {
	var current_item = chain[current_index];
	if (current_item.type == ITEM_TYPE.DIALOG) {
		textbar.set_text(current_item.line);
		textbar.set_name(get_person_name(current_item.speaker));
		textbar.set_portrait(get_person_portrait(current_item.speaker, current_item.emotion));
	}
	if (current_item.type == ITEM_TYPE.OPTION) {
		textbar.set_text(current_item.question);
		textbar.set_name("");
		textbar.set_portrait(spr_option_black);
		options_painter.set_options(current_item.options);
		options_painter.set_name(current_item.name);
		options_painter.show();
	}
}
