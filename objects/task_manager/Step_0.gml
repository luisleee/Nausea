if(show_self){
	if(keyboard_check_pressed(vk_down)){
		if(selected < array_length(tasks) - 1){
			selected ++;
		} 
	}
	if(keyboard_check_pressed(vk_up)){
		if(selected > 0){
			selected --;
		}
	}
}

if(selected - start_number > task_show_max - 1){
	start_number ++;
}
if(selected < start_number){
	start_number = selected;
}
//cur_page = floor(selected / task_show_max);
subimg += 0.1;