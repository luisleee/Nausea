if (!show_self) {
	exit;
}

if (keyboard_check_pressed(vk_down)) {
	select_next();
	audio_play_sound(snd_sfx_switch_options, 0, 0);
}

if (keyboard_check_pressed(vk_up)) {
	select_previous();
	audio_play_sound(snd_sfx_switch_options, 0, 0);
}

