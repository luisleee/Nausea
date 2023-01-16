draw_init(fnt_default, c_white, "mc", 1);

var col_reachable = c_yellow;
var col_now_num = c_aqua;
var col_hover_num = c_aqua;

var p = find_path(now_num, 0);

//draw the map sprite as background
draw_sprite_ext(map_sprite, 0, x - cell_w/2, y - cell_h/2, 3, 3, 0, c_white, 1);

//draw the unit cells
for (var _x = 0; _x < map_width; _x++) {
	for (var _y = 0; _y < map_height; _y++) {
		draw_set_color(c_white);
		draw_set_alpha(0);
		// Reachable cellsS
		// todo: extract function num_is_reachable
		if (p.dis[pos2num(_x, _y)] != -1 && p.dis[pos2num(_x, _y)] <= now_mobility) {
			draw_set_color(col_reachable);
			draw_set_alpha(0.25);
		}
		// Obstacles
		if (cells[_x][_y] == "x") {
			draw_set_color(c_red);
		}
		
		draw_cell(_x, _y);

		// The hovering position
		if (pos2num(_x, _y) == hover_num) {
			draw_set_color(col_hover_num);
			draw_set_alpha(0.25);
			draw_cell(_x, _y);
		}
		draw_set_alpha(1);
		
		//sign if edit mode
		if (edit_mode) {
			draw_text_transformed(abs_posx(_x), abs_posy(_y), cells[_x][_y], 4, 4, 0);
		}
	}
}

//draw the player cell
draw_set_color(col_now_num);
draw_set_alpha(0.5);
draw_cell(draw_pos[0], draw_pos[1]);

draw_sprite_ext(spr_character_on_map, 0, abs_posx(draw_pos[0]), abs_posy(draw_pos[1]), 3, 3, 0, c_white, 1);

draw_set_color(c_white);
draw_set_alpha(1);
draw_text_transformed(room_width/2, room_height - 100, "Turn " + string(now_turn), 10, 10, 0);
if (hover_num != undefined) {
	draw_text_transformed(room_width/2, room_height - 300, string(num2pos(hover_num)[0]) + "," + string(num2pos(hover_num)[1]), 10, 10, 0);
}