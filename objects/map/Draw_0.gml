draw_init(fnt_default, c_white, "mc", 1);

var col_reachable = c_yellow;
var col_now_pos = c_aqua;
var col_hover_pos = c_aqua;

var my_path = find_path(now_pos, 0);

//draw the unit cells
for (var _x = 0; _x < map_width; _x++) {
	for (var _y = 0; _y < map_height; _y++) {
		draw_set_color(c_white);
		// Reachable cells
		if (my_path.dis[pos2number(_x, _y)] != -1 && my_path.dis[pos2number(_x, _y)] <= now_mobility) {
			draw_set_color(col_reachable);
		}
		// Obstacles
		if (cells[_x][_y] != "o") {
			draw_set_color(c_red);
		}
		draw_set_alpha(0.5);
		draw_cell(_x, _y);

		// The hovering position
		if (pos2number(_x, _y) == hover_pos) {
			draw_set_color(col_hover_pos);
			draw_set_alpha(0.25);
			draw_cell(_x, _y);
		}
		draw_set_alpha(1);
		draw_circle(abs_posx(_x), abs_posy(_y), 5, 1);
	}
}

//draw the player cell
draw_set_color(col_now_pos);
draw_set_alpha(0.5);
draw_cell(draw_pos[0], draw_pos[1]);

draw_set_color(c_white);
draw_set_alpha(1);
draw_text_transformed(1500, 500, "Turn " + string(now_turn), 10, 10, 0);