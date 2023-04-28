if (!show_self) {
	exit;
}

// todo: use mouse to choose.
// (block next when clicking - need a change in chain_player
// (highlight the hovering opt
// (select the clicked one while clicking
// (keep independent from keyboard selection.

if (keyboard_check_pressed(vk_down)) {
	select_next();
	audio_play_sound(snd_sfx_switch_options, 0, 0);
}

if (keyboard_check_pressed(vk_up)) {
	select_previous();
	audio_play_sound(snd_sfx_switch_options, 0, 0);
}

