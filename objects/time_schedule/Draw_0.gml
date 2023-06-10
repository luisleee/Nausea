var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var bar_sep = 100;
var bar_h = 20;
var bar_y = gui_h/3;
var bar_frameline_w = 5;

draw_init(fnt_default, c_white, "tl", 1);

//Draw the bar
draw_rectangle(bar_sep, bar_y, gui_w - bar_sep, bar_y + bar_h, 0);
var time_scale = (gui_w - 2 * bar_sep) / (time_bar[1] - time_bar[0]);
var now_bar_off = 0;
var pre_gamma = bar_gamma;

previous_hovering_bar = hovering_bar;
hovering_bar = undefined;
for (var i = 0; i < array_length(schedule); i++) {
	var fill_col = c_white;
	switch schedule[i].type {
		case "opt": {
			fill_col = make_color_rgb(1, 0, 132);
		}
		break;
		case "mst": {
			fill_col = make_color_rgb(246, 47, 47);
		}
		break;
	}
	draw_set_color(fill_col);
	draw_rectangle(
		bar_sep + now_bar_off,
		bar_y,
		bar_sep + now_bar_off + schedule[i].duration * time_scale,
		bar_y + bar_h,
		0
	);
	
	
	if(point_in_rectangle(
		mouse_x,
		mouse_y,
		bar_sep + now_bar_off,
		bar_y,
		bar_sep + now_bar_off + schedule[i].duration * time_scale,
		bar_y + bar_h
	)){
		hovering_bar = i;
		if(hovering_bar != previous_hovering_bar and hovering_bar != undefined) {
			bar_gamma = 0;
		}
		draw_set_color(c_white);
		draw_set_alpha(bar_gamma/1.5);
		draw_rectangle(
			bar_sep + now_bar_off,
			bar_y,
			bar_sep + now_bar_off + schedule[i].duration * time_scale,
			bar_y + bar_h,
			0
		);
		draw_set_alpha(1);
	}
	
	
	//draw the sep lines
	draw_set_color(c_black);
	draw_rectangle(
		bar_sep + now_bar_off + schedule[i].duration * time_scale - bar_frameline_w,
		bar_y,
		bar_sep + now_bar_off + schedule[i].duration * time_scale,
		bar_y + bar_h,
		0
	)
	now_bar_off += schedule[i].duration * time_scale;
}

if(hovering_bar != previous_hovering_bar) {
	if (previous_hovering_bar != undefined) {
		array_push(card_animation, {num: schedule_num[previous_hovering_bar], process: rot2process(card_rot)});		
		for (var j = 0; j < array_length(bar_animation); j ++) {
			if(bar_animation[j].num = previous_hovering_bar) {
				bar_animation = array_remove(bar_animation, j);
				j --;
			}
		}
		array_push(bar_animation, {num: previous_hovering_bar, gamma: pre_gamma});
	}
	
	card_rot = card_rot_ori;
	card_apa = 0;
	previous_hovering_bar = hovering_bar;
}	

//draw single cards
for (var i = 0; i < block_num; i ++){
	if(!surface_exists(card_surf[i])) {
		card_surf[i] = surface_create(card_w, card_h);
	}
	var this_card = blocks[i];
	surface_set_target(card_surf[i]);
	draw_clear_alpha(c_white, 0);
	draw_sprite_stretched(this_card.spr, 0, 0, 0, card_w, card_h);
	
	//tags
	var tag_num = array_length(this_card.tags);
	var type = this_card.type;
	for (var j = 0; j < tag_num; j ++) {
		var this_tag = this_card.tags[j];
		draw_sprite_stretched(this_tag.spr, 0, (51 - j * 8) * card_scale, 6 * card_scale, 7 * card_scale, 7 * card_scale);
	}
	
	//draw name
	var name_col = c_white;
	var time_col = c_white;
	switch type {
		case "opt": {
			name_col = make_color_rgb(15, 24, 92);
			time_col = make_color_rgb(1, 0, 132);
		}
		break;
		case "mst": {
			name_col = make_color_rgb(137, 0, 0);
			time_col = make_color_rgb(246, 47, 47);
		}
		break;
		
	}
	
	draw_init(fnt_task_title, name_col, "tr", 1);
	draw_text_transformed(59 * card_scale, 57 * card_scale, this_card.name, 3 * card_scale/6, 3 * card_scale/6, 14.5);
	
	
	//draw card time bar
	draw_set_color(time_col);
	draw_rectangle(5 * card_scale, 13 * card_scale, 8 * card_scale, (13 + 51 * this_card.duration/2) * card_scale, 0);
	
	
	surface_reset_target();
	
	//draw_surface(card_surf[i], 600 + i * 400, 100);
}

