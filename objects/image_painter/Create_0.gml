enum MOVE_PATTERN {
	NONE,
	VERTICAL,
	HORIZONTAL,
	ZOOM,
}

#region basic_moves
basic_moves = array_create(4);
basic_moves[MOVE_PATTERN.NONE] = function (img, args) {};
basic_moves[MOVE_PATTERN.VERTICAL] = function (img, args) {
	if (args.spd >= 0 and img.pos_y >= args.stop_y) {
		args.finished = true;
	}
	if (args.spd >= 0 and img.pos_y <= args.stop_y) {
		args.finished = true;
	}
	if (!args.finished) {
		img.pos_y += args.spd;	
	}
};
basic_moves[MOVE_PATTERN.ZOOM] = function (img, args) {
	if (args.process < 1) {
		var zoom_channel = animcurve_get_channel(ac_zoom, 0);
		args.process += animcurve_channel_evaluate(zoom_channel, args.process);
	} else {
		args.process = 1;
		args.finished = true;
	}

	variable_instance_set(img, "zoom_process", args.process);
	variable_instance_set(img, "zoom_mode", args.mode);
	variable_instance_set(img, "zoom_frame_col", args.frame_col);
};
#endregion
#region draws
draws = array_create(2);
draws[0] = function (img) {
	draw_sprite_ext(img.spr, img.spr.sprite_index, img.pos_x, img.pos_y, img.scale_x, img.scale_y, 0, c_white , img.alpha);		
};
draws[1] = function (img) {
	if (!variable_instance_exists(img, "zoom_process")) {
		return;
	}
	if (!variable_instance_exists(img, "zoom_mode")) {
		return;
	}
	if (!variable_instance_exists(img, "zoom_frame_col")) {
		return;
	}
	
	var mode = img.zoom_mode;
	var zoom_process = img.zoom_process;
	var process = 0;
	if (mode == 0) {
		process = 1 - zoom_process;
	} else if (mode == 1) {
		process = zoom_process;
	}	
	draw_init(fnt_test, img.zoom_frame_col, "tl", 1);
	var pos_l = sprite_get_bbox_left(img.spr);
	var pos_r = sprite_get_bbox_right(img.spr);
	var pos_t = sprite_get_bbox_top(img.spr);
	var pos_b = sprite_get_bbox_bottom(img.spr);
	var ww = pos_r - pos_l;
	var hh = pos_b - pos_t;
	var pos_centre = pos_l + ww/2;
	var pos_middle = pos_t + hh/2;
	var border_w = 0.01 * display_get_gui_width();
	draw_rectangle(
		img.scale_x * (pos_centre - ww/2 * process) - border_w * process,
		img.scale_y * (pos_middle - hh/2 * process) - border_w * process,
		img.scale_x * (pos_centre + ww/2 * process) + border_w * process,
		img.scale_y * (pos_middle + hh/2 * process) + border_w * process,
		0
	);	
	draw_sprite_part_ext(
		img.spr,
		0,
		pos_centre - (ww/2) * process,
		pos_middle - (hh/2) * process,
		ww * process,
		hh * process,
		(pos_centre - ww/2 * process) * img.scale_x,
		(pos_middle - hh/2 * process) * img.scale_y,
		img.scale_x,
		img.scale_y,
		c_white,
		1
	);
};
#endregion

var no_movement = new Movement("basic", basic_moves[MOVE_PATTERN.NONE], {});
var v1 = new Movement("basic", basic_moves[MOVE_PATTERN.VERTICAL], {
	spd: -2,
	stop_y: -sprite_get_height(spr_sunrise),
	finished: false,
});
var zoom_in = new Movement("basic", basic_moves[MOVE_PATTERN.ZOOM], {
	frame_col: make_color_rgb(44,44,44),
	process: 0,
	mode: 1,
	finished: false,
});
var zoom_out = new Movement("basic", basic_moves[MOVE_PATTERN.ZOOM], {
	frame_col: make_color_rgb(44,44,44),
	process: 0,
	mode: 0,
	finished: false,
});
var f = new Movement("basic", function(img, args) {img.pos_x += 1; args.finished = img.pos_x > 200;}, {finished:false});
var g = new Movement("basic", function(img, args) {img.pos_y += 1; args.finished = img.pos_y > 0;}, {finished:false});
var h = new Movement("basic", function(img, args) {img.alpha -= 0.01; args.finished = img.alpha <= 0.5;}, {finished:false});
var _h = new Movement("basic", function(img, args) {img.alpha += 0.01; args.finished = img.alpha >= 1;}, {finished:false});
var h_f = new Movement("sequence", [h, f], {});
var h_f_g = new Movement("parallel", [h_f, g], {});
var composed = new Movement("sequence", [h_f_g, _h], {});

image_sources = [
	new Image(spr_frame_computer, 0, 0, 8, 8, 1, [clone(zoom_in), no_movement, clone(zoom_out)], draws[1]),
	new Image(spr_frame_shelf, 0, 0, 8, 8, 1, [clone(zoom_in), no_movement, clone(zoom_out)], draws[1]),
	new Image(spr_frame_bed, 0, 0, 8, 8, 1, [clone(zoom_in), no_movement, clone(zoom_out)], draws[1]),
	new Image(spr_frame_door, 0, 0, 8, 8, 1, [clone(zoom_in), no_movement, clone(zoom_out)], draws[1]),
	new Image(spr_sunrise, 0, 0, 4, 4, 1, [v1, no_movement, no_movement], draws[0]),
	new Image(spr_person_zp, 0, -200, 8, 8, 1, [no_movement, composed, no_movement], draws[0]),
	new Image(spr_frame_bus, 0, 0, 4, 4, 1, [clone(zoom_in), no_movement, clone(zoom_out)], draws[1]),
	new Image(spr_shashasha, 0, 0, 4, 4, 1, [clone(zoom_in), no_movement, clone(zoom_out)], draws[1]),
];

img_groups = [
	new ImageGroup("g1", 0, array_slice(image_sources, 0, 3)),
	new ImageGroup("g2", 0, [image_sources[6], image_sources[5]]),
];

imgs = [];

img_queue = [];

function add_image_group(_name) {
	for (var i = 0; i < array_length(img_groups); i++) {
		var img_g = img_groups[i];
		if (img_g.name == _name) {
			array_push(img_queue, clone(img_g));
			return;
		}
	}
}

function remove_image_group(_name) {
	for (var i = 0; i < array_length(imgs); i++) {
		var img_g = imgs[i];
		if (img_g.name == _name) {
			imgs = array_remove(imgs, i);
			img_g.next_stage();
			array_push(img_queue, img_g);
			return;
		}
	}
}