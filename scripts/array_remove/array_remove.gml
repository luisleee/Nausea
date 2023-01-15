/// @desc Remove the k-th element from the array
/// @param {array} arr The array
/// @param {real} k A number within bound
/// @returns {array<any*>} Array with k-th element deleted
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