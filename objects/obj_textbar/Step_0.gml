///typewriter effect
if(char_count < string_length(dialogue[dia_index])){
	char_count += char_spd;
	if(char_count%2 == 0)audio_play_sound(snd_sfx_text,0,0);
}
if(keyboard_check_pressed(vk_enter) or mouse_check_button_pressed(mb_left)){
	if(char_count >= string_length(dialogue[dia_index])){
		if(dia_index < array_length(dialogue) - 1){
			dia_index ++;
			char_count = 1;
		}
	}else {
		char_count = string_length(dialogue[dia_index]);
	}
}
