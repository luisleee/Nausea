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

function TextEffect(_color, _shake, _halt, _float) constructor {
	color = _color;
	shake = _shake;
	halt = _halt;
	float = _float;
}

function FloatTextInfo(_range, _spd, _init_phase) constructor {
	range = _range;
	spd = _spd;
	init_phase = _init_phase;
}