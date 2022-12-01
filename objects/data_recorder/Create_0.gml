history = ds_map_create();

/**
 * Record history choice
 * @param {string} option_name The name of options
 * @param {real} option_selected Selected option (an integer)
 */
function select_option(option_name, option_selected) {
	history[? option_name] = option_selected;
}

/**
 * Read out recorded choice
 * @param {string} option_name The name of options
 */
function get_selection(option_name) {
	return ds_map_find_value(history, option_name);
}