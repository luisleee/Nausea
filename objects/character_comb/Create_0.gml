dis_w = display_get_gui_width();
dis_h = display_get_gui_height();
hover_num = undefined;
text_scale = 3;
time = 0;


optional_char = split("但,感,别,经,时,隔,江,犹,唱,后,庭,花",",");
correct_str = "隔江犹唱后庭花";
opt_char_pos = array_create(array_length(optional_char));
opt_char_info = array_create(array_length(optional_char));
opt_char_pos_num = irandom_assign(0, 19, array_length(optional_char));
opt_char_selected = array_create(array_length(optional_char), false);
answer_nums = array_create(string_length(correct_str), undefined);

for (var i = 0; i < array_length(optional_char); i ++) {
	randomize();

	for (var l = 0; l < 20; l++) {
		var xx = l % 5 + 5 * (l % 5 == 0);
		var yy = get_quotient(l, 5) + 1;
		poses[l] = [dis_w/6 * xx, dis_h/6 * (yy + (yy >= 3))];
	}
	
	opt_char_pos[i] = [poses[opt_char_pos_num[i]][0], poses[opt_char_pos_num[i]][1]];
	
	var range = random_range(10, 30);
	var spd = random_range(0.5, 0.8);
	var init_phase = random_range(1, 100);
	opt_char_info[i] = new FloatTextInfo(range, spd, init_phase);
}

function num2str (arr) {
	var str = "";
	for (var i = 0; i < array_length(arr); i++) {
		if (!is_undefined(answer_nums[i])) {
			str += optional_char[answer_nums[i]];
		}
	}
	return str;
}