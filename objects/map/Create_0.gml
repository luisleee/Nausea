function Reachable(_pos, _passed, _mobility) constructor {
	pos = _pos;
	passed = _passed;
	mobility = _mobility;
}

map_width = 5;
map_height = 5;
now_pos = [3,3];
mobility_per_turn = 2;
now_mobility = mobility_per_turn;
now_turn = 1;
now_reachable_cells = [];

now_cell = new Reachable(now_pos, [], now_mobility);
last_pos = clone(now_pos);

hover_pos = undefined;
goal_pos = clone(now_pos);

cell_w = 100;
cell_h = 100;
movement_apa = 0;

for(var xx = 1; xx <= map_width; xx ++){
	for(var yy = 1; yy <= map_height; yy ++){
		g_costs[xx][yy] = 0;
		h_costs[xx][yy] = 0;
		f_costs[xx][yy] = g_costs[xx][yy] + h_costs[xx][yy];
		connections[xx][yy] = [xx, yy];
	}
}

function find_path(_start_pos, _goal_pos) {
	var to_search = ds_list_create();
	var processed = ds_list_create();
	ds_list_add(to_search, _start_pos);
	while(not ds_list_empty(to_search)){
		var current = clone(to_search[| 0]);
		for(var t = 0; t < ds_list_size(to_search); t++){
			var cell_t = clone(to_search[| t]);
			if(get_f_cost(cell_t) < get_f_cost(current) or (get_f_cost(cell_t) == get_f_cost(current) and get_h_cost(cell_t) < get_h_cost(current))){
				current = clone(cell_t);
			}
		}
		ds_list_add(processed, current);
		var cur_pos = ds_list_find_index(to_search, current);
		ds_list_delete(to_search, cur_pos);
		
		if(are_equal(current, _goal_pos)){
			var current_path_cell = clone(_goal_pos);
			var path = ds_list_create();
			while(not are_equal(current_path_cell, _start_pos)){
				ds_list_add(path, current_path_cell);
				current_path_cell = clone(get_connection(current_path_cell));
			}
			return path;
		}
		
		var neighbor = neighbors(current);
		for(var i = 0; i < ds_list_size(neighbor); i++){//////////neighbors should be those who are walkable and not processed
			if not (ds_list_contains(processed, neighbor[| i])){
				var in_search = ds_list_contains(to_search, neighbor[| i]);
				var cost_to_neighbor = get_g_cost(current) + get_distance(current, neighbor[| i]);
				
				if(not in_search or cost_to_neighbor < get_g_cost(neighbor[| i])){
					set_g_cost(neighbor[| i], cost_to_neighbor);
					set_connection(neighbor[| i], current);
					
					if(not in_search){
						set_h_cost(neighbor[| i], get_distance(neighbor[| i], _goal_pos));
						ds_list_add(to_search, neighbor[| i]);
					}
				}
			}
		}
	}
}
function abs_posx(posx){
	return posx * cell_w + x;
}
function abs_posy(posy){
	return posy * cell_h + y;
}

function ds_list_contains(list, element){
	if(ds_list_find_index(list, element) == -1){
		return false;
	}
	return true;
}

function neighbors(pos){
	var nei = ds_list_create();
	var left = (pos[0] - 1 >= 1);
	var right = (pos[0] + 1 <= map_width);
	var up = (pos[1] - 1 >= 1);
	var down = (pos[1] + 1 <= map_height);
	if(left)ds_list_add(nei, [pos[0] - 1, pos[1]]);
	if(right)ds_list_add(nei, [pos[0] + 1, pos[1]]);
	if(up)ds_list_add(nei, [pos[0], pos[1] - 1]);
	if(down)ds_list_add(nei, [pos[0], pos[1] + 1]);
	return nei;
}

function set_g_cost(arg, _g_cost){
	var xx = arg[0];
	var yy = arg[1];
	g_costs[xx][yy] = _g_cost;
	f_costs[xx][yy] = g_costs[xx][yy] + h_costs[xx][yy];
}
function set_h_cost(arg, _h_cost){
	var xx = arg[0];
	var yy = arg[1];
	h_costs[xx][yy] = _h_cost;
	f_costs[xx][yy] = g_costs[xx][yy] + h_costs[xx][yy];
}
function get_f_cost(arg){
	var xx = arg[0];
	var yy = arg[1];
	return f_costs[xx][yy];
}
function get_g_cost(arg){
	var xx = arg[0];
	var yy = arg[1];
	return g_costs[xx][yy];
}
function get_h_cost(arg){
	var xx = arg[0];
	var yy = arg[1];
	return h_costs[xx][yy];
}
function set_connection(arg1, arg2){
	var xx1 = arg1[0];
	var yy1 = arg1[1];
	var xx2 = arg2[0];
	var yy2 = arg2[1];
	connections[xx1][yy1] = [xx2, yy2];
}
function get_connection(arg){
	var xx = arg[0];
	var yy = arg[1];
	return clone(connections[xx][yy]);
}

function get_distance(pos1, pos2){
	return abs(pos1[0] - pos2[0]) + abs(pos1[1] - pos2[1]);
}

my_player = instance_create_depth(abs_posx(now_pos[0]), abs_posy(now_pos[1]), -200, map_player);