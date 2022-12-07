function BackgroundMusic(_name, _intro, _main, _intro_beats, _main_beats, _bpm) constructor {
	name = _name;
	intro = _intro;
	main = _main;
	intro_beats = _intro_beats;
	main_beats = _main_beats;
	bpm = _bpm;
}

function Task(_name, _description, _state, _process) constructor {
	name = _name;
	description = _description;
	state = _state;
	process = _process;
}

function Movement (_pattern, _args) constructor {
	pattern = _pattern;
	args = _args;
}

function Animation (_in, _main, _out) constructor {
	in = _in;
	main = _main;
	out = _out;
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
		
		if (movement.pattern == MOVE_PATTERN.ZOOM) {
			if (args.process < 1) {
				var zoom_channel = animcurve_get_channel(ac_zoom, 0);
				args.process += animcurve_channel_evaluate(zoom_channel, args.process);
			} else if (args.process > 1) {
				args.process = 1;
			}
			if(args.mode == 0){
				var process = 1 - args.process;
			}
			if(args.mode == 1){
				var process = args.process;
			}
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
				scale_x * (pos_centre - ww/2 * process) - border_w * process,
				scale_y * (pos_middle - hh/2 * process) - border_w * process,
				scale_x * (pos_centre + ww/2 * process) + border_w * process,
				scale_y * (pos_middle + hh/2 * process) + border_w * process,
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