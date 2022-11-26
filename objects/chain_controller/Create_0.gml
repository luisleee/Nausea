/*current_index = 0;
dialog = [
	"人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！人活着哪有不疯的？硬撑罢了！妈的，忍不了，一拳把地球打爆！",
	"妈的，忍不了，一拳把地球打爆！妈的，忍不了，拳把地球打爆！",
	"好可怕杀杀杀杀杀杀上勾拳！下勾拳！左勾拳！右勾拳！扫堂腿！回旋踢！这是蜘蛛吃耳屎，这是龙卷风摧毁停车场！",
	"这是羚羊蹬，这是山羊跳！乌鸦坐飞机！老鼠走迷宫！大象踢腿！愤怒的章鱼！巨斧砍大树！彻底疯狂！彻底疯狂！",
	"彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！彻底疯狂！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！杀！",
	"。。。。。。吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼",
];*/

chain = [];
current_index = 0;

function is_fully_displayed() {
	return textbar.is_fully_displayed() && current_index >= array_length(chain) - 1;
}

function set_chain(_chain) {
	chain = _chain;
	current_index = 0;
	display_current();
}

function next() {
	if (!textbar.is_fully_displayed()) {
		textbar.display_to_end();
		return;
	}
	var current_item = chain[current_index];
	if (current_item.type == itemType.option) {
		option.hide();
	}
	
	current_index++;
	display_current();
}

function display_current() {
	var current_item = chain[current_index];
	if (current_item.type == itemType.dialog) {
		textbar.set_text(current_item.content);
	}
	if (current_item.type == itemType.option) {
		textbar.set_text(current_item.question);
		option.set_options(current_item.options);
		option.show();
	}
}
