var chain1_content = [{
	type: "dialog",
	speaker: "Me",
	content: "人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！"
},{
	type: "dialog",
	speaker: "Me",
	content: "妈的，忍不了，一拳把地球打爆！"
},{
	type: "dialog",
	speaker: "Me",
	content:"彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！"
},{
	type: "option",
	question: "彻底疯狂?",
	options: ["Yes", "No"]
}];


var br1_content = [{
	type: "dialog",
	speaker: "Me",
	content: "杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！"
}];

var br2_content = [{
	type: "dialog",
	speaker: "Me",
	content: "对对对"
}];

var chain_next_content = [{
	type: "dialog",
	speaker: "Me",
	content: "end!"
}]

var plots = [{
	name: "chain1"
	type: "chain",
	content: chain1_content,
	next: "branching"
},{
	type: "branching",
	next: ["br1", "br2"],
	pending: function() {
		return 0;	
	}
},{
	name: "br1"
	type: "chain",
	content: br1_content,
	next: "chain2"
},{
	name: "br2"
	type: "chain",
	content: br2_content,
	next: "chain2"
},{
	name: "chain2",
	type:"chain",
	content: chain_next_content,
	next: "chain2"
}]

current_position = plot[0];
index_in_chain = 0;

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
	var next_plot = pointer_null;
	if (current_position.type == "chain") {
		next_plot = current_position.next;
	}
	if (current_position.type == "branching") {
		next_plot = current_position.next[current_position.pending()];
	}
	if (next_plot != pointer_null) {
		current_position = next_plot;
		
	}
}