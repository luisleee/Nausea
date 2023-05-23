time_bar = [18.5, 24];
optional_blocks = [
	new ScheduleBlock("练吉他", 1, {right_limit:22}),
	new ScheduleBlock("写语文作业", 0.75, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
	new ScheduleBlock("写数学作业", 0.5, {}),
];

block_num = array_length(optional_blocks);
block_selected = array_create(block_num, false);

hovering_block = undefined;
hovering_bar = undefined;
schedule = [];