if(keyboard_check_pressed(vk_right)){
	if(array_includes(now_reachable_cells, [now_pos[0] + 1, now_pos[1]])){
		last_pos = clone(now_pos);
		now_pos[0] ++;
		now_mobility --;
		movement_apa = 1;
		
	}
}
if(keyboard_check_pressed(vk_left)){
	if(array_includes(now_reachable_cells, [now_pos[0] - 1, now_pos[1]])){
		last_pos = clone(now_pos);
		now_pos[0] --;
		now_mobility --;
		movement_apa = 1;
	}
}
if(keyboard_check_pressed(vk_up)){
	if(array_includes(now_reachable_cells, [now_pos[0], now_pos[1] - 1])){
		last_pos = clone(now_pos);
		now_pos[1] --;
		now_mobility --;
		movement_apa = 1;
	}
}
if(keyboard_check_pressed(vk_down)){
	if(array_includes(now_reachable_cells, [now_pos[0], now_pos[1] + 1])){
		last_pos = clone(now_pos);
		now_pos[1] ++;
		now_mobility --;
		movement_apa = 1;
	}
}

if(keyboard_check_pressed(vk_space)){
	now_mobility = mobility_per_turn;
	now_turn ++;
}

array_delete(now_reachable_cells, 0, array_length(now_reachable_cells));
now_cell = new Reachable(now_pos, [], now_mobility);

//detect the cursor
hover_pos = undefined;
for(var xx = 1; xx <= map_width; xx ++){
	for(var yy = 1; yy <= map_height; yy ++){
		var xin = is_in_interval(mouse_x, x + xx * cell_w - cell_w/2, x + xx * cell_w + cell_w/2, 1);
		var yin = is_in_interval(mouse_y, y + yy * cell_h - cell_h/2, y + yy * cell_h + cell_h/2, 1);
		if(xin and yin){
			hover_pos = [xx, yy];
		}
	}
}

if(mouse_check_button_pressed(mb_left)){
	if(not is_undefined(hover_pos)){
		goal_pos = clone(hover_pos);
		show_debug_message(goal_pos);
		show_debug_message(find_path(now_pos, goal_pos));
	}
}

if(movement_apa > 0){
	movement_apa -= 0.025;
}

