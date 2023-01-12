draw_init(fnt_default, c_white, "mc", 1);

//draw the unit cells

for (var xx = 1; xx <= map_width; xx++) {
	for (var yy = 1; yy <= map_height; yy++) {
		draw_set_color(c_white);
		if (pos2number(xx, yy) == now_pos) {
			draw_set_color(c_aqua);
		}
		if (pos2number(xx, yy) == hover_pos) {
			draw_set_color(c_lime);
		}
		if (cells[xx - 1][yy - 1] != "o") {
			draw_set_color(c_red);
		}
		draw_set_alpha(0.5);
		draw_rectangle(
			x + xx * cell_w - cell_w/2,
			y + yy * cell_h - cell_h/2, 
			x + xx * cell_w + cell_w/2,
			y + yy * cell_h + cell_h/2,
			0
		);
		draw_set_alpha(1);
		draw_circle(abs_posx(xx), abs_posy(yy), 5, 1);
	}
}
draw_set_color(c_white);
draw_set_alpha(movement_apa);
draw_line_width(
	x + number2pos(last_pos)[0] * cell_w,
	y + number2pos(last_pos)[1] * cell_h,
	x + number2pos(now_pos)[0] * cell_w,
	y + number2pos(now_pos)[1] * cell_h,
	5
);

draw_set_alpha(1);
draw_text_transformed(1500, 500, "Turn " + string(now_turn), 10, 10, 0);