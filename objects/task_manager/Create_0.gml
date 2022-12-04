function Task(_name, _description, _state, _process) constructor {
	name = _name;
	description = _description;
	state = _state;
	process = _process;
}

enum TASK_STATE {
	IN_PROGRESS,
	ACCOMPLISHED,
	FAILED,
}

tasks = [
	new Task("飞翔的小鸟", "小鸟要起飞了……我想知道为什么。", TASK_STATE.IN_PROGRESS, 0);
	new Task("取蛋糕", "妈妈提醒我放学之后记得去蛋糕店取蛋糕。", TASK_STATE.IN_PROGRESS, 0);
	new Task("帮张丕找硬币", "张丕说需要三个硬币才能起卦。", TASK_STATE.IN_PROGRESS, 0);
];

