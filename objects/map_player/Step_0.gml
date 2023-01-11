var a = mp_grid_path(
	grids,
	path,
	x,
	y,
	abs_posx(map.goal_pos[0]),
	abs_posy(map.goal_pos[1]),
	false
);
if(a){
	path_start(path, 2, path_action_stop, false);
}

