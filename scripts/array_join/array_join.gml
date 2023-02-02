function array_join(arr, str) {
	var res = "";
	for (var i = 0; i < array_length(arr); i++) {
		res += string(arr[i]);
		if (i != array_length(arr) - 1) {
			res += str;	
		}
	}
	return res;
}