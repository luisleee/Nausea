chains = read_json_file(working_directory + "/chains.json").chains;

function get_chain(name) {
	var len = array_length(chains);
	for (var i = 0; i < len; i++) {
		if (chains[i].id == name) {
			return chains[i];
		}
	}
	return undefined;
}
