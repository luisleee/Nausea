draw_init(fnt_default, c_white, "mc", 1);

var col_reachable = c_yellow;
var col_now_pos = c_aqua;

var my_path = find_path(now_pos, goal_pos);

//draw the unit cells

for (var xx = 1; xx <= map_width; xx++) {
	for (var yy = 1; yy <= map_height; yy++) {
		draw_set_color(c_white);
		if(my_path.dis[pos2number(xx, yy)] <= now_mobility) {
			draw_set_color(col_reachable);
		}
		
		
		/*if (pos2number(xx, yy) == now_pos) {
			draw_set_color(col_now_pos);
		}*/
		if (pos2number(xx, yy) == hover_pos) {
			draw_set_color(c_lime);
		}
		if (cells[xx - 1][yy - 1] != "o") {
			draw_set_color(c_red);
		}
		draw_set_alpha(0.5);
		draw_rectangle(
			abs_posx(xx) - cell_w/2,
			abs_posy(yy) - cell_h/2, 
			abs_posx(xx) + cell_w/2,
			abs_posy(yy) + cell_h/2,
			0
		);
		draw_set_alpha(1);
		draw_circle(abs_posx(xx), abs_posy(yy), 5, 1);
	}
}
draw_set_color(c_white);

//draw the player cell
draw_set_color(col_now_pos);
draw_set_alpha(0.5);
draw_rectangle(
	abs_posx(draw_pos[0]) - cell_w/2,
	abs_posy(draw_pos[1]) - cell_h/2, 
	abs_posx(draw_pos[0]) + cell_w/2,
	abs_posy(draw_pos[1]) + cell_h/2,
	0
);

draw_set_alpha(1);
draw_circle(abs_posx(xx), abs_posy(yy), 5, 1);


draw_set_alpha(1);
draw_text_transformed(1500, 500, "Turn " + string(now_turn), 10, 10, 0);