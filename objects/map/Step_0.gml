if (keyboard_check_pressed(vk_right)) {
	/*
	last_pos = clone(now_pos);
	now_pos[0]++;

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

if (mouse_check_button_pressed(mb_left) and array_length(this_path) == 0) {
	if (not is_undefined(hover_pos)) {
		goal_pos = hover_pos;
		var my_this_path = find_path(now_pos, goal_pos).path;
		if (my_this_path != undefined) {
			move_time_left = move_time;
			this_path = my_this_path;
		}
	}
}


var this_move_process = (move_time - move_time_left) / move_time;

if (array_length(this_path) != 0) {
	var this_move_goal = this_path[0];
	for(var i = 0; i <= 1; i++){
		draw_pos[i] = number2pos(now_pos)[i] + (number2pos(this_move_goal)[i] - number2pos(now_pos)[i]) * this_move_process;
	}
}


if (move_time_left > 0) {
	move_time_left -= move_spd;
} else {
	if(array_length(this_path) != 0) {
		move_time_left = move_time;
		var this_move_goal = this_path[0];
		now_pos = this_move_goal;
		for(var i = 0; i <= 1; i++){
			draw_pos[i] = number2pos(now_pos)[i] + (number2pos(this_move_goal)[i] - number2pos(now_pos)[i]) * this_move_process;
		}
		
		this_path = array_remove(this_path, 0);
	}
}