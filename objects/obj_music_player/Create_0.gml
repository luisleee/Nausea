function MusicPiece(_name, _intro, _main, _intro_len, _main_len, _bpm) constructor {
	name = _name;
	intro = _intro;
	main = _main;
	intro_len = _intro_len;
	main_len = _main_len;
	bpm = _bpm;
	static f = function() {
		show_debug_message(name);	
	}
}

var music = new MusicPiece("day", snd_ost_day_intro, snd_ost_day_main, 2 * 3,32 * 3, 93);
music.f();

cur_music = music;
enum playState{
	before,
	playing,
	played,
}
intro_play_process = playState.before;
cur_time = current_time;