function array_find_item(arr, item) {
	for (var i = 0; i < array_length(arr); i++) {
		if (arr[i] == item) {
			return i;	
		}
	}
	return undefined;
}