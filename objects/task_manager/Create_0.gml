enum TASK_STATE {
	IN_PROGRESS,
	ACCOMPLISHED,
	FAILED,
}

display_states = ["进行中", "已结束", "已结束"];

tasks = [
	new Task("小鸟", "小鸟要起飞了……我想知道为什么。", TASK_STATE.IN_PROGRESS, 0),
	new Task("取蛋糕", "妈妈提醒我放学之后记得去蛋糕店取蛋糕。", TASK_STATE.IN_PROGRESS, 0),
	new Task("找硬币", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
	new Task("这是个名字很长的任务", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
	new Task("魑魅魍魉", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
	new Task("6", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
	new Task("7", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
	new Task("8", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0),
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
