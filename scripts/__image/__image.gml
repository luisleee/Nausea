function Movement(_repetitive, _default_value, _args) constructor {
	finished = false;
	repetitive = _repetitive;

	move = function() {};

	_default_value = is_undefined(_default_value) ? {} : _default_value;
	_args = is_undefined(_args) ? {} : _args;

	struct_extend(_args, _default_value);
	struct_extend(self, _args);
}

function NoMovement() constructor {
	struct_extend(self, new Movement(true));
}


function PingPongMovement(_horizontal, _args) constructor {
	horizontal = _horizontal;
	
	struct_extend(self, new Movement(true, {
		t: 0,
		amplitude: 50,
		period: 1/2,
		init_phase: 0,
	}, _args));
	
	move = function(img) {
		t += 1 / fps;
		var road_channel = animcurve_get_channel(ac_road, 0);
		var offset = amplitude * animcurve_channel_evaluate(road_channel, get_remainder(init_phase + t, period) / period);
		if (horizontal) {
			img.xoffset = offset;
		} else {
			img.yoffset = offset;
		}
	}
}

function ZoomMovement(_zoom_in, _args) constructor {
	zoom_in = _zoom_in;

	struct_extend(self, new Movement(false, {
		process: 0,
	}, _args));

	move = function(img) {
		if (!zoom_in and process >= 0.7) {
			finished = true;
		}

		if (process < 1) {
			var zoom_channel = animcurve_get_channel(ac_zoom, 0);
			process += animcurve_channel_evaluate(zoom_channel, process);
		} else {
			process = 1;
			finished = true;
		}
		var scale = zoom_in ? process : 1 - process;

		img.zoom_scale = scale;
	}
}

function ParallelMovement(_moves) constructor {
	struct_extend(self, new Movement(false));
	
	moves = _moves;
	move = function (img) {
		finished = true;
		for (var i = 0; i < array_length(moves); i++) {
			var m = moves[i];
			if (!m.repetitive and !m.finished) {
				finished = false;
				m.move(img);
			}
			if (m.repetitive) {
				m.move(img);
			}
		}
	}
}

function SequentialMovement(_moves) constructor {
	struct_extend(self, new Movement(false));

	moves = _moves;
	index = 0;
	move = function(img) {
		var cur_move = moves[index];
		if (cur_move.repetitive or cur_move.finished) {
			if (index >= array_length(moves) - 1) {
				finished = true;
				return;
			} else {
				index++;
			}
		}
		moves[index].move(img);
	}
}


function Image (_spr, _class, _posx, _posy, _comic, _movements, _args) constructor {
	spr = _spr;
	class = _class;
	pos_x = _posx;
	pos_y = _posy;
	comic = _comic;
	// default args
	struct_extend(_args, {
		xoffset: 0,
		yoffset: 0,
		scale_x: 1,
		scale_y: 1,
		alpha: 1,
		frame_col: make_color_rgb(44, 44, 44),
	});
	struct_extend(self, _args);
	
	movements = new MovementGroup(_movements);
	
	draw = function () {
		if (!comic) {
			draw_sprite_ext(spr, spr.sprite_index, pos_x + xoffset, pos_y + yoffset, scale_x, scale_y, 0, c_white , alpha);
			return;
		}

		draw_init(fnt_default, frame_col, "tl", 1);
		var pos_l = sprite_get_bbox_left(spr);
		var pos_r = sprite_get_bbox_right(spr);
		var pos_t = sprite_get_bbox_top(spr);
		var pos_b = sprite_get_bbox_bottom(spr);
		var ww = pos_r - pos_l;
		var hh = pos_b - pos_t;
		var pos_centre = pos_l + ww/2;
		var pos_middle = pos_t + hh/2;
		var border_w = 0.01 * display_get_gui_width();
		
		// pos_center - ww/2 * zm_scale = posl + (ww/2)*(1-p)
		// pos_center + ww/2 * zm_scale = posr - (ww/2)*(1-p)
		draw_rectangle(
			xoffset + scale_x * (pos_centre - ww/2 * zoom_scale) - border_w * zoom_scale,
			yoffset + scale_y * (pos_middle - hh/2 * zoom_scale) - border_w * zoom_scale,
			xoffset + scale_x * (pos_centre + ww/2 * zoom_scale) + border_w * zoom_scale,
			yoffset + scale_y * (pos_middle + hh/2 * zoom_scale) + border_w * zoom_scale,
			0
		);	
		draw_sprite_part_ext(
			spr,
			0,
			pos_centre - (ww/2) * zoom_scale,
			pos_middle - (hh/2) * zoom_scale,
			ww * zoom_scale,
			hh * zoom_scale,
			xoffset + (pos_centre - ww/2 * zoom_scale) * scale_x,
			yoffset + (pos_middle - hh/2 * zoom_scale) * scale_y,
			scale_x,
			scale_y,
			c_white,
			1
		);
	};
	move = function (_stage) {
		movements.current().move(self);
	};
}

function MovementGroup(_movements) constructor {
	assert("_movements is array", typeof(_movements) == "array");
	assert("_movements is 3-ary array", array_length(_movements) == 3);

	movements = _movements;
	phase = 0;
	start_phase = function () {
		return phase == 0;
	}
	end_phase = function () {
		return phase == 2;
	}
	current = function () {
		return movements[phase];
	}
	next = function () {
		if (!end_phase()) {
			phase++;
		}
	}
	ready = function() {
		return start_phase() and (current().repetitive or current().finished);	
	}
	dead = function() {
		return end_phase() and (current().repetitive or current().finished);	
	}
}

function createMovement(obj) {
	if (obj.type == "no") {
		return new NoMovement();
	} else if (obj.type == "zoom") {
		var args = variable_struct_get(obj, "args");
		return new ZoomMovement(obj.in, args);
	} else if (obj.type == "pingpong") {
		var args = variable_struct_get(obj, "args");
		return new PingPongMovement(obj.horizontal, args);
	} else if (obj.type == "parallel") {
		var movs = array_map(obj.movements, function(mov) {
			return createMovement(mov);
		});
		return new ParallelMovement(movs);
	} else if (obj.type == "sequential") {
		var movs = array_map(obj.movements, function(mov) {
			return createMovement(mov);
		});
		return new SequentialMovement(movs);
	}
}

function createImage(obj) {
	var movs = array_map(obj.movements, function(mov) {
		return createMovement(mov);
	});
	return new Image(obj.spr, obj.class, obj.posx, obj.posy, obj.comic, movs, obj.args);
}