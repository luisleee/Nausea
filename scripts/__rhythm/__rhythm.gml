function RhythmTrack(_track_mode, _name, _infos) constructor {
	track_mode = _track_mode;
	name = _name;
	switch _track_mode {
		case RHYTHM_TRACK_MODES.NOTE:
			key = _infos.key;
			icon = _infos.icon;
			timbre = _infos.timbre;
			notes = _infos.notes;
			break;
		case RHYTHM_TRACK_MODES.SHOW:
			movement = _infos.movement;
			keyframes = _infos.keyframes;
			details = _infos.details;
			break;
	}
}

function RhythmNoteInfo (_key, _icon, _timbre, _notes) constructor {
	key = _key;
	icon = _icon;
	timbre = _timbre;
	notes = _notes;
}
function RhythmShowInfo (_movement, _keyframes, _details) constructor {
	movement = _movement;
	keyframes = _keyframes;
	details = _details;
}

function SnowflakeInfo (_keyframes, _start_pos, _end_pos) constructor {
	kfs = _keyframes;
	last_frame = array_last(kfs);
	start_pos = _start_pos;
	end_pos = _end_pos;
	petal_num = array_length(_keyframes);
	now_petal_num = petal_num;
	randomize();
	init_rot = random_range(0, 360);
	rot_spd = random_range_multi([[-2, 0], [0, 2]]);
}