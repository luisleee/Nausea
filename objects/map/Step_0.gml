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


if (mouse_check_button_pressed(mb_left) and animation_finished()) {
	if (!is_undefined(hover_num)) {
		// todo: function gotonum
		var p = find_path(now_num, hover_num);
		var d = p.dis[hover_num]
		if (d != -1 && d <= now_mobility) {
			move_time_left = move_time;
			this_path = p.path;
			this_costs = p.costs;
			now_mobility -= d;
		}
	}
}

if (!animation_finished()) {
	move_time_left -= (move_spd / this_costs[0]);
	var move_process = (move_time - move_time_left) / move_time;
	var next_num = this_path[0];
	draw_pos = from_pos_to_pos(num2pos(now_num), num2pos(next_num), move_process);
	if (move_process >= 1) {//once this ONE move is done
		move_time_left = move_time;
		now_num = this_path[0];
		array_delete(this_path, 0, 1);
		array_delete(this_costs, 0, 1);

		
		if (animation_finished()) {//once this WHOLE move is done
			// todo: extract function(s)
			for (var i = 0; i < array_length(trans_cells); i++) {
				var trans = trans_cells[i];
				if (pos2num(trans.pos) == now_num) {
					set_map(trans.to_map, trans.to_pos);
					break;
				}
			}
			for (var i = 0; i < array_length(event_cells); i++) {
				var event = event_cells[i];
				if (pos2num(event.pos) == now_num) {
					// todo: display sth??
					break;
				}
			}
		}
	}
}

