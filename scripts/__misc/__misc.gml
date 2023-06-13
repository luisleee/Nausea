function BackgroundMusic(_name, _intro, _main, _intro_beats, _main_beats, _bpm) constructor {
	name = _name;
	intro = _intro;
	main = _main;
	intro_beats = _intro_beats;
	main_beats = _main_beats;
	bpm = _bpm;
}

function Task(_name, _desc, _state, _process) constructor {
	name = _name;
	desc = _desc;
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

function ScheduleBlock(_name, _duration, _spr, _tags) constructor {
	name = _name;
	duration = _duration;
	spr = _spr;
	tags = _tags;
	type = "";
	for (var i = 0; i < array_length(tags); i ++) {
		if(tags[i].name == "opt") {
			type = "opt";
		}
		if(tags[i].name == "mst") {
			type = "mst";
		}
	}
}

function ScheduleTag(_name, _spr, _desc, _details) constructor {
	name = _name;
	spr = _spr;
	desc = _desc;
	details = _details;
}