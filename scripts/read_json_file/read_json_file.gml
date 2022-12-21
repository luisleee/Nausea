function read_json_file(path) {
	var s = read_text_file(path);
	return json_parse(s);
}