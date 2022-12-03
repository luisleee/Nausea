enum PLOT_TYPE {
	CHAIN,
	BRANCHING,
};

enum ITEM_TYPE {
	DIALOG,
	IMAGE,
	MUSIC,
	OPTION,
};


var chain1_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "<color=red,shake=20>杀！杀！杀！杀！杀！杀！杀！杀！杀！^^^^^^杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（事物就是为了它的毁灭才生成的啊，熵增才是一切的命运））））））",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（话说熵是……）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（记得克劳修斯好像）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（啊Q/T对）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（不太直观）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（玻尔兹曼，更好是Boltzmann对对对对S=klnΩ）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（k就是Boltzmann常数嗯嗯Ω是可能的状态数）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（如果一堆围棋子一半是白的一半是黑的，和全是）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（黑的或白的，比起来哪个更，混乱？）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（应该一半一半的更，算起来：Sigma Pi ln Pi咦负数）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（那所有的所有都要变成铁了？稳定的元素，我明白）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（我说出宇宙的根本）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Zww",
	line: "昊晨小生，今儿又迟到了？",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "也就一分钟吧。",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Zww",
	line: "一分钟？你知道一分钟内这世界上可以发生多少变化吗？",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "我不知道。也许足够你从佛教徒转变成基督教徒了。",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Zww",
	line:"谬矣！最近我在研究《易经》呢。来，我给你起一卦！",
	emotion: 0
}];

var chain2_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "妈的，忍不了，一拳把地球打爆！",
	emotion: 1
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line:"彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！",
	emotion: 2
},{
	type: ITEM_TYPE.OPTION,
	question: "彻底疯狂?",
	name: "opt1",
	options: ["Yes", "No"]
}];


var br1_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "对对对",
	emotion: 1
}];

var br2_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "算了",
	emotion: 0
}];

var chain_next_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
}]

plots = [{
	name: "chain1",
	type: PLOT_TYPE.CHAIN,
	content: chain1_content,
	next: "chain2"
},{
	name: "chain2",
	type: PLOT_TYPE.CHAIN,
	content: chain2_content,
	next: "branching"
}, {
	name: "branching",
	type: PLOT_TYPE.BRANCHING,
	next: ["br1", "br2"],
	judge: function() {
		return data_recorder.get_selection("opt1");	
	}
}, {
	name: "br1",
	type: PLOT_TYPE.CHAIN,
	content: br1_content,
	next: "chain3"
}, {
	name: "br2",
	type: PLOT_TYPE.CHAIN,
	content: br2_content,
	next: "chain3"
}, {
	name: "chain3",
	type: PLOT_TYPE.CHAIN,
	content: chain_next_content,
	next: "chain3"
}];

current_position = plots[0];

function get_plot(name) {
	var len = array_length(plots);
	for (var i = 0; i < len; i++) {
		if (plots[i].name == name) {
			return plots[i];
		}
	}
	return undefined;
}

function next() {
	if (!chain_controller.is_fully_displayed()) {
		chain_controller.next();
		return;
	}
	options_painter.select();
	var next_plot = get_plot(current_position.next);
	if (next_plot.type == PLOT_TYPE.BRANCHING) {
		next_plot = get_plot(next_plot.next[next_plot.judge()]);
	}
	
	assert("next_plot is not undefined", !is_undefined(next_plot));
	current_position = next_plot;
	chain_controller.set_chain(current_position.content);
}

chain_controller.set_chain(current_position.content);