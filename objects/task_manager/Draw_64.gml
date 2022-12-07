///Draw the Task UI
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var text_scale = 3.5/1600 * gui_w;
var text_title_scale = 4.5/1600 * gui_w;
var text_state_scale = 2/1600 * gui_w;


var xoffset = 96/400 * gui_w;
var yoffset = 84/400 * gui_w;
var taskbar_yoffset = 8/400 * gui_w;
var scr_w = 208/400 * gui_w;
var scr_h = 120/400 * gui_w;

var taskbar_w = 44/400 * gui_w;
var pixel_w = 1/400 * gui_w;
var task_title_h = 24/400 * gui_w;
var task_h = 20/400 * gui_w;
var buffer = 4/400 * gui_w;

var text_col = make_color_rgb(78, 78, 78);
var scr_col = make_color_rgb(216, 228, 223);


var uiscale = 0.0025 * gui_w;

// move in or out
var process = pos_y/gui_h;
if (show_self) {
	if (pos_y > 0) {
		var zoom_channel = animcurve_get_channel(ac_task_manager, 0);
		pos_y -= animcurve_channel_evaluate(zoom_channel, 1 - process);
	} else if (pos_y < 0) {
		pos_y = 0;
	}
}
if (not show_self) {
	if (pos_y < gui_h) {
		var zoom_channel = animcurve_get_channel(ac_task_manager, 0);
		pos_y += animcurve_channel_evaluate(zoom_channel, process);
	} else if (pos_y > gui_h) {
		pos_y = gui_h;
	}
}

yoffset += pos_y;

// cover whatever is behind me
draw_init(fnt_test, c_black, "mc", (1 - process)/ 2);
draw_rectangle(0, 0, gui_w, gui_h, 0);

// draw the display screen
draw_set_alpha(1);
draw_set_color(scr_col);

draw_rectangle(
	xoffset, 
	yoffset,
	xoffset + scr_w,
	yoffset + scr_h,
	0
);

// draw the separate line
draw_set_color(text_col);
draw_rectangle(
	xoffset + taskbar_w,
	yoffset,
	xoffset + taskbar_w + pixel_w,
	yoffset + scr_h,
	0
);

// draw "task" title
draw_init(fnt_task_title, text_col, "mc", 1);
draw_text_transformed(
	xoffset + taskbar_w/2,
	yoffset + task_title_h/2,
	"任务",
	text_scale,
	text_scale,
	0
);

// draw task bar
draw_set_font(fnt_test);
for(var i = start_number; i < min(task_show_max + start_number, array_length(tasks)); i++) {
	var text_scale_compressed = text_scale;
	if (taskbar_w / string_width(tasks[i].name) < text_scale) {
		text_scale_compressed = taskbar_w / string_width(tasks[i].name);
	}
	var back_color = scr_col;
	var front_color = text_col;
	if(selected == i){
		back_color = text_col;
		front_color = scr_col;
	}
	draw_set_color(back_color);
	draw_rectangle(
		xoffset,
		yoffset + taskbar_yoffset + task_title_h + (i - start_number) * task_h,
		xoffset + taskbar_w,
		yoffset + taskbar_yoffset + task_title_h + (i + 1 - start_number) * task_h,
		0
	);
	draw_set_color(front_color);
	draw_text_transformed(
		xoffset + taskbar_w/2,
		yoffset + taskbar_yoffset + task_title_h + (i - start_number) * task_h + task_h/2,
		tasks[i].name,
		text_scale_compressed,
		text_scale,
		0
	);
}

// draw the arrows
draw_sprite_stretched_ext(
	spr_casio_list_down,
	subimg,
	0,
	pos_y,
	gui_w,
	gui_h,
	c_white,
	array_length(tasks) > start_number + task_show_max
);
draw_sprite_stretched_ext(
	spr_casio_list_up,
	subimg,
	0,
	pos_y,
	gui_w,
	gui_h,
	c_white,
	start_number > 0
);

// draw the description bar
draw_init(fnt_task_title, text_col, "tl", 1);
var text_area_w = scr_w - taskbar_w - buffer - pixel_w;
var text_scale_compressed = text_title_scale;
var title_h = string_height("M") * text_title_scale;
var selected_task = tasks[selected];
if (text_area_w / string_width(selected_task.name) < text_title_scale) {
	text_scale_compressed = text_area_w / string_width(selected_task.name);
}
draw_text_transformed(
	xoffset + taskbar_w + buffer,
	yoffset + buffer,
	selected_task.name,
	text_scale_compressed,
	text_title_scale,
	0
);

draw_init(fnt_test, text_col, "tl", 1);
var state_h = string_height("M") * text_state_scale;
var display_state = display_states[selected_task.state];
draw_text_transformed(
	xoffset + taskbar_w + buffer,
	yoffset + buffer * 2 + title_h,
	display_state,
	text_state_scale,
	text_state_scale,
	0
);
var display_text = string_wrap(selected_task.description, text_area_w, text_scale, "\n");
draw_text_transformed(
	xoffset + taskbar_w + buffer,
	yoffset + buffer * 3 + title_h + state_h,
	display_text,
	text_scale,
	text_scale,
	0
);
//draw the body
draw_sprite_stretched_ext(spr_casio, 0, 0, pos_y, gui_w, gui_h, c_white, 1);
draw_sprite_stretched_ext(spr_casio_keypressed_up, 0, 0, pos_y, gui_w, gui_h, c_white, keyboard_check(vk_up));
draw_sprite_stretched_ext(spr_casio_keypressed_down, 0, 0, pos_y, gui_w, gui_h, c_white, keyboard_check(vk_down));

