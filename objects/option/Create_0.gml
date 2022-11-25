options = ["你是中国人吗？", "你爱中国吗？", "你愿意中国好吗？"];
selected = 0;
function next() {
	selected = (selected + 1) % array_length(options);
}

function previous() {
	var len = array_length(options);
	selected = (selected - 1 + len) % len;
}

function toggle() {
	visible = !visible;	
}

function hide() {
	visible = false;	
}

function show() {
	visible = true;
}