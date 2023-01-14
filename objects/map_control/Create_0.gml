function MapInfo(_name, _spr, _signs, _trans_cells) constructor {
	name = _name;
	spr = _spr; 
	signs = _signs;
	trans_cells = _trans_cells;
}

function TransCell(_pos, _to_map, _to_pos) constructor {
	pos = _pos;
	to_map = _to_map;
	to_pos = _to_pos;
}

function get_map (_name) {
	for (var i = 0; i < array_length(map_infos); i++) {
		if (map_infos[i].name == _name) {
			return map_infos[i];
		}
	}
}

map_infos = [
	new MapInfo(
		"passage", 
		spr_map_passage, 
		"oooooooooooooooo\n" +
		"ooxxxxxoooxxxxxo\n" +
		"oooooooooooooooo\n" +
		"oooooooooooooooo\n",
		[
			new TransCell([0, 1],  "yellow_passage", [2, 3]),
			new TransCell([0, 2],  "yellow_passage", [2, 3]),
			new TransCell([2, 3],  "yellow_passage", [2, 3]),
			new TransCell([6, 3],  "yellow_passage", [2, 3]),
			new TransCell([10, 3], "yellow_passage", [2, 3]),
			new TransCell([14, 3], "yellow_passage", [2, 3])
		]
	),
	new MapInfo(
		"yellow_passage", 
		spr_map_yellow_passage, 
		"oooooooooooooooo\n" +
		"ooxxxxxoooxxxxxo\n" +
		"oooooooooooooooo\n" +
		"oooooooooooooooo\n",
		[
			new TransCell([0, 1],  "passage", [2, 3]),
			new TransCell([0, 2],  "passage", [2, 3]),
			new TransCell([2, 3],  "passage", [2, 3]),
			new TransCell([6, 3],  "passage", [2, 3]),
			new TransCell([10, 3], "passage", [2, 3]),
			new TransCell([14, 3], "passage", [2, 3])
		]
	),
]