if (keyboard_check_pressed(vk_down)) {
	next();
	audio_play_sound(snd_sfx_switch_options,0,0);
}

if (keyboard_check_pressed(vk_up)) {
	previous();
	audio_play_sound(snd_sfx_switch_options,0,0);
}