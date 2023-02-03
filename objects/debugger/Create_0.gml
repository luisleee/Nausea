global.DEBUG = true;
depth = -99999;
vars = [];
function show_var_value(name, val) {
	var len = array_length(vars);
	for (var i = 0; i < len; i++) {
		if (vars[i].name == name) {
			vars[i].val = val;
			return;
		}
	}
	array_push(vars, {
		name: name,
		val: val
	});
}

//map.hide();