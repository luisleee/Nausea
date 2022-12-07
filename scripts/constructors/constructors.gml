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


function Image (_spr, _posx, _posy, _scalex, _scaley, _alpha, _movement) constructor {
	spr = _spr;
	pos_x = _posx;
	pos_y = _posy;
	scale_x = _scalex;
	scale_y = _scaley;
	alpha = _alpha;
	movement = _movement;
	static move = function() {
		image_painter.moves[movement.pattern](self, movement.args);
	}
	static draw = function() {
		image_painter.draws[movement.pattern](self, movement.args);
	}
}