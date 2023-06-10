time_bar = [18.5, 24];
 
var tag_optional = new ScheduleTag("opt", spr_schedule_tags_opt, "可选：可以选用此卡，也可以不选。", {});
var tag_must = new ScheduleTag("mst", spr_schedule_tags_mst, "必选：必须选用此卡。", {});
var tag_recycle = new ScheduleTag("rec", spr_schedule_tags_rec, "回收：此卡可重复使用。", {});


blocks = [
	new ScheduleBlock("0", 1, spr_schedule_card_test, [tag_optional,  tag_recycle,
		new ScheduleTag("tml", spr_schedule_tags_timelimit, "时限：不得将此卡安排在32时后。", {right_limit: 32})
	]),
	new ScheduleBlock("1", 0.75, spr_schedule_card_chinese, [tag_must,
		new ScheduleTag("tml", spr_schedule_tags_timelimit, "时限：不得将此卡安排在10时前。", {left_limit: 10})
	]),
	new ScheduleBlock("2", 0.75, spr_schedule_card_chinese, [tag_must]),
	new ScheduleBlock("3", 1, spr_schedule_card_test, [tag_optional,  
		new ScheduleTag("tml", spr_schedule_tags_timelimit, "时限：不得将此卡安排在22时后。", {right_limit: 22})
	]),

];

function block_contains_tag(_block, _tag) {
	for (var i = 0; i < array_length(_block.tags); i++) {
		if(_block.tags[i].name == _tag) {
			return true;
		}
	}
	return false;
}
function block_get_tag(_block, _tag) {
	for (var i = 0; i < array_length(_block.tags); i++) {
		if(_block.tags[i].name == _tag) {
			return _block.tags[i];
		}
	}
	return undefined;
}

function get_scheduled_time() {
	var t = time_bar[0];
	for (var i = 0; i < array_length(schedule); i ++) {
		t += schedule[i].duration;
	}
	return t;
}

function process2rot(process) {
	var out = process > 1;
	if (process > 1) {
		process = process - 1;
	}
	var rot_offset = out ? card_rot_max : card_rot_ori;
	var rot_delta = card_rot_max - card_rot_ori;
	
	var zoom_channel = animcurve_get_channel(ac_schedule_card, out);
	var rot = rot_offset + animcurve_channel_evaluate(zoom_channel, process) * rot_delta;

	return rot;
}

function rot2process(rot) {
	for (var i = 0; i <= 2; i += 0.05) {
		if (abs(process2rot(i) - rot) == 0) {
			return i;
		}	
	}
	return undefined;
}

optional_blocks = clone(blocks);

block_num = array_length(blocks);
block_selected = array_create(block_num, false);
block_scale = 2;
block_w = sprite_get_width(spr_schedule_card_test) *  block_scale;
block_h = sprite_get_height(spr_schedule_card_test) * block_scale;
block_sep = 20;
block_yoff = 100;

hovering_block = undefined;
previous_hovering_block = undefined;
hovering_bar = undefined;
previous_hovering_bar = undefined;
schedule = [];
schedule_num = [];
for (var i = 0; i < block_num; i ++) {
	block_now_num[i] = i;
}



card_scale = 8;
card_rot_max = 15;
card_rot_ori = -20;
card_rot = card_rot_ori;
card_apa = 0;
card_w = sprite_get_width(spr_schedule_card_test) * card_scale;
card_h = sprite_get_height(spr_schedule_card_test) * card_scale;
for (var i = 0; i < block_num; i ++){
	card_surf[i] = surface_create(card_w, card_h);
}

card_animation = [];

bar_gamma = 0;
bar_animation = [];

bar_show_left = time_bar[0];