current_item_index = 0;
chain = undefined;

frozen = false;

function freeze() {
	frozen = true;
}

function unfreeze() {
	frozen = false;	
}


enum DISPLAY_MODES {
	MAP,
	MIND,
	DIALOG,
}
display_mode = DISPLAY_MODES.DIALOG;

function set_mode(_mode) {
	display_mode = _mode;
	switch _mode {
		case DISPLAY_MODES.MAP:
			image_painter.clear();
			textbar.hide();
			freeze();
			map.unfreeze();
			map.show();
			break;
		case DISPLAY_MODES.DIALOG:
			textbar.mind_mode = false;
			mind.hide();
			break;
		case DISPLAY_MODES.MIND:
			//image_painter.clear();
			textbar.mind_mode = true;
			
			break;
	}
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
	var next_chain_item = chain.items[current_item_index + 1];
	
	if (next_chain_item.type == ITEM_TYPE.IMAGE and !image_painter.animation_finished()) {
		return;
	}
	current_item_index++;
	display_current_item();
}




function display_current_item() {
	var current_item = get_current_item();
	
	textbar.symbol_mode = false;
	// todo: use classes
	if (current_item.type == ITEM_TYPE.DIALOG) {
		textbar.set_text(current_item.line);
		textbar.set_name(get_person_name(current_item.speaker));
		textbar.set_portrait(get_person_portrait(current_item.speaker, current_item.emotion));
		if variable_struct_exists(current_item, "mode_switch") {
			set_mode(variable_struct_get(current_item, "mode_switch"));
		}
		if (display_mode == DISPLAY_MODES.MIND) {
			mind.answer_mode = false;
		}
	}
	if (current_item.type == ITEM_TYPE.SYMBOL) {
		textbar.set_text(current_item.desc);
		textbar.symbol_mode = true;
		textbar.set_symbol(current_item.symbol);
		data_recorder.unlock_symbol(current_item.symbol);
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
		set_mode(DISPLAY_MODES.MAP);
		
		if (!is_undefined(current_item.map_name)) {
			map.set_map(current_item.map_name, current_item.pos);
			map.full_mobility();
		}
	}
	
	if (current_item.type == ITEM_TYPE.MIND) {
		textbar.set_text(current_item.question);
		mind.set_answers(current_item.default_answer, current_item.answers);
		mind.answer_mode = true;
		mind.conclusion = variable_struct_exists(current_item, "conclusion");
		freeze();
		
		if (display_mode != DISPLAY_MODES.MIND) {
			set_mode(DISPLAY_MODES.MIND);
		}
		
	}
	
	if (current_item.type == ITEM_TYPE.TRANSITION) {
		textbar.perform_transition(current_item.pattern, current_item.time, current_item.infos);
	}
	/// quick step forward
	if (current_item.type == ITEM_TYPE.MUSIC) {
		music_player.set_music(current_item.piece);
		next_item();
	}
	if (current_item.type == ITEM_TYPE.IMAGE) {
		
		array_foreach(current_item.add, function(img) {
			image_painter.add_image(img);
		});
		
		array_foreach(current_item.remove, function(class) {
			image_painter.remove_image(class);
		});
		
		next_item();
	}
	if (current_item.type == ITEM_TYPE.TASK) {
		if not (task_manager.task_exists(current_item.name)) {//create
			task_manager.create_new_task(current_item.name, current_item.desc);
		} else { //update
			if(variable_struct_exists(current_item, "desc")) {
				task_manager.task_update(current_item.name, current_item.desc);
			}
			if(variable_struct_exists(current_item, "state")) {
				task_manager.task_finish(current_item.name, current_item.state);
			}
		}
		
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
	
	var successors = variable_struct_get_names(chain.next);
	var successor_idx = array_find_index(successors, function(name) {
		return data_recorder.meets_requirement(variable_struct_get(chain.next, name));
	});
	
	set_chain(successors[successor_idx]);
}


