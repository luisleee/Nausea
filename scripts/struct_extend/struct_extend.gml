function struct_extend(obj1, obj2) {
	assert("obj1 is struct", typeof(obj1) == "struct");
	assert("obj2 is struct", typeof(obj2) == "struct");

	var keys = variable_struct_get_names(obj2);
	for (var i = 0; i < array_length(keys); i++) {
		var key = keys[i];
		if (!variable_struct_exists(obj1, key)){
			var val = variable_struct_get(obj2, key)
			variable_struct_set(obj1, key, val);
		}
	}
}