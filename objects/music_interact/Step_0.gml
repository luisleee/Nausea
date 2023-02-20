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


if (judge_num <= note_num) {
	if (keyboard_check_pressed(vk_space)) {
		var judge = judgement_rate(
			[500, 800, 1500],
			["Perfect", "Good", "Bad", "Miss"],
			(current_time - start_time) - (note_start[judge_num] - relative_start)
		);
		show_debug_message(judge)
		judge_num ++;
		
	}
	
	if ((current_time - start_time) - (note_start[judge_num] - relative_start) >= 2000) {
		judge_num ++;
	}
}