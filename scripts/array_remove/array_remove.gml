function array_remove(arr, k) {
	var res = [];
	var len = array_length(arr);
	for (var i = 0; i < len; i++) {
		if (i != k) {
			array_push(res, arr[i]);
		}
	}
	return res;
}