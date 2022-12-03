/// @desc Build a slice [_start, _end] from given array
/// @param {array} arr Array
/// @param {real} _start The starting index
/// @param {real} _end  The ending index
/// @returns {array} A slice of original array
function array_slice(arr, _start, _end) {
	var res = [];
	var len = array_length(arr);
	assert("Starting index within the bound", _start >= 0 and _start < len);
	for (var i = _start; i < min(_end + 1, len); i++) {
		array_push(res, arr[i]);
	}
	return res;
}