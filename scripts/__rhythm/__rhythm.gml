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