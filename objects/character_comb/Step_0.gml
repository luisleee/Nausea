time += 0.1;

if (mouse_check_button_pressed(mb_left)) {
	if (!is_undefined(hover_num)) {
		for (var i = 0; i < array_length(answer_nums); i ++) {
			if is_undefined(answer_nums[i]) {
				answer_nums[i] = hover_num;
				opt_char_selected[hover_num] = true;
				break;
			}
		}
	}
}

if (keyboard_check_pressed(ord("D"))) {
	if (num2str(answer_nums) == correct_str) {
		show_debug_message("Correct!");
	} else show_debug_message("Dumbass");
}