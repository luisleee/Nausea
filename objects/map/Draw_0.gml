draw_init(fnt_test, c_white, "mc", 1);
reachable_cells = ds_queue_create();
ds_queue_enqueue(reachable_cells, now_cell);
for(var xx = 1; xx <= map_width; xx ++){
	for(var yy = 1; yy <= map_height; yy ++){
		var queue_head = ds_queue_head(reachable_cells);
		var mobility_requirement = abs(xx - queue_head.pos[0]) + abs(yy - queue_head.pos[1]);
		if (mobility_requirement <= queue_head.mobility){
			var new_cell = new Reachable([xx, yy], [], queue_head.mobility - mobility_requirement);
			ds_queue_enqueue(reachable_cells, new_cell);
		}
	}
}

while(not ds_queue_empty(reachable_cells)){
	var queue_head = ds_queue_dequeue(reachable_cells);
	array_push(now_reachable_cells, queue_head.pos);
	//draw_set_color(c_red);
	//draw_circle(x + 100 * queue_head.pos[0], y + 100 * queue_head.pos[1], 5, 0);
}

//draw the unit cells

for(var xx = 1; xx <= map_width; xx ++){
	for(var yy = 1; yy <= map_height; yy ++){
		draw_set_color(c_white);
		if(array_includes(now_reachable_cells, [xx, yy])){
			draw_set_color(c_yellow);
		}
		if(are_equal(now_pos, [xx, yy])){
			draw_set_color(c_aqua);
		}
		if(not is_undefined(hover_pos) and are_equal(hover_pos, [xx, yy])){
			draw_set_color(c_lime);
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
draw_set_alpha(c_white);
draw_set_alpha(movement_apa);
draw_line_width(
	x + last_pos[0] * cell_w,
	y + last_pos[1] * cell_h,
	x + now_pos[0] * cell_w,
	y + now_pos[1] * cell_h,
	5
);

draw_set_alpha(1);
draw_text_transformed(1500, 500, "Turn " + string(now_turn), 10, 10, 0);