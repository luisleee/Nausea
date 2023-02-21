now_song = "something changed";
note_start = [0, 414, 828, 1241, 1655, 2069, 2483, 2897, 3310, 3724, 4138, 4552, 4966, 5379, 5793, 6207, 6621, 7034, 7448, 7862, 8276, 8690, 9103, 9517, 9931, 10345, 10759, 11172, 11586, 12000, 12414, 12828, 13241, 13655, 14069, 14483, 14897, 15310, 15724, 16138, 16552, 16966, 17379, 17793, 18207, 18621, 19034, 19448, 19862, 20276, 20690, 21103, 21517, 21931, 22345, 22759, 23172, 23586, 24000, 24414, 24828, 25241, 25655, 26069, 26483, 26897, 27310, 27724, 28138, 28552, 28966, 29379, 29793, 30207, 30621, 31034, 31448, 31862, 32276, 32690, 33103, 33517, 33931, 34345, 34759, 35172, 35586, 36000, 36414, 36828, 37241, 37655, 38069, 38483, 38897, 39310, 39724, 40138, 40552, 40966];
//[9126, 9285, 9661, 10170, 11907, 12447, 13210, 13438, 13708, 14195, 17262, 17511, 17797, 18305, 18829, 19338, 20339, 20604, 21351, 21626, 21864, 22378];
note_judgement = array_create(array_length(note_start), undefined);
judgement_area = [50, 100, 300];

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
relative_start = 0;
audio_play_sound(snd_ost_birthday, 0, 0, 1, relative_start/1000);



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

function get_closest_note(_max_distance) {
	var closest_num = undefined;
	var closest_distance = _max_distance;
	for (var i = 0; i < array_length(note_start); i++) {
		var this_distance = abs((current_time - start_time) - (note_start[i] - relative_start));
		if(this_distance < closest_distance and is_undefined(note_judgement[i])) {
			closest_distance = this_distance;
			closest_num = i;
		}
	}
	return closest_num;
}