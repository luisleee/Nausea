
enum ITEM_TYPE {
	DIALOG,
	IMAGE,
	MUSIC,
	OPTION,
	TASK,
};

#region
var chain1_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "<color=red,shake=10>杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
},{
	type: ITEM_TYPE.MUSIC,
	piece: "road",
},{
	type: ITEM_TYPE.IMAGE,
	add: ["g2"],
	remove: []
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "来点音乐",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（事物就是为了它的毁灭才\n生成的啊，<color=red>熵^^增^^<color=black>才是一切的命运）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（话说熵是……）",
	emotion: 0
},{
	type: ITEM_TYPE.IMAGE,
	add: ["g4"],
	remove: ["g2"]
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
	type: ITEM_TYPE.IMAGE,
	add: ["g3"],
	remove: []
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Zww",
	line: "昊晨小生，今儿又^^^迟到了？",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "也就一分钟吧。",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Zww",
	line: "一分钟？你知道一分钟内这世界上可以发生多少<shake=3>变化<shake=0>吗？",
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
#endregion

var br1_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "对对对",
	emotion: 1
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "完成任务：【<color=red,shake=5>杀杀杀<color=black,shake=0>】",
	emotion: 1
}];

var br2_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "算了",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "任务失败：【<color=red,shake=5>杀杀杀<color=black,shake=0>】",
	emotion: 1
}];

var chain_next_content = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
}]

plots = [{
	name: "chain1",
	content: chain1_content,
	next: function() {
		return "chain2"
	}
}, {
	name: "chain2",
	content: chain2_content,
	next: function() {
		var nexts = ["br1", "br2"];
		var c = data_recorder.get_selection("opt1");
		return nexts[c];
	}
}, {
	name: "br1",
	content: br1_content,
	next: function() {
		return "chain3";
	}
}, {
	name: "br2",
	content: br2_content,
	next: function() {
		return "chain3";
	}
}, {
	name: "chain3",
	content: chain_next_content,
	next: function() {
		return "chain3";
	}
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
	var next_plot = get_plot(current_position.next());
	
	assert("next_plot is not undefined", !is_undefined(next_plot));
	current_position = next_plot;
	chain_controller.set_chain(current_position.content);
}

chain_controller.set_chain(current_position.content);