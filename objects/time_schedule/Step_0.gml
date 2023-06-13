if (mouse_check_button_pressed(mb_left)) {
	if (!is_undefined(hovering_block)) {
		var this_block = optional_blocks[hovering_block];
		var card_available = true;
		var scheduled_time = get_scheduled_time();
		
		//Requirement: Animation Fully Displayed
		card_available *= card_apa == 1;
		//Requirement: Latest Time
		card_available *= (scheduled_time + this_block.duration <= time_bar[1]);
		//Tag: Time Limits
		if (block_contains_tag(this_block, "tml")) {
			var this_tag = block_get_tag(this_block, "tml");
			var lr = variable_struct_get_names(this_tag.details);

			if (array_contains(lr, "right_limit")) {
				var right_l = this_tag.details.right_limit;
				card_available *= (right_l >= scheduled_time + this_block.duration);
			}
			
			if (array_contains(lr, "left_limit")) {
				var left_l = this_tag.details.left_limit;
				card_available *= (left_l <= scheduled_time);
			}
			
		}
		if (card_available) { //Requirements of this card
			
			array_push(schedule, optional_blocks[hovering_block]);
			array_push(schedule_num, block_now_num[hovering_block]);
			
			
			
			if (not block_contains_tag(optional_blocks[hovering_block], "rec")) {
				//Card change animation
				array_push(card_animation, {num: block_now_num[previous_hovering_block], process: rot2process(card_rot)});
				card_rot = card_rot_ori;
				card_apa = 0;
				
				optional_blocks = array_remove(optional_blocks, hovering_block);
				block_now_num = array_remove(block_now_num, hovering_block);
				
				hovering_block = undefined;
				hovering_time = hover_detect_time;
			}
			//block_num = array_length(optional_blocks);
		}
	}
}

if(card_rot < card_rot_max) {
	var process = rot2process(card_rot);
	process += 0.05;
	card_rot = process2rot(process);
	card_apa = -abs(process - 1) + 1;;
}

if (bar_gamma < 1) {
	bar_gamma += 0.1;
}


if (bar_show_left < get_scheduled_time()) {
	bar_show_left += 0.1;
} else {
	if (bar_show_left != get_scheduled_time()) {
		bar_show_left = get_scheduled_time();
	}
}

if (keyboard_check_pressed(vk_backspace) and !frequency_limit) {
	frequency_limit = true;
	alarm[0] = cooldown_time;
	if (!is_undefined(hovering_block)) {
		array_push(card_animation, {num: block_now_num[previous_hovering_block], process: rot2process(card_rot)});
		card_rot = card_rot_ori;
		card_apa = 0;
	}
	if (!is_undefined(hovering_bar)) {
		array_push(card_animation, {num: schedule_num[hovering_bar], process: rot2process(card_rot)});		
	}
	optional_blocks = clone(blocks);
	schedule = [];
	schedule_num = [];
	bar_animation = [];
	for (var i = 0; i < block_num; i ++) {
		block_now_num[i] = i;
	}
	
}

hovering_time ++;