/// @desc Clone an object
/// @param {any} src Object to clone
/// @returns {any} The cloned object
function clone(src) {
	if (typeof(src) == "struct") {
		var dest = {};
		var entries = variable_struct_get_names(src);
		for (var i = 0; i < array_length(entries); i++) {
			var key = entries[i];
			var val = variable_struct_get(src, key);
			variable_struct_set(dest, key, clone(val));
		}
		return dest;
	}
	if (typeof(src) == "array") {
		var dest = [];
		for (var i = 0; i < array_length(src); i++) {
			var val = src[i];
			array_push(dest, clone(val));
		}
		return dest;
	}
	return src;
}