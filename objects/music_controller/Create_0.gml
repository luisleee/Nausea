function BackgroundMusic(_name, _intro, _main, _intro_beats, _main_beats, _bpm) constructor {
	name = _name;
	intro = _intro;
	main = _main;
	intro_beats = _intro_beats;
	main_beats = _main_beats;
	bpm = _bpm;
}

var music = new BackgroundMusic("day", snd_ost_day_intro, snd_ost_day_main, 2 * 3, 32 * 3, 93);

music_pieces = [music];

function get_music(name) {
	var len = array_length(music_pieces);
	for (var i = 0; i < len; i++) {
		if (music_pieces[i].name == name) {
			return music_pieces[i];
		}
	}
	return undefined;
}

function set_background_music(name) {
	var music = get_music(name);
	assert("music is not undefined", !is_undefined(music))
	music_player.set_music(music);
}

//alarm[0] = 1;

//set_background_music("day");