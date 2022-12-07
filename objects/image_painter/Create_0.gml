enum MOVE_PATTERN {
	NONE,
	VERTICAL,
	HORIZONTAL,
	ZOOM,
}

#region
moves = array_create(4);
moves[MOVE_PATTERN.NONE] = function (img, args) {};
moves[MOVE_PATTERN.VERTICAL] = function (img, args) {
	if (args.spd >= 0 and img.pos_y <= args.stop_y) {
		img.pos_y += args.spd;
	}
	if (args.spd <= 0 and img.pos_y >= args.stop_y) {
		img.pos_y += args.spd;
	}	
};
moves[MOVE_PATTERN.ZOOM] = function (img, args) {
	if (args.process < 1) {
		var zoom_channel = animcurve_get_channel(ac_zoom, 0);
		args.process += animcurve_channel_evaluate(zoom_channel, args.process);
	} else if (args.process > 1) {
		args.process = 1;
	}
};
#endregion

#region
draws = array_create(4);
draws[MOVE_PATTERN.NONE] = function (img, args) {
	draw_sprite_ext(img.spr, img.spr.sprite_index, img.pos_x, img.pos_y, img.scale_x, img.scale_y, 0, c_white , img.alpha);		
};
draws[MOVE_PATTERN.VERTICAL] = function (img, args) {
	draw_sprite_ext(img.spr, img.spr.sprite_index, img.pos_x, img.pos_y, img.scale_x, img.scale_y, 0, c_white , img.alpha);		
};
draws[MOVE_PATTERN.ZOOM] = function (img, args) {
	var process = 0;
	if (args.mode == 0) {
		process = 1 - args.process;
	} else if (args.mode == 1) {
		process = args.process;
	}	
	draw_init(fnt_test, args.frame_col, "tl", 1);
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

var no_movement = new Movement(MOVE_PATTERN.NONE, {});
var v1 = new Movement(MOVE_PATTERN.VERTICAL, {
	spd : -2,
	stop_y : -sprite_get_height(spr_sunrise),
});
var zoom_in = new Movement(MOVE_PATTERN.ZOOM, {
	frame_col : make_color_rgb(44,44,44),
	process : 0,
	mode : 1
});

image_sources = [
	new Image(spr_frame_computer, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_frame_shelf, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_frame_bed, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_frame_door, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_bedroom_mess, 0, 0, 8, 8, 1, no_movement),
	new Image(spr_sunrise, 0, 0, 4, 4, 1, v1),
	new Image(spr_person_zp, 0, -200, 8, 8, 1, no_movement),
	new Image(spr_frame_bus, 0, 0, 4, 4, 1, clone(zoom_in)),
	new Image(spr_shashasha, 0, 0, 4, 4, 1, clone(zoom_in)),
];

imgs = [];