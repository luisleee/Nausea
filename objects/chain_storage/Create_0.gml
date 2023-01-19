enum ITEM_TYPE {
	DIALOG,
	IMAGE,
	MUSIC,
	OPTION,
	TASK,
	MAP,
};

// todo: contructors...
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
	type: ITEM_TYPE.IMAGE,
	add: ["furnitures"],
	remove: []
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Zww",
	line:"谬矣！最近我在研究《易经》呢。来，我给你起一卦！",
	emotion: 0
}];

var chain2_items = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！",
	emotion: 0
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

var chain3_items = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
}];

var chain_map_items = [{
	type: ITEM_TYPE.MAP,
	map_name: "classroom_1",
	pos: [10, 1],
}];

var chain_keep_map_items = [{
	type: ITEM_TYPE.MAP,
	map_name: undefined,
}];

var event_paper_items = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "旁白酱的纸巾，上面有旁白酱的味道……嘿嘿",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "想，想拿一张",
	emotion: 1
},{
	type: ITEM_TYPE.OPTION,
	question: "啊啊啊啊拿一张？",
	name: "opt_tissue",
	options: ["Yes", "No"]
}];

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
	items: chain3_items,
	next: function() {
		return "map_classroom1";
	}
}, {
	name: "map_classroom1",
	items: chain_map_items,
	next: function() {
		return "chain1";
	}
}, {
	name: "keep_map",
	items: chain_keep_map_items,
	next: function() {
		return "chain1";
	}
}, {
	name: "paper",
	items: event_paper_items,
	next: function() {
		return "keep_map";
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
