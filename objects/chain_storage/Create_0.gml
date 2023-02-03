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
	speaker: "Brain",
	line: "（话说熵是……）",
	emotion: 0
},{
	type: ITEM_TYPE.IMAGE,
	add: ["g4"],
	remove: []
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（话说熵是……）",
	emotion: 0
},{
	type: ITEM_TYPE.MIND,
	question: "我^^是^^什^^么^^东^^西^^？",
	answers: [
		new Answer(["我", "无穷"], "我牛逼"),
		new Answer(["我", "否定"], "我是傻逼"),
	],
	default_answer: "我不知道",
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "你再想想",
	emotion: 0,
},{
	type: ITEM_TYPE.MIND,
	question: "我^^是^^什^^么^^东^^西^^？",
	answers: [
		new Answer(["我", "无穷"], "我牛逼"),
		new Answer(["我", "否定"], "我是傻逼"),
	],
	default_answer: "我不知道",
	conclusion: true,
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
	line: "我——以——前——呀——带——过——<shake=5>咳咳<shake=0>一——个——学——生——",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "特——有——活——力——还——特——聪——明——<shake=5>咳",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "只不过是小聪明",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "<shake=5>咳咳咳<shake=0>也——从——来——不——看——重——<shake=5>咳咳<shake=0>各——种——各——样——的——考——试——",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "总——是——想——着——以——后——再——复——习——就——好——了——",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "怎——么——劝——都——不——听——哟——<shake=5>咳咳咳",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "然——后——你——们——猜——怎——么——着——",
	emotion: 2
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "<color=red>去学校对面的厂子里上班了。",
	emotion: 2
},];

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
