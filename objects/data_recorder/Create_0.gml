history_choices = {};

/**
 * Record history_choices choice
 * @param {string} option_name The name of options
 * @param {real} option_selected Selected option (an integer)
 */
function select_option(option_name, option_selected) {
	variable_struct_set(history_choices, option_name, option_selected);
}

/**
 * Read out recorded choice
 * @param {string} option_name The name of options
 */
function get_selection(option_name) {
	return variable_struct_get(history_choices, option_name);
}