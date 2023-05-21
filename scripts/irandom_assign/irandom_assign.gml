function irandom_assign(_min, _max, _l) {
	var arr = array_create(_l);
	for (var i = 0; i < _l; i ++) {
		var a = irandom_range(_min, _max);
		for (var j = 0; j < i; j ++) {
			if (a == arr[j]) {
				a = irandom_range(_min, _max);
				j = -1;
			}
		}
		arr[i] = a;
	}
	return arr;
}