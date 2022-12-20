/// @desc Make division a = qb + r (q is integer && 0 <= r < b)
/// @param {real} a Dividend
/// @param {real} b Divisor
/// @returns {real} Remainder
function get_remainder(a, b) {
	var q = floor(a / b);
	return a - q * b;
}