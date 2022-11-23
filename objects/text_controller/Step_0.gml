if (keyboard_check_pressed(vk_enter) or mouse_check_button_pressed(mb_left)) {
	if (textbar.is_fully_displayed()) {
		// next sentence
		if (current_index < array_length(dialog) - 1) {
			current_index++;
			textbar.set_text(dialog[current_index]);
		}
	} else {
		// skip
		textbar.display_to_end();
	}
}
