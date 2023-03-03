enum ITEM_TYPE {
	DIALOG,
	IMAGE,
	MUSIC,
	OPTION,
	TASK,
	MAP,
	MIND,
	SYMBOL,
	TRANSITION,
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
	
	add: [{
		class: "bedroom",
		spr: spr_frame_shelf,
		comic: true,
		posx: 0,
		posy: 0,
		args: {
			scale_x: 8,
			scale_y: 8,
		},
		movements: [{
			type: "zoom",
			in: true,
		}, {
			type: "no",
		}, {
			type: "zoom",
			in: false,
		}],
	}, {
		class: "bedroom",
		spr: spr_frame_bed,
		comic: true,
		posx: 0,
		posy: 0,
		args: {
			scale_x: 8,
			scale_y: 8,
		},
		movements: [{
			type: "zoom",
			in: true,
		}, {
			type: "no",
		}, {
			type: "zoom",
			in: false,
		}],
	}],
	remove: []
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Brain",
	line: "（话说熵是……）",
	emotion: 0
},{
	type: ITEM_TYPE.IMAGE,
	add: [{
		class: "bus",
		spr: spr_frame_bus,
		comic: true,
		posx: 0,
		posy: 0,
		args: {
			scale_x: 4,
			scale_y: 4,
		},
		movements: [{
			type: "parallel",
			movements: [{
				type: "zoom",
				in: true,
			}, {
				type: "pingpong",
				horizontal: false,
				args: {
					amplitude: 50,
					period: 60/108,
					init_phase: get_remainder(audio_sound_get_track_position(music_player.cur_track), 60/108),
				},
			}],
		}, {
			type: "pingpong",
			horizontal: false,
			args: {
				amplitude: 50,
				period: 60/108,
				init_phase: get_remainder(audio_sound_get_track_position(music_player.cur_track), 60/108),
			},
		}, {
			type: "parallel",
			movements: [{
				type: "zoom",
				in: false,
			}, {
				type: "pingpong",
				horizontal: false,
				args: {
					amplitude: 50,
					period: 60/108,
					init_phase: get_remainder(audio_sound_get_track_position(music_player.cur_track), 60/108),
				},
			}],
		}],
	}],
	remove: ["bedroom"]
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
	question: "我该……怎么做？",
	answers: [
		new Answer(["我", "无穷"], "我牛逼"),
		new Answer(["我", "否定"], "我是傻逼"),
		new Answer(["我", "生命", "不可逆"], "我的人生不能重来"),
	],
	default_answer: "我不知道",
	conclusion: true,
}, {
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
	type: ITEM_TYPE.IMAGE,
	add: [{
		class: "bus",
		spr: spr_frame_bus,
		comic: true,
		posx: 0,
		posy: 0,
		args: {
			scale_x: 4,
			scale_y: 4,
		},
		movements: [{
			type: "parallel",
			movements: [{
				type: "zoom",
				in: true,
			}, {
				type: "pingpong",
				horizontal: false,
				args: {
					amplitude: 50,
					period: 60/108,
					init_phase: get_remainder(audio_sound_get_track_position(music_player.cur_track), 60/108),
				},
			}],
		}, {
			type: "pingpong",
			horizontal: false,
			args: {
				amplitude: 50,
				period: 60/108,
				init_phase: get_remainder(audio_sound_get_track_position(music_player.cur_track), 60/108),
			},
		}, {
			type: "parallel",
			movements: [{
				type: "zoom",
				in: false,
			}, {
				type: "pingpong",
				horizontal: false,
				args: {
					amplitude: 50,
					period: 60/108,
					init_phase: get_remainder(audio_sound_get_track_position(music_player.cur_track), 60/108),
				},
			}],
		}],
	}],
	remove: []
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "（又能做点啥，我）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "（呃不如闭眼睡会）",
	emotion: 0
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "（晃得我晕得慌）",
	emotion: 0
},{
	type: ITEM_TYPE.MIND,
	question: "这个游戏的核心内容是什么？",
	answers: [
		new Answer(["我"], "我们"),
		new Answer(["我", "生命"], "我们对自己的生活的"),
		new Answer(["我", "生命", "痕迹"], "我们对自己的生活的经历和感受和体验"),
		new Answer(["我", "生命", "痕迹", "思维"], "我们对自己的生活的经历和感受和体验和想法和思考和____"),
	],
	default_answer: "我不知道",
	conclusion: true,
},{
	type: ITEM_TYPE.TRANSITION,
	pattern: "color_fade",
	time: 60,
	infos: {
		color: c_black
	}
},{
	type: ITEM_TYPE.TASK,
	name: "暴打年级主任",
	desc: "我忍不了了哦哦哦哦哦"
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "任务更新：【<color=red,shake=5>暴打年级主任<color=black,shake=0>】",
	emotion: 1
},{
	type: ITEM_TYPE.TRANSITION,
	pattern: "color_fade",
	time: 100,
	infos: {
		color: c_white
	}
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "怎——么——劝——都——不——听——哟——<shake=5>咳咳咳",
	emotion: 2
},{
	type: ITEM_TYPE.SYMBOL,
	symbol: spr_ms_dot,
	desc: "「我睁开双眼，注视这个世界。」"
},{
	type: ITEM_TYPE.SYMBOL,
	symbol: spr_ms_sprout,
	desc: "「今天是我的生日……」"
},{
	type: ITEM_TYPE.MUSIC,
	piece: "gg"
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "特——有——活——力——还——特——聪——明——<shake=5>咳",
	emotion: 2
},{
	type: ITEM_TYPE.SYMBOL,
	symbol: spr_ms_cube,
	desc: "「物质、存在与精神、思维的对立构成了哲学的基本问题。」"
},{
	type: ITEM_TYPE.SYMBOL,
	symbol: spr_ms_spirit,
	desc: "「物质、存在与精神、思维的对立构成了哲学的基本问题。」"
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "只不过是小聪明",
	emotion: 2
},{
	type: ITEM_TYPE.TASK,
	name: "暴打年级主任",
	desc: "忍不了，一拳打爆！！"
},{
	type: ITEM_TYPE.SYMBOL,
	symbol: spr_ms_footprint,
	desc: "「一串串足印连起来，就是我们的历史。」"
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "获得任务：【<color=red,shake=5>暴打年级主任<color=black,shake=0>】",
	emotion: 1
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
	type: ITEM_TYPE.TASK,
	name: "暴打年级主任",
	state: TASK_STATE.ACCOMPLISHED,
	desc: "爽拉"
},{
	type: ITEM_TYPE.DIALOG,
	speaker: "Me",
	line: "完成任务：【<color=red,shake=5>暴打年级主任<color=black,shake=0>】",
	emotion: 1
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
#endregion

chains = [{
	name: "chain1",
	items: chain1_items,
	next: {
		"chain2" : {},
	}
}, {
	name: "chain2",
	items: chain2_items,
	next: {
		br1: {options: {opt1: 0}},
		br2: {options: {opt1: 1}},
	}
}, {
	name: "br1",
	items: br1_items,
	next: {
		"chain3" : {},
	}
}, {
	name: "br2",
	items: br2_items,
	next: {
		"chain3" : {},
	}
}, {
	name: "chain3",
	items: chain3_items,
	next: {
		"map_classroom1" : {},
	}
}, {
	name: "map_classroom1",
	items: chain_map_items,
	next: {
		"chain1" : {},
	}
}, {
	name: "keep_map",
	items: chain_keep_map_items,
	next: {
		"chain1" : {},
	}
}, {
	name: "paper",
	items: event_paper_items,
	next: {
		"keep_map" : {},
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
