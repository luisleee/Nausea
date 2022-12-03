enum MOVE_PATTERN {
	NONE,
	VERTICAL,
	HORIZONTAL,
	COMIC,
}

function Movement (_pattern, _args) constructor {
	pattern = _pattern;
	args = _args;
}

function Image (_spr, _posx, _posy, _scalex, _scaley, _alpha, _movement) constructor {
	spr = _spr;
	pos_x = _posx;
	pos_y = _posy;
	scale_x = _scalex;
	scale_y = _scaley;
	alpha = _alpha;
	movement = _movement;
	static perform_movement = function() {
		var args = movement.args;
		if (movement.pattern == MOVE_PATTERN.NONE) {	
			draw_sprite_ext(spr, spr.sprite_index, pos_x, pos_y, scale_x, scale_y, 0, c_white , alpha);	
		}
		
		if (movement.pattern == MOVE_PATTERN.VERTICAL) {
			if (args.spd >= 0 and pos_y <= args.stop_y) {
				pos_y += args.spd;
			}
			if (args.spd <= 0 and pos_y >= args.stop_y) {
				pos_y += args.spd;
			}	
			draw_sprite_ext(spr, spr.sprite_index, pos_x, pos_y, scale_x, scale_y, 0, c_white , alpha);	
		}
		
		if (movement.pattern == MOVE_PATTERN.COMIC) {
			if (args.process < 1) {
				args.process += accel_get_velocity(0.003, args.process, 0.005);
			} else if (args.process > 1) {
				args.process = 1;
			}
			var process = args.process;
			draw_init(fnt_test, args.frame_col, "tl", 1);
			var pos_l = sprite_get_bbox_left(spr);
			var pos_r = sprite_get_bbox_right(spr);
			var pos_t = sprite_get_bbox_top(spr);
			var pos_b = sprite_get_bbox_bottom(spr);
			var ww = pos_r - pos_l;
			var hh = pos_b - pos_t;
			var pos_centre = pos_l + ww/2;
			var pos_middle = pos_t + hh/2;
			var border_w = 0.01 * display_get_gui_width();
			draw_rectangle(
				scale_x * (pos_centre - ww/2 * process) - border_w,
				scale_y * (pos_middle - hh/2 * process) - border_w,
				scale_x * (pos_centre + ww/2 * process) + border_w,
				scale_y * (pos_middle + hh/2 * process) + border_w,
				0
			);
				
			draw_sprite_part_ext(
				spr,
				0,
				pos_centre - (ww/2) * process,
				pos_middle - (hh/2) * process,
				ww * process,
				hh * process,
				(pos_centre - ww/2 * process) * scale_x,
				(pos_middle - hh/2 * process) * scale_y,
				scale_x,
				scale_y,
				c_white,
				1
			);
		
		}
	}
}

var no_movement = new Movement(MOVE_PATTERN.NONE, {});
var v1 = new Movement(MOVE_PATTERN.VERTICAL, {
	spd : -2,
	stop_y : -sprite_get_height(spr_sunrise),
});
var comic = new Movement(MOVE_PATTERN.COMIC, {
	frame_col : make_color_rgb(44,44,44),
	process : 0,
});

image_sources = [
	new Image(spr_frame_computer, 0, 0, 8, 8, 1, clone(comic)),
	new Image(spr_frame_shelf, 0, 0, 8, 8, 1, clone(comic)),
	new Image(spr_frame_bed, 0, 0, 8, 8, 1, clone(comic)),
	new Image(spr_frame_door, 0, 0, 8, 8, 1, clone(comic)),
	new Image(spr_bedroom_mess, 0, 0, 8, 8, 1, no_movement),
	new Image(spr_sunrise, 0, 0, 4, 4, 1, v1),
	new Image(spr_person_zp, 0, -200, 8, 8, 1, no_movement),
	new Image(spr_frame_bus, 0, 0, 4, 4, 1, clone(comic)),
];

imgs_bedroom = array_slice(image_sources, 0, 3);
imgs_bus = [image_sources[7]];

imgs = imgs_bus;