function are_equal(arg1, arg2){
	var a1 = is_array(arg1);
	var a2 = is_array(arg2);
	var s1 = is_struct(arg1);
	var s2 = is_struct(arg2);
	if (a1 and a2){
		if (array_length(arg1) != array_length(arg2)) {
			return false;
		}
		for(var i = 0; i < array_length(arg1); i ++){
			if(arg1[i] != arg2[i]){
				return false;
			}
		}
		return true;
		
	}
	else if (s1 and s2) {
		var entries1 = variable_struct_get_names(arg1);
		var entries2 = variable_struct_get_names(arg2);
		if not are_equal(entries1, entries2){
			return false;
		}
		for (var i = 0; i < array_length(entries1); i++) {
			var key = entries1[i];
			var val1 = variable_struct_get(arg1, key);
			var val2 = variable_struct_get(arg2, key);
			if not are_equal(val1, val2){
				return false;
			}
		}
		return true;
	}
	else if not (a1 or a2 or s1 or s2){
		return (arg1 == arg2);
	}
	else return false;
}