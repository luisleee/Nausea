if (mind_flash_apa > 0) {
	mind_flash_apa -= 0.025;
}

if not answer_mode {
	if (apa > 0) {
		apa -= 0.05;
	}
}
if answer_mode {
	if (apa < 1) {
		apa += 0.05;
	}
}

var zoom_channel = animcurve_get_channel(ac_ms_sep, 0);
sep_w = animcurve_channel_evaluate(zoom_channel, apa) * 32;
sep_h = animcurve_channel_evaluate(zoom_channel, apa) * 32;
surface_width = max_number_w * (symbol_w + sep_w) - sep_w;
surface_height = 2.2 * (symbol_h + sep_h);


if not show_self {
	exit;
}

if (answer_mode) {
	//scroll
	var next_offset = undefined;
	if (mouse_in_surface()) {
		var mouse_dir = mouse_wheel_up() - mouse_wheel_down();
		next_offset = showcase_scroll_offset - mouse_dir * mouse_scroll_spd;
	}
	
	if (keyboard_check(vk_up) or keyboard_check(vk_down)) {
		var key_dir = keyboard_check(vk_up) - keyboard_check(vk_down);
		next_offset = showcase_scroll_offset - key_dir * keyboard_scroll_spd;
	}
	
	var offset_max_h = showcase_height - surface_height;
	var offset_min_h = -showcase_shadow_h;
	
	if (!is_undefined(next_offset)) {
		showcase_scroll_offset = next_offset;
		showcase_scroll_offset = min(offset_max_h, showcase_scroll_offset);
		showcase_scroll_offset = max(offset_min_h, showcase_scroll_offset);
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
	// todo: move into Answer#match
	// todo: beautify
	// determine if the answer is available
	judge_display = default_answer;
	for (var k = 0; k < array_length(answers); k++) {
		var now_answer = "";
		
		for (var i = 0; i < max_concept_num; i++) {
			if (placement[i] != undefined) {
				var add_desc = placement[i].symbol.marked_desc(placement[i].mark);
				now_answer += "、" + add_desc;
			}
		}
		var contains_all = true;
		for (var i = 0; i < array_length(answers[k].keywords); i++) {
			contains_all *= string_pos("、" + string(answers[k].keywords[i]), now_answer);
		}
		
		//get the number of used placements
		var used_placement_num = 0;
		var not_abused = true;
		for (var n = 0; n < max_concept_num; n++) {
			if (placement[n] != undefined) {
				used_placement_num++;
			}
		}
		if (used_placement_num != array_length(answers[k].keywords)) {
			not_abused = false;
		}
		//determining what will show as the final option
		if (contains_all and not_abused) {
			judge_display = answers[k].sentence;
		} 
	}
	
	// final judge
	if (keyboard_check_pressed(ord("D")) and not judge_rising) {
		judge_rising = true;
		textbar.set_text("");
		
	}
		
}

// todo: extract function
if (judge_rising) {
	if (judge_process < 1) {
		judge_process += 0.025;
		if (judge_process >= 1) { //once this rising reached its end
			judge_rising = false;
			judge_process = 0;
			textbar.set_text(judge_display);
			textbar.display_to_end();
			audio_play_sound(snd_sfx_ms_place, 0, 0);
			chain_player.unfreeze();
			exit_answer_mode();
			
			if (conclusion) {
				chain_player.set_mode(DISPLAY_MODES.DIALOG);
			} 
		}
	}
}

des_t ++;