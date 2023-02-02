function float_info_initialize() {
	randomize();
	var r = random_range(4, 8);
	var s = random_range_multi([[-1, -0.5], [0.5, 1]]);
	s += (s == 0);
	var ip = random_range(0, 1);
	return new FloatTextInfo(r, s, ip);
}