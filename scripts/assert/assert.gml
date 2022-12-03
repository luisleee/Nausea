/// @desc Make an assertion.
/// @param {string} description Describe the assertion
/// @param {any} expression Expression to test
function assert(description, expression) {
	if (!is_bool(expression)) {
		show_error("expression must be a boolean!", true);
	}
	if (!expression) {
		show_error("Assertion " + description +" Failed!", true);
	}
}