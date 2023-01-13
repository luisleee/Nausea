if (keyboard_check_pressed(vk_right)) {}
if (keyboard_check_pressed(vk_left)) {}
if (keyboard_check_pressed(vk_up)) {}
if(keyboard_check_pressed(vk_down)){}

if (keyboard_check_pressed(vk_space)) {
	now_mobility = mobility_per_turn;
	now_turn++;
}

//detect the cursor
hover_pos = undefined;
for (var _x = 0; _x < map_width; _x++) {
	for (var _y = 0; _y < map_height; _y++) {
		var xin = is_in_interval(mouse_x, abs_posx(_x) - cell_w/2, abs_posx(_x) + cell_w/2, 1);
		var yin = is_in_interval(mouse_y, abs_posx(_y) - cell_h, abs_posx(_y), 1);
		if (xin and yin) {
			hover_pos = pos2number(_x, _y);
		}
	}
}

if (mouse_check_button_pressed(mb_left) and array_length(this_path) == 0) {
	if (!is_undefined(hover_pos)) {
		var my_path = find_path(now_pos, hover_pos);
		var d = my_path.dis[hover_pos]
		if (d != -1 && d <= now_mobility) {
			move_time_left = move_time;
			this_path = my_path.path;
			now_mobility -= d;
		}
	}
}

move_time_left -= move_spd;
var this_move_process = (move_time - move_time_left) / move_time;

if (array_length(this_path) != 0) {
	var next_pos = this_path[0];
	for (var i = 0; i <= 1; i++) {
		draw_pos[i] = number2pos(now_pos)[i] + (number2pos(next_pos)[i] - number2pos(now_pos)[i]) * this_move_process;
	}
}

if (this_move_process >= 1) {
	if (array_length(this_path) != 0) {
		move_time_left = move_time;
		now_pos = this_path[0];
		array_delete(this_path, 0, 1);
	}
}