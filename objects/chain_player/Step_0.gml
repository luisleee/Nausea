if (frozen) {
	exit;	
}

if (keyboard_check_pressed(vk_enter) or mouse_check_button_released(mb_left)) {
	if (!task_manager.show_self && textbar.animation_fully_displayed()) {
		next();
	}
}