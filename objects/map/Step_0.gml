if (keyboard_check_pressed(vk_right)) {}
if (keyboard_check_pressed(vk_left)) {}
if (keyboard_check_pressed(vk_up)) {}
if(keyboard_check_pressed(vk_down)){}

if (keyboard_check_pressed(vk_space)) {
	now_mobility = mobility_per_turn;
	now_turn++;
}

//detect the cursor
hover_num = undefined;
var x0 = abs_posx(-1/2);
var y0 = abs_posy(-1/2);
var x_grids = get_quotient(mouse_x - x0, cell_w);
var y_grids = get_quotient(mouse_y - y0, cell_h);
if (is_in_interval(x_grids , 0, map_width - 1, true) &&
	is_in_interval(y_grids , 0, map_height - 1, true)
) {
	hover_num = pos2num(x_grids, y_grids);
}

if (mouse_check_button_pressed(mb_left) and array_length(this_path) == 0) {
	if (!is_undefined(hover_num)) {
		var my_path = find_path(now_num, hover_num);
		var d = my_path.dis[hover_num]
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
		draw_pos[i] = num2pos(now_num)[i] + (num2pos(next_pos)[i] - num2pos(now_num)[i]) * this_move_process;
	}
}

if (this_move_process >= 1) {
	if (array_length(this_path) != 0) {
		move_time_left = move_time;
		now_num = this_path[0];
		array_delete(this_path, 0, 1);
	}
}