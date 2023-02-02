enum ITEM_TYPE {
	DIALOG,
	IMAGE,
	MUSIC,
	OPTION,
	TASK,
	MAP,
	MIND,
};

// todo: contructors...
#region
var chain1_items = [{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "<color=red,shake=10>杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "冷静。我需要知道自己是个什么东西",
	emotion: 0,
	mode_switch: DISPLAY_MODES.MIND,
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "首先，很显然，\n我是个<color=red>东西。",
	emotion: 0,
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "东西，汉语词语，拼音是dōng xī，方位名。\n东方与西方，东边与西边，东部与西部等；\n从东到西；近旁，旁侧；四方；指七、八十岁；\n物产于四方，约言称之为东西；古代亦以指产业；\n泛指各种具体或抽象的人、事、物。",
	emotion: 0,
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "（还好把百度百科做成思想钢印烙进脑子里了嘻嘻）",
	emotion: 0,
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "那么现在我要回答这个<shake=2>终^^^极^^^<shake=0>哲学问题：",
	emotion: 0,
},{
	type: ITEM_TYPE.MIND,
	question: "我^^是^^什^^么^^东^^西^^？",
	answers: [
		new Answer(["我", "无穷"], "我牛逼"),
		new Answer(["我", "否定"], "我是傻逼"),
	],
	default_answer: "我不知道",
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
	line: "aaaa",
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
