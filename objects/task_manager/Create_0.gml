enum TASK_STATE {
	IN_PROGRESS,
	ACCOMPLISHED,
	FAILED,
}

display_states = ["进行中", "已结束", "已结束"];

tasks = [
	new Task("小鸟", "小鸟要起飞了……究竟是为什么……", TASK_STATE.IN_PROGRESS, 0),
	new Task("三枚硬币", "周文王说需要三枚硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
	new Task("凑数上台和上台凑数", "考试后会举行音乐会，得召集点人手准备个节目。", TASK_STATE.IN_PROGRESS, 0),
	new Task("这是个名字很长的任务", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
	new Task("在办公楼拉屎", "我不要！！！", TASK_STATE.IN_PROGRESS, 0),
	new Task("背古诗", "啊啊啊啊唉", TASK_STATE.IN_PROGRESS, 0),
	new Task("迈向星辰", "总有一天我要……爬过禁止通行的栏杆，看看天文台的风景。", TASK_STATE.IN_PROGRESS, 0),
	new Task("探索校史馆", "校史馆还隐藏着什么不为人知的秘密……", TASK_STATE.IN_PROGRESS, 0),
];

show_self = false;

function show(){
	show_self = true;
}
function hide(){
	show_self = false;
}

selected = 0;
task_show_max = 4;
start_number = 0;

pos_y = display_get_gui_height();

subimg = 0;

function create_new_task(_name, _description) {
	var new_task = new Task(_name, _description, TASK_STATE.IN_PROGRESS, 0);
	array_push(tasks, new_task);
}

function task_exists(_name) {
	for (var i = 0; i < array_length(tasks); i++) {
		if (_name == tasks[i].name) {
			return true;
		}
	}
	return false;
}

function task_update(_name, _desc) {
	for (var i = 0; i < array_length(tasks); i++) {
		if (_name == tasks[i].name) {
			tasks[i].desc = _desc;
			return;
		}
	}
}

function task_finish(_name, _state) {
	for (var i = 0; i < array_length(tasks); i++) {
		if (_name == tasks[i].name) {
			tasks[i].state = _state;
			tasks[i].process = 1;
			return;
		}
	}
}