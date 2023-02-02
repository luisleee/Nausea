function random_range_multi(sections) {
	randomize();
	var a = irandom_range(0, array_length(sections) - 1);
	return random_range(sections[a][0], sections[a][1]);
}
function irandom_range_multi(sections) {
	randomize();
	var a = irandom_range(0, array_length(sections) - 1);
	return irandom_range(sections[a][0], sections[a][1]);
}