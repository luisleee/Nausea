if (keyboard_check_pressed(vk_right)) {
	/*
	last_pos = clone(now_pos);
	now_pos[0]++;
	now_mobility--;
	movement_apa = 1;
	*/
}
if (keyboard_check_pressed(vk_left)) {
	/*
	last_pos = clone(now_pos);
	now_pos[0]--;
	now_mobility--;
	movement_apa = 1;
	*/
}
if (keyboard_check_pressed(vk_up)) {
	/*
	last_pos = clone(now_pos);
	now_pos[1]--;
	now_mobility--;
	movement_apa = 1;
	*/
}
if(keyboard_check_pressed(vk_down)){
	/*
	last_pos = clone(now_pos);
	now_pos[1]++;
	now_mobility--;
	movement_apa = 1;
	*/
}

if (keyboard_check_pressed(vk_space)) {
	now_mobility = mobility_per_turn;
	now_turn++;
}

//detect the cursor
hover_pos = undefined;
for (var xx = 1; xx <= map_width; xx++) {
	for (var yy = 1; yy <= map_height; yy++) {
		var xin = is_in_interval(mouse_x, x + xx * cell_w - cell_w/2, x + xx * cell_w + cell_w/2, 1);
		var yin = is_in_interval(mouse_y, y + yy * cell_h - cell_h/2, y + yy * cell_h + cell_h/2, 1);
		if (xin and yin) {
			hover_pos = pos2number(xx, yy);
		}
	}
}

if (mouse_check_button_pressed(mb_left)) {
	if (not is_undefined(hover_pos)) {
		goal_pos = hover_pos;
	}
}

if (movement_apa > 0) {
	movement_apa -= 0.025;
}

