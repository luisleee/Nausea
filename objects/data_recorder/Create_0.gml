history_choices = {};

/**
 * Record history_choices choice
 * @param {string} option_name The name of options
 * @param {real} option_selected Selected option (an integer)
 */
function select_option(option_name, option_selected) {
	variable_struct_set(history_choices, option_name, option_selected);
}

/**
 * Read out recorded choice
 * @param {string} option_name The name of options
 */
function get_selection(option_name) {
	return variable_struct_get(history_choices, option_name);
}

global.mind_symbols = [
	new MindSymbol(spr_ms_dot, "我", {}),
	new MindSymbol(spr_ms_fork, "否定、空无", {un: "辩证"}),
	new MindSymbol(spr_ms_ruler, "度量、量化", {}),
	new MindSymbol(spr_ms_return, "逆转、回返", {un: "不可逆"}),
	new MindSymbol(spr_ms_cube, "物质、实在、存在", {val: "质量、体积、密度"}),
	new MindSymbol(spr_ms_spirit, "精神、思维、不定", {val: "概率"}),
	new MindSymbol(spr_ms_sprout, "生命、自然、纯洁、有机", {val: "寿命"}),
	new MindSymbol(spr_ms_infinity, "无穷、无界", {un: "有穷"}),
	new MindSymbol(spr_ms_circle, "整全、封闭、有界、无瑕", {un: "残缺、开放、破损"}),
	new MindSymbol(spr_ms_sand, "积累、成长、量变", {val: "积分"}),
	new MindSymbol(spr_ms_footprint, "痕迹、历史、过去、记忆", {val: "观测"}),
	new MindSymbol(spr_ms_line, "简单、起始、一", {}),
	new MindSymbol(spr_ms_arrow, "进行、推理", {re: "倒退"}),
	new MindSymbol(spr_ms_hexagram, "神秘、宗教、魔法", {}),
]

ms_marks = ["no", "un", "re", "val"];
mind_symbols_unlocked = array_create(array_length(global.mind_symbols), true);

for (var i = 0; i < array_length(global.mind_symbols); i ++) {
	mind_symbols_unlocked[i] = true;
}
