//todo: put all of this object in to options? maybe no need now
depth = textbar.depth - 1;;

symbol_w = 128;
symbol_h = 128;
sep_w = 32;
sep_h = 32;
answer_sep_w = 64;
max_number_w = 8;
answer_place_y = 700;

answer_mode = false;

symbol_number = array_length(global.mind_symbols);

x = (room_width - max_number_w * (symbol_w + sep_w) + sep_w)/2;
y = 200;

now_hover_num = undefined;

show_showcase = false;
show_self = false;
apa = 0;

question = "啊啊啊啊随便说点什么？";

default_answer = "我不知道";
answers = [
	new Answer(["思维", "存在"], "思维与存在的关系问题"),
	new Answer(["我", "存在", "生命"], "我以生命的形式存在"),
	new Answer(["我", "观测", "物质"], "我观测世间存在的一切"),
	new Answer(["思维", "存在", "辩证"], "唯物与唯心的辩证统一！"),
	new Answer(["思维", "存在", "我"], "我思故我在"),
	new Answer(["历史", "成长", "观测"], "以古鉴今"),
	new Answer(["简单", "推理", "无穷"], "见微知著地了解世界运行的规律"),
	new Answer(["有穷", "生命", "无穷"], "在有限的生命里创造无限的价值！"),
	new Answer(["我", "推理", "无穷"], "我无所不知"),
	new Answer(["", "", "", "", "", "", ""], "你是不是闲啊"),
];
function placement_initialize() {
	max_concept_num = 0;
	for (var i = 0; i < array_length(answers); i ++) {
		if (array_length(answers[i].concepts) > max_concept_num) {
			max_concept_num = array_length(answers[i].concepts);
		}
	}
}

placement_initialize();

judge_display = "";

now_placing_num = 0;
placement = array_create(max_concept_num, undefined);

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

function display_particle(col) {
	part_type_color1(ms_particle, col);
	var xori = (room_width - max_concept_num * (symbol_w + answer_sep_w) + answer_sep_w)/2;
	var yori = answer_place_y;
	
	// todo: extract function
	//up
	part_type_direction(ms_particle, 90, 90, 0, 0);
	part_emitter_region(
		ms_part_system,
		ms_part_emitter,
		xori + now_placing_num * (symbol_w + answer_sep_w),
		xori + now_placing_num * (symbol_w + answer_sep_w) + symbol_w,
		yori,
		yori,
		ps_shape_rectangle,
		ps_distr_linear
	);
	part_emitter_burst(ms_part_system, ms_part_emitter, ms_particle, 10);
	
	//down
	part_type_direction(ms_particle, 270, 270, 0, 0);
	part_emitter_region(
		ms_part_system,
		ms_part_emitter,
		xori + now_placing_num * (symbol_w + answer_sep_w),
		xori + now_placing_num * (symbol_w + answer_sep_w) + symbol_w,
		yori + symbol_h,
		yori + symbol_h,
		ps_shape_rectangle,
		ps_distr_linear
	);
	part_emitter_burst(ms_part_system, ms_part_emitter, ms_particle, 10);
	
	//left
	part_type_direction(ms_particle, 180, 180, 0, 0);
	part_emitter_region(
		ms_part_system,
		ms_part_emitter,
		xori + now_placing_num * (symbol_w + answer_sep_w),
		xori + now_placing_num * (symbol_w + answer_sep_w),
		yori,
		yori + symbol_h,
		ps_shape_rectangle,
		ps_distr_linear
	);
	part_emitter_burst(ms_part_system, ms_part_emitter, ms_particle, 10);
	
	//right
	part_type_direction(ms_particle, 0, 0, 0, 0);
	part_emitter_region(
		ms_part_system,
		ms_part_emitter,
		xori + now_placing_num * (symbol_w + answer_sep_w) + symbol_w,
		xori + now_placing_num * (symbol_w + answer_sep_w) + symbol_w,
		yori,
		yori + symbol_h,
		ps_shape_rectangle,
		ps_distr_linear
	);
	part_emitter_burst(ms_part_system, ms_part_emitter, ms_particle, 10);
}

function get_ms_color(spr) {
	for (var xx = 1; xx < sprite_width; xx ++) {
		for (var yy = 1; yy < sprite_width; yy ++) {
			var rgb = sprite_get_pixel(spr, 0, xx, yy);
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
		x + xoffset,
		y + yoffset,
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
	mind_flash_apa = 1;
	show_self = true;
}

function set_answers(_default, _answers) {
	default_answer = _default;
	answers = _answers;
	placement_initialize();
}

mind_flash_apa = 0;