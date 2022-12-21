function read_text_file(path) {
	var file = file_text_open_read(path);
	assert("File exists", file != -1);
	var s = "";
	while (!file_text_eof(file)) {
		s += file_text_readln(file);
	}
	file_text_close(file);
	return s;
}