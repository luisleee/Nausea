now_song = "something changed";
note_start = [9126, 9285, 9661, 10170, 11907, 12447, 13210, 13438, 13708, 14195, 17262, 17511, 17797, 18305, 18829, 19338, 20339, 20604, 21351, 21626, 21864, 22378];
lyrics = [
	"I wrote this song two hours be+fore we met",
	"I di+dn't know your name",
	"or what you looked like yet"
]
lyric_page = 0;
lyric_word = 0;
note_num = 0;
show_debug_message(lyrics[0])
for (var i = 0; i < array_length(lyrics); i++) {
	lyrics[i] = split(lyrics[i], " ");
	for (var j = 0; j < array_length(lyrics[i]); j++) {
		lyrics[i][j] += " ";
	}
	for (var j = 0; j < array_length(lyrics[i]); j++) {
		var sep_words = split(lyrics[i][j], "+");
		if (array_length(sep_words) > 1) {
			lyrics[i][j] = sep_words[0];
			for (var n = 1; n < array_length(sep_words); n++) {
				array_insert(lyrics[i], j + n, sep_words[n]);
			}
		}
	}
}
show_debug_message(lyrics[0])



text_scale = 4;
start_time = current_time;
relative_start = 8000;
audio_play_sound(snd_mi_something_changed, 0, 0, 1, relative_start/1000);

judge_num = 0;

function judgement_rate(ranges, ratings, val) {
	for (var i = 0; i < array_length(ranges); i++) {
		if (abs(val) <= ranges[i]) {
			return ratings[i];
		}
	}
	return array_last(ratings);
	//example: judgement_rate([100, 200, 300], ["perfect", "good", "bad", "miss"], press_time - note_start)
}

function note_num2word_num(_note_num) {
	var num_add = 0;
	for (var i = 0; i < array_length(lyrics); i++) {
		if (_note_num - num_add <= array_length(lyrics[i])) {
			return _note_num - num_add;
		}
		num_add += array_length(lyrics[i]);
	}
}

function note_num_addup(_page) {
	var num_add = 0;
	for (var i = 0; i < _page; i++) {
		num_add += array_length(lyrics[i]);
	}
	return num_add;
}