if (keyboard_check_pressed(vk_tab)) {
	show_self = !show_self;
}
if not show_self {
	if (apa > 0) {
		apa -= 0.05;
		var zoom_channel = animcurve_get_channel(ac_ms_sep, 0);
		sep_w = animcurve_channel_evaluate(zoom_channel, apa) * 32;
		sep_h = animcurve_channel_evaluate(zoom_channel, apa) * 32;
	}
}
if show_self {
	if (apa < 1) {
		apa += 0.05;
		var zoom_channel = animcurve_get_channel(ac_ms_sep, 0);
		sep_w = animcurve_channel_evaluate(zoom_channel, apa) * 32;
		sep_h = animcurve_channel_evaluate(zoom_channel, apa) * 32;
	}
}

//placement position change
if (keyboard_check_pressed(vk_right)) {
	placing_next();
	audio_play_sound(snd_sfx_ms_select, 0, 0);
}
if (keyboard_check_pressed(vk_left)) {
	placing_previous();
	audio_play_sound(snd_sfx_ms_select, 0, 0);
}

//delete this placement
if (keyboard_check_pressed(vk_backspace)) {
	if (placement[now_placing_num] != undefined) {
		placement[now_placing_num] = undefined;
		display_particle(c_white);
		audio_play_sound(snd_sfx_ms_remove, 0, 0);
	}
}
//determine if the answer is available
judge_display = default_answer;
for (var k = 0; k < array_length(answers); k ++) {
	var now_answer = "";
	for (var i = 0; i < max_concept_num; i ++) {
		if (placement[i] != undefined) {
			var add_desc = "";
			switch placement[i].mark {
				case "":
				add_desc = placement[i].desc;
				break;
				case "un":
				add_desc = placement[i].un_desc;
				break;
				case "re":
				add_desc = placement[i].re_desc;
				break;
				case "val":
				add_desc = placement[i].val_desc;
				break;
			}
			now_answer += "、" + add_desc;
		}
	}
	var is_contained = true;
	for (var i = 0; i < array_length(answers[k].concepts); i ++) {
		is_contained *= string_pos("、" + string(answers[k].concepts[i]), now_answer);
	}
	
	//get the number of used placements
	var used_placement_num = 0;
	var not_abused = true;
	for (var n = 0; n < max_concept_num; n ++) {
		if (placement[n] != undefined) {
			used_placement_num ++;
		}
	}
	if (used_placement_num != array_length(answers[k].concepts)) {
		not_abused = false;
	}
	//determining what will show as the final option
	if (is_contained and not_abused) {
			judge_display = answers[k].sentence;
	} 
}
