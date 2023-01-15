if (keyboard_check_pressed(vk_enter) or mouse_check_button_pressed(mb_left)) {
	if (!task_manager.show_self) {
		next();
	}
}
