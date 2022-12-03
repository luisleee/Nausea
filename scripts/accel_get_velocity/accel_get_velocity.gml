/// @desc Get velocity from current position where the movement speeds up and then slows down.
/// @param {real} _acc acceleration
/// @param {real} _dx_percent the position (PERCENTAGE)
/// @param {real} _min_velocity the minimum speed
/// @returns {real} velocity (PERCENTAGE)
function accel_get_velocity(_acc, _dx_percent, _min_velocity) {
	var velocity = 0.01;
	if (_dx_percent <= 0.5) {
		velocity = sqrt(2 * _acc * _dx_percent);
	}
	if (_dx_percent > 0.5) {
		velocity = sqrt(2 * _acc * (1 - _dx_percent));
	}
	return velocity * (velocity >= _min_velocity) + _min_velocity * (velocity < _min_velocity);
}