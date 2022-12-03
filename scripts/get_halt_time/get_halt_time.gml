function get_halt_time(char) {
	var halt = 1;
	var halt_puncs = ["。", "，", "！", "？", "…", "—", "：", "；"];
	if (array_includes(halt_puncs, char)) {
		halt = 6;
	}
	return halt;
}
