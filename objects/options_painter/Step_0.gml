if (keyboard_check_pressed(vk_down) and visible) {
	select_next();
	audio_play_sound(snd_sfx_switch_options, 0, 0);
}

if (keyboard_check_pressed(vk_up) and visible) {
	select_previous();
	audio_play_sound(snd_sfx_switch_options, 0, 0);
}
debugger.show_var_value("selected", selected);
