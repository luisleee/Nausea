path = path_add();
grids = mp_grid_create(map.x + map.cell_w/2, map.y + map.cell_h/2, map.map_width, map.map_height, map.cell_w, map.cell_h);

function abs_posx(posx) {
	return posx * map.cell_w + map.x;
}							   
function abs_posy(posy) {	   
	return posy * map.cell_h + map.y;
}
