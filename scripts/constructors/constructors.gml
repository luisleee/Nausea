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


function Movement (_type, _move, _args) constructor {
	if (_type == "basic") {
		move = _move;
		args = _args;
	} else if (_type == "parallel") {
		moves = _move;
		args = _args;
		args.finished = false;
		move = function (img, args) {
			args.finished = true;
			for (var i = 0; i < array_length(moves); i++) {
				var m = moves[i];
				if (variable_instance_exists(m.args, "finished") and !m.args.finished) {
					args.finished = false;
					m.move(img, m.args);
				}
				if (!variable_instance_exists(m.args, "finished")) {
					m.move(img, m.args);
				}
			}
		}
	} else if (_type == "sequence") {
		moves = _move;
		index = 0;
		args = _args;
		args.finished = false;
		move = function(img, args) {
			if (!variable_instance_exists(moves[index].args, "finished") or moves[index].args.finished) {
				if (index >= array_length(moves) - 1) {
					args.finished = true;
					return;
				} else {
					index++;
				}
			}
			moves[index].move(img, moves[index].args);
		}
	}
}

function Image (_spr, _posx, _posy, _xoffset, _yoffset, _scalex, _scaley, _alpha, _movements, _draw) constructor {
	spr = _spr;
	pos_x = _posx;
	pos_y = _posy;
	xoffset = _xoffset;
	yoffset = _yoffset;
	scale_x = _scalex;
	scale_y = _scaley;
	alpha = _alpha;
	movements = _movements;
	draw = _draw;
	move = function (_stage) {
		movements[_stage].move(self, movements[_stage].args);
	};
}

function ImageGroup(_name, _stage, _imgs) constructor {
	name = _name;
	stage = _stage;
	imgs = _imgs;
	draw = function () {
		for (var i = 0; i < array_length(imgs); i++) {
			imgs[i].draw(imgs[i]);
		}
	};
	move = function () {
		for (var i = 0; i < array_length(imgs); i++) {
			imgs[i].move(stage);
		}	
	};
	finished = function () {
		for (var i = 0; i < array_length(imgs); i++) {
			var img = imgs[i];
			if (variable_instance_exists(img.movements[stage].args, "finished") and !img.movements[stage].args.finished) {
				return false;
			}
		}
		return true;
	};
	next_stage = function () {
		if (stage < 2) {
			stage++;
		}
	};
}

function MapInfo(_name, _spr, _signs, _trans_cells, _event_cells) constructor {
	name = _name;
	spr = _spr; 
	signs = _signs;
	trans_cells = _trans_cells;
	event_cells = _event_cells;
}

function TransCell(_pos, _to_map, _to_pos) constructor {
	pos = _pos;
	to_map = _to_map;
	to_pos = _to_pos;
}

function EventCell(_pos, _event_chain) constructor {
	pos = _pos;
	event_chain = _event_chain;
}