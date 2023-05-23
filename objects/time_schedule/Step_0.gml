if (mouse_check_button_pressed(mb_left)) {
	if (!is_undefined(hovering_block)) {
		if (not block_selected[hovering_block]) {
			block_selected[hovering_block] = true;
			array_push(schedule, optional_blocks[hovering_block]);
		}
	}
}