//Detect the hovering one and Draw the Cards
previous_hovering_block = hovering_block;
hovering_block = undefined;
var line_max_block = floor((gui_w - 2 * bar_sep) / (block_w + block_sep));
for (var i = 0; i < array_length(optional_blocks); i ++) {
	var h_pos = i % line_max_block;
	var v_pos = get_quotient(i, line_max_block);
	var col = block_selected[i] ? c_gray : c_white;
	draw_set_color(col);
	
	/*draw_rectangle(
	bar_sep + h_pos * (block_w + block_sep),
	bar_sep + gui_h/2 + v_pos * (block_h + block_sep),
	bar_sep + h_pos * (block_w + block_sep) + block_w,
	bar_sep + gui_h/2 + block_h + v_pos * (block_h + block_sep),
	0
	);*/
	
	draw_surface_stretched(
		card_surf[block_now_num[i]],
		bar_sep + h_pos * (block_w + block_sep),
		bar_sep + block_yoff + v_pos * (block_h + block_sep),
		block_w,
		block_h
	);
	
	if(point_in_rectangle(
		mouse_x,
		mouse_y,
		bar_sep + h_pos * (block_w + block_sep),
		bar_sep + block_yoff + v_pos * (block_h + block_sep),
		bar_sep + h_pos * (block_w + block_sep) + block_w,
		bar_sep + block_yoff + block_h + v_pos * (block_h + block_sep)
	)){
		hovering_block = i;
	}
}
if(hovering_block != previous_hovering_block) {
	if (previous_hovering_block != undefined and previous_hovering_block != array_length(optional_blocks)) {
		array_push(card_animation, {num: block_now_num[previous_hovering_block], process: rot2process(card_rot)});
		
	}
	card_rot = card_rot_ori;
	card_apa = 0;
	previous_hovering_block = hovering_block;
}

//Draw the past Bars
draw_set_color(c_white);
for (var i = 0; i < array_length(bar_animation); i ++) {
	var this_ani = bar_animation[i];
	
	var now_bar_off = 0;
	for (var j = 0; j < this_ani.num; j++) {
		now_bar_off += schedule[j].duration * time_scale;
	}
	var gam = this_ani.gamma;
	draw_set_alpha(gam/1.5);
	draw_rectangle(
		bar_sep + now_bar_off,
		bar_y,
		bar_sep + now_bar_off + schedule[this_ani.num].duration * time_scale - bar_frameline_w,
		bar_y + bar_h,
		0
	);
	bar_animation[i].gamma -= 0.125;
	if (bar_animation[i].gamma < 0) { 
		bar_animation = array_remove(bar_animation, i);
		i --;
	}	
}
draw_set_alpha(1);

//Draw the covering White bar
if ((bar_show_left - time_bar[0]) != (time_bar[1] - time_bar[0])) {
	draw_set_color(c_white);
	draw_rectangle(
		bar_sep + (bar_show_left - time_bar[0]) * time_scale,
		bar_y,
		bar_sep + (time_bar[1] - time_bar[0]) * time_scale,
		bar_y + bar_h,
		0
	);
}

//Draw the past cards
draw_set_align("tl");
draw_set_color(c_white);

for (var i = 0; i < array_length(card_animation); i ++) {
	var this_ani = card_animation[i];
	var apa = -abs(this_ani.process - 1) + 1;
	var rot = process2rot(this_ani.process);
	draw_surface_general(
		card_surf[card_animation[i].num],
		card_w, 
		card_h,
		-card_w,
		-card_h,
		gui_w + 50,
		gui_h - 100,
		1,
		1,
		rot,
		c_white,
		c_white,
		c_white,
		c_white,
		apa
	);
	
	card_animation[i].process += 0.05;
	if (card_animation[i].process > 2) { 
		card_animation = array_remove(card_animation, i);
		i --;
	}
	
}

//Draw the hovering one and its desc
draw_set_align("tl");
draw_set_color(c_white);

	
if(hovering_block != undefined or hovering_bar != undefined) {
	var hover_num = undefined;
	if (hovering_block != undefined){
		hover_num = block_now_num[hovering_block];
		var this_block = blocks[hover_num];
	}
	if (hovering_bar != undefined){
		var this_block = schedule[hovering_bar];
		hover_num = schedule_num[hovering_bar];
	}
	draw_surface_general(
		card_surf[hover_num],
		card_w, 
		card_h,
		-card_w,
		-card_h,
		gui_w + 50,
		gui_h - 100,
		1,
		1,
		card_rot,
		c_white,
		c_white,
		c_white,
		c_white,
		card_apa
	);
	//draw_surface_ext(card_surf[hovering_block], gui_w - card_w, gui_h - card_h, 1, 1, 30, c_white, 1);
	
	var name_y = gui_h/2 - 100;
	draw_set_font(fnt_task_title);
	draw_text_transformed(
		bar_sep,
		name_y,
		this_block.name,
		4,
		4,
		0
	);
	
	var desc_y = name_y + string_height("M") * 4 + bar_sep;
	var tag_scale = 3;
	var tag_w = sprite_get_width(spr_schedule_tags_opt) * tag_scale;
	for (var i = 0; i < array_length(this_block.tags); i ++) {
		var this_tag = this_block.tags[i];
		draw_sprite_ext(
			this_tag.spr,
			0,
			bar_sep,
			desc_y + i * bar_sep,
			tag_scale,
			tag_scale,
			0,
			c_white,
			1
		);
		
		draw_set_font(fnt_default);
		draw_set_align("ml");
		draw_text_transformed(
			bar_sep + tag_w + bar_sep/4,
			desc_y + tag_w/2 + i * bar_sep,
			this_tag.desc,
			tag_scale,
			tag_scale,
			0
		);
	}
	
	draw_text_transformed(
		100,
		100,
		this_block.name + " " + string(blocks[hover_num].duration) + "小时",
		4,
		4,
		0
	);
}



