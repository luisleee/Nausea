enum plotType {
	chain,
	branching,
};

enum itemType {
	dialog,
	image,
	music,
	option,
};

var chain1_content = [{
	type: itemType.dialog,
	speaker: "Zww",
	line: "昊晨小生，今儿又迟到了？",
	emotion: 0
},{
	type: itemType.dialog,
	speaker: "Me",
	line: "也就一分钟吧。",
	emotion: 0
},{
	type: itemType.dialog,
	speaker: "Zww",
	line: "一分钟？你知道一分钟内这世界上可以发生多少变化吗？",
	emotion: 0
},{
	type: itemType.dialog,
	speaker: "Me",
	line: "我不知道。也许足够你从佛教徒转变成基督教徒了。",
	emotion: 0
},{
	type: itemType.dialog,
	speaker: "Zww",
	line:"谬矣！最近我在研究《易经》呢。来，我给你起一卦！",
	emotion: 0
}];

var chain2_content = [{
	type: itemType.dialog,
	speaker: "Me",
	line: "人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！",
	emotion: 0
},{
	type: itemType.dialog,
	speaker: "Me",
	line: "妈的，忍不了，一拳把地球打爆！",
	emotion: 1
},{
	type: itemType.dialog,
	speaker: "Me",
	line:"彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！",
	emotion: 2
},{
	type: itemType.option,
	question: "彻底疯狂?",
	options: ["Yes", "No"]
}];


var br1_content = [{
	type: itemType.dialog,
	speaker: "Me",
	line: "对对对",
	emotion: 1
}];

var br2_content = [{
	type: itemType.dialog,
	speaker: "Me",
	line: "算了",
	emotion: 0
}];

var chain_next_content = [{
	type: itemType.dialog,
	speaker: "Me",
	line: "杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
}]

plots = [{
	name: "chain1",
	type: plotType.chain,
	content: chain1_content,
	next: "chain2"
},{
	name: "chain2",
	type: plotType.chain,
	content: chain2_content,
	next: "branching"
}, {
	name: "branching",
	type: plotType.branching,
	next: ["br1", "br2"],
	pending: function() {
		randomize();
		return irandom(1);	
	}
}, {
	name: "br1",
	type: plotType.chain,
	content: br1_content,
	next: "chain3"
}, {
	name: "br2",
	type: plotType.chain,
	content: br2_content,
	next: "chain3"
}, {
	name: "chain3",
	type:plotType.chain,
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
	return pointer_null;
}

function next() {
	if (!chain_controller.is_fully_displayed()) {
		chain_controller.next();
		return;
	}
	option.hide();
	var next_plot = get_plot(current_position.next);
	if (next_plot.type == plotType.branching) {
		next_plot = get_plot(next_plot.next[next_plot.pending()]);
	}
	
	if (next_plot != pointer_null) {
		current_position = next_plot;
		chain_controller.set_chain(current_position.content);
	}
}

chain_controller.set_chain(current_position.content);