symbol_w = 128;
symbol_h = 128;
sep_w = 32;
sep_h = 32;
answer_sep_w = 64;

answer_place_y = 700;
judge_display_y = 1000;
judge_process = 0;
judge_rising = false;

answer_mode = false;
conclusion = false;
symbol_number = array_length(global.mind_symbols);

max_number_w = 6;
max_number_h = ceil(symbol_number/max_number_w);


//surface
showcase_shadow_h = 80;
surface_width = max_number_w * (symbol_w + sep_w) - sep_w;
surface_height = 2.2 * (symbol_h + sep_h) + showcase_shadow_h;
showcase_surface = surface_create(surface_width, surface_height);
showcase_scroll_offset = -showcase_shadow_h;
showcase_height = max_number_h * (symbol_h + sep_h) - sep_h;
x = (room_width - max_number_w * (symbol_w + sep_w) + sep_w)/2;
y = 150 - showcase_shadow_h;

mouse_scroll_spd = 40;
keyboard_scroll_spd = 20;

function mouse_in_surface() {
	return point_in_rectangle(
		mouse_x,
		mouse_y,
		x,
		y,
		x + max_number_w * (symbol_w + sep_w),
		y + 2.2 * (symbol_h + sep_h)
	);
}

now_hover_num = undefined;

show_self = false;
apa = 0;

question = "啊啊啊啊随便说点什么？";

default_answer = "我不知道";
answers = [];
function placement_initialize() {
	max_concept_num = 0;
	for (var i = 0; i < array_length(answers); i++) {
		show_debug_message(answers);
		max_concept_num = max(max_concept_num, array_length(string_split(answers[i].keywords, "/")));
	}
	placement = array_create(max_concept_num, undefined);
	now_placing_num = 0;
}

placement_initialize();

judge_display = "";



function placing_next() {
	now_placing_num = (now_placing_num + 1) % max_concept_num;
}
function placing_previous() {
	now_placing_num = (now_placing_num - 1 + max_concept_num) % max_concept_num;
}


//particles
ms_part_system = part_system_create();
part_system_depth(ms_part_system, depth - 20);
ms_particle = part_type_create();
ms_part_emitter = part_emitter_create(ms_part_system);
part_type_shape(ms_particle, pt_shape_pixel);
part_type_life(ms_particle, 20, 40);
part_type_size(ms_particle, 4, 8, 0.1, 0);
part_type_color1(ms_particle, c_white);
part_type_blend(ms_particle, true);
part_type_speed(ms_particle, 2, 5, 0.1, 0);
part_type_alpha3(ms_particle, 1, 1, 0);
part_system_depth(ms_part_system, -999);

function particle_on_direction(_x, _y, _direction) {
	// _direction = "left" | "right" | "up" | "down"
	var angles = {
		right: 0,
		up: 90,
		left: 180,
		down: 270,
	};
	var angle = variable_struct_get(angles, _direction);
	var coefs = {
		right: [1, 1, 0, 1],
		up: [0, 1, 0, 0],
		left: [0, 0, 0, 1],
		down: [0, 1, 1, 1],
	};
	var c = variable_struct_get(coefs, _direction);
	
	part_type_direction(ms_particle, angle, angle, 0, 0);
	part_emitter_region(
		ms_part_system,
		ms_part_emitter,
		_x + now_placing_num * (symbol_w + answer_sep_w) + symbol_w * c[0],
		_x + now_placing_num * (symbol_w + answer_sep_w) + symbol_w * c[1],
		_y + symbol_h * c[2],
		_y + symbol_h * c[3],
		ps_shape_rectangle,
		ps_distr_linear
	);
	part_emitter_burst(ms_part_system, ms_part_emitter, ms_particle, 10);
}

function display_particle(col) {
	part_type_color1(ms_particle, col);
	var xori = (room_width - max_concept_num * (symbol_w + answer_sep_w) + answer_sep_w)/2;
	var yori = answer_place_y;
	
	particle_on_direction(xori, yori, "right");
	particle_on_direction(xori, yori, "up");
	particle_on_direction(xori, yori, "left");
	particle_on_direction(xori, yori, "down");

}

function get_ms_color(spr, index) {
	for (var xx = 1; xx < sprite_width; xx ++) {
		for (var yy = 1; yy < sprite_width; yy ++) {
			index = is_undefined(index) ? 0 : index;
			var rgb = sprite_get_pixel(spr, index, xx, yy);
			if (rgb[3] != 0) {
				return make_color_rgb(rgb[0], rgb[1], rgb[2]);
			}
		}
	}
}

function draw_symbol(spr, idx, xoffset, yoffset) {
	draw_sprite_stretched(
		spr,
		idx,
		xoffset,
		yoffset,
		symbol_w,
		symbol_h
	);
}

function draw_answer_symbol(spr, index, n) {
	var xori = (room_width - max_concept_num * (symbol_w + answer_sep_w) + answer_sep_w) / 2;
	var yori = answer_place_y;
	draw_sprite_stretched(
		spr,
		index,
		xori + n * (symbol_w + answer_sep_w),
		yori,
		symbol_w,
		symbol_h
	);
}

function show() {
	show_self = true;
}
function hide() {
	show_self = false;
	exit_answer_mode();
}

function flash() {
	mind_flash_apa = 1;
}

function set_answers(_default, _answers) {
	default_answer = _default;
	answers = _answers;
	judge_process = 0;
	placement_initialize();
}

function exit_answer_mode() {
	answer_mode = false;
	placement_initialize();
}

mind_flash_apa = 0;

function is_hovering_on() {
	return now_hover_num != undefined and apa == 1 and data_recorder.symbol_unlocked(now_hover_num);
}

function play_sound_of_mark(mark) {
	var sounds = {
		no: snd_sfx_ms_remove,
		un: snd_sfx_ms_un,
		re: snd_sfx_ms_re,
		val: snd_sfx_ms_val,
	}
	var snd = variable_struct_get(sounds, mark);
	audio_play_sound(snd, 0, 0);
}

function draw_ith_mask(i) {
	var mark2index = {
		no: 0,
		un: 1,
		re: 2,
		val: 3,
	}
	var ms_mask_index = variable_struct_get(mark2index, placement[i].mark);
			
	draw_answer_symbol(spr_ms_masks, ms_mask_index, i);
}