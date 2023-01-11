path = path_add();
grids = mp_grid_create(map.x, map.y, map.map_width, map.map_height, map.cell_w, map.cell_h);

function abs_posx(posx){
	return posx * map.cell_w + map.x;
}							   
function abs_posy(posy){	   
	return posy * map.cell_h + map.y;
}

alarm[0] = 60;