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