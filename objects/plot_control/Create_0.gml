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
	speaker: "Me",
	content: "人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！"
},{
	type: itemType.dialog,
	speaker: "Me",
	content: "妈的，忍不了，一拳把地球打爆！"
},{
	type: itemType.dialog,
	speaker: "Me",
	content:"彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！"
},{
	type: itemType.option,
	question: "彻底疯狂?",
	options: ["Yes", "No"]
}];


var br1_content = [{
	type: itemType.dialog,
	speaker: "Me",
	content: "对对对"
}];

var br2_content = [{
	type: itemType.dialog,
	speaker: "Me",
	content: "算了"
}];

var chain_next_content = [{
	type: itemType.dialog,
	speaker: "Me",
	content: "杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！"
}]

plots = [{
	name: "chain1",
	type: plotType.chain,
	content: chain1_content,
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
	next: "chain2"
}, {
	name: "br2",
	type: plotType.chain,
	content: br2_content,
	next: "chain2"
}, {
	name: "chain2",
	type:plotType.chain,
	content: chain_next_content,
	next: "chain2"
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