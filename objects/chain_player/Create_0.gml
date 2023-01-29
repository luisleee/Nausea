current_item_index = 0;
chain = undefined;

frozen = false;

function freeze() {
	frozen = true;
}

function unfreeze() {
	frozen = false;	
}

function get_current_item() {
	return chain.items[current_item_index];
}

function get_current_type() {
	return get_current_item().type;
}

function is_fully_displayed() {
	if (get_current_type() == ITEM_TYPE.OPTION && !options.is_selected()) {
		return false;
	}
	return textbar.is_fully_displayed() && current_item_index >= array_length(chain.items) - 1;
}

function display_current_item() {
	var current_item = get_current_item();
	if (current_item.type == ITEM_TYPE.DIALOG) {
		textbar.set_text(current_item.line);
		textbar.set_name(get_person_name(current_item.speaker));
		textbar.set_portrait(get_person_portrait(current_item.speaker, current_item.emotion));
	}
	if (current_item.type == ITEM_TYPE.OPTION) {
		textbar.set_text(current_item.question);
		textbar.set_name("");
		textbar.set_portrait(spr_option_black);
		options.set_options(current_item.options);
		options.set_name(current_item.name);
		options.show();
	}
	if (current_item.type == ITEM_TYPE.MAP) {
		// todo: extract function
		image_painter.clear();
		textbar.hide();
		freeze();
		if (!is_undefined(current_item.map_name)) {
			map.set_map(current_item.map_name, current_item.pos);
			map.full_mobility();
		}
		map.unfreeze();
		map.show();
	}
	
	/// quick step forward
	if (current_item.type == ITEM_TYPE.MUSIC) {
		music_player.set_music(current_item.piece);
		next_item();
	}
	if (current_item.type == ITEM_TYPE.IMAGE) {
		for (var i = 0; i < array_length(current_item.remove); i++) { 
			image_painter.remove_image_group(current_item.remove[i]);
		}
		for (var i = 0; i < array_length(current_item.add); i++) { 
			image_painter.add_image_group(current_item.add[i]);
		}
		next_item();
	}
	if (current_item.type == ITEM_TYPE.TASK) {
		// todo: fail/complete a task
		task_manager.create_new_task(current_item.name, current_item.description);
		next_item();
	}
}

function set_chain(chain_name) {
	chain = chain_storage.get_chain(chain_name);
	current_item_index = 0;
	display_current_item();
}

set_chain("chain3");

function next() {
	if (!is_fully_displayed()) {
		next_item();
		return;
	}
	
	set_chain(chain.next());
}

function next_item() {
	if (is_fully_displayed()) {
		return;
	}
	if (!textbar.is_fully_displayed()) {
		textbar.display_to_end();
		return;
	}
	var current_item = get_current_item();
	if (current_item.type == ITEM_TYPE.OPTION) {
		options.select();
		next();
		return;
	}
	var next_item = chain.items[current_item_index + 1];
	
	// todo: fix img_painter & extract a function for this
	if (next_item.type == ITEM_TYPE.IMAGE and array_length(image_painter.img_queue) != 0) {
		return;
	}
	current_item_index++;
	display_current_item();
}
