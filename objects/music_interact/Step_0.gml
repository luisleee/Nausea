if (current_time - start_time >= note_start[note_num] - relative_start) {
	if (lyric_word < array_length(lyrics[lyric_page])) {
		lyric_word ++;
	}
	else if (lyric_page < array_length(lyrics) - 1){
		lyric_word = 1;
		lyric_page ++;
	}
	if (note_num < array_length(note_start) - 1) {
		note_num ++;
	}
}



//Press Space Judgement
if (keyboard_check_pressed(vk_space)) {
	audio_play_sound(snd_snare, 0, 0);
	var closest = get_closest_note(judgement_area[2]);
	if (!is_undefined(closest)){//如果判定区域里有音符，则找到最近的一个进行判定
		var judge = judgement_rate(
			judgement_area,
			["Perfect", "Good", "Bad", "Miss"],
			(current_time - start_time) - (note_start[closest] - relative_start)
		);
		note_judgement[closest] = judge;
		show_debug_message(judge);
		for (var i = 0; i < closest; i++) {
			note_judgement[i] = is_undefined(note_judgement[i]) ? "Miss" : note_judgement[i];//被判定的音符，其前面的全部音符不得被判定
		}
	}
}

//离开判定区的音符若未判定则为miss
for (var i = 0; i < array_length(note_start); i++) {
	var this_distance = (current_time - start_time) - (note_start[i] - relative_start);
	if (this_distance >= judgement_area[2]) {
		if is_undefined(note_judgement[i]) {
			note_judgement[i] = "Miss";
		}
	}
}

/*
当按下空格：
1.如果有音符在判定区域里，对离判定线最近的音符进行判定
2.判定过的音符不能再次判定
3.被判定的音符，其之前的全部音符不能再次进行判定
*/