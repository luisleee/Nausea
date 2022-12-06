if(keyboard_check_pressed(vk_down)){
	if(selected < array_length(tasks) - 1){
		selected ++;
	} else {
		selected = 0;
	}
}
if(keyboard_check_pressed(vk_up)){
	if(selected > 0){
		selected --;
	} else {
		selected = array_length(tasks) - 1;
	}
}