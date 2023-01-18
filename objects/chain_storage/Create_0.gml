enum ITEM_TYPE {
	DIALOG,
	IMAGE,
	MUSIC,
	OPTION,
	TASK,
	MAP,
};

#region
var chain1_items = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "<color=red,shake=10>杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
},{
	type: ITEM_TYPE.MUSIC,
	piece: "road",
},{
	type: ITEM_TYPE.IMAGE,
	add: ["bus"],
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
	add: [],
	remove: ["bus"]
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（记得克劳修斯好像）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（我说出宇宙的根本）",
	emotion: 0
},{
	type: ITEM_TYPE.IMAGE,
	add: ["furnitures"],
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

var chain2_items = [{
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

var br1_items = [{
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

var br2_items = [{
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

var chain_next_items = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
}]

chains = [{
	name: "chain1",
	items: chain1_items,
	next: function() {
		return "chain2"
	}
}, {
	name: "chain2",
	items: chain2_items,
	next: function() {
		var nexts = ["br1", "br2"];
		var c = data_recorder.get_selection("opt1");
		return nexts[c];
	}
}, {
	name: "br1",
	items: br1_items,
	next: function() {
		return "chain3";
	}
}, {
	name: "br2",
	items: br2_items,
	next: function() {
		return "chain3";
	}
}, {
	name: "chain3",
	items: chain_next_items,
	next: function() {
		return "chain3";
	}
}];

function get_chain(name) {
	var len = array_length(chains);
	for (var i = 0; i < len; i++) {
		if (chains[i].name == name) {
			return chains[i];
		}
	}
	return undefined;
}
