for (var track_num = 0; track_num < array_length(tracks); track_num++) {
	if (tracks[track_num].track_mode == RHYTHM_TRACK_MODES.NOTE) {
		var now_time = current_time - start_time;
		var note_time = tracks[track_num].notes[note_num[track_num]] - relative_start;
		
		if (now_time >= note_time) {
			if (note_num[track_num] < array_length(tracks[track_num].notes) - 1) {
				note_num[track_num] ++;
			}
		}
		
		
		
		//Press Space Judgement
		if (keyboard_check_pressed(tracks[track_num].key)) {
			audio_play_sound(tracks[track_num].timbre, 0, 0);
			var closest = get_closest_note(track_num, judgement_area[2]);
			if (!is_undefined(closest)){//如果判定区域里有音符，则找到最近的一个进行判定
				var judge = judgement_rate(
					judgement_area,
					["Perfect", "Good", "Bad", "Miss"],
					(now_time) - (tracks[track_num].notes[closest] - relative_start)
				);
				note_judgement[track_num][closest] = judge;
				show_debug_message(judge);
				for (var i = 0; i < closest; i++) {
					note_judgement[track_num][i] = is_undefined(note_judgement[track_num][i]) ? "Miss" : note_judgement[track_num][i];//被判定的音符，其前面的全部音符不得被判定
				}
			}
		}
		
		//离开判定区的音符若未判定则为miss
		for (var i = 0; i < array_length(tracks[track_num].notes); i++) {
			var this_distance = (now_time) - (tracks[track_num].notes[i] - relative_start);
			if (this_distance >= judgement_area[2]) {
				if is_undefined(note_judgement[track_num][i]) {
					note_judgement[track_num][i] = "Miss";
				}
			}
		}
	}
}
/*
当按下空格：
1.如果有音符在判定区域里，对离判定线最近的音符进行判定
2.判定过的音符不能再次判定
3.被判定的音符，其之前的全部音符不能再次进行判定
*/