enum MOVE_PATTERN {
	NONE,
	VERTICAL,
	HORIZONTAL,
}

function Pattern (_type, _args) constructor {
	type = _type;
	args = _args;
}

function Image (_spr, _posx, _posy, _scalex, _scaley, _alpha, _pattern) constructor {
	spr = _spr;
	pos_x = _posx;
	pos_y = _posy;
	scale_x = _scalex;
	scale_y = _scaley;
	alpha = _alpha;
	pattern = _pattern;
	static perform_movement = function() {
		var args = pattern.args;
		if (pattern.type == MOVE_PATTERN.VERTICAL) {
			if (args.spd >= 0 and pos_y <= args.stop_y) {
				pos_y += args.spd;
			}
			if (args.spd <= 0 and pos_y >= args.stop_y) {
				pos_y += args.spd;
			}	
		}
	}
}

var no_movement = new Pattern(MOVE_PATTERN.NONE, {});
var v1 = new Pattern(MOVE_PATTERN.VERTICAL, {
	spd : -2,
	stop_y : -sprite_get_height(spr_sunrise),
});

image_sources = [
	new Image(spr_bedroom_f_computer, 0, 0, 4, 4, 1, no_movement),
	new Image(spr_bedroom_mess, 0, 0, 8, 8, 1, no_movement),
	new Image(spr_sunrise, 0, 0, 4, 4, 1, v1),
	new Image(spr_person_zp, 0, -200, 8, 8, 1, no_movement),
];

imgs = [image_sources[2], image_sources[3]];
