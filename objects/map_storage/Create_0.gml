// todo: read from files (under ./maps/)

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
			new TransCell([2, 3],  "classroom_1", [10, 1]),
		],
		[]
	),
	new MapInfo(
		"exp_F1_physics", 
		spr_map_exp_F1_physics, 
		"xxxxxxxoooo\n" +
		"xxxxxoo#ooo\n" +
		"xxxoo#ooooo\n" +
		"xxooooooooo\n" +
		"xxxoooo#oxo\n" +
		"xxxoo#oooxo\n" +
		"xxxxoooooxo\n" +
		"xxxxxoo#ooo\n" +
		"xxxxoxooooo\n" +
		"xxxxxxxoooo\n" +
		"xxxxxxxxooo\n",
		[
			new TransCell([9, 10],  "exp_F1_central", [1, 0]),
		],
		[]
	),
	new MapInfo(
		"exp_F1_central", 
		spr_map_exp_F1_central, 
		"oooooo\n" +
		"oooooo\n" +
		"ooxxoo\n" +
		"ooxxoo\n" +
		"oooooo\n" +
		"oooooo\n",
		[
			new TransCell([1, 0],  "exp_F1_physics", [9, 10]),
		],
		[]
	),
	new MapInfo(
		"classroom_1", 
		spr_map_classroom, 
		"ooooooooooo\n" +
		"ooooxxxoooo\n" +
		"ooooooooooo\n" +
		"o#o#o#o#o#o\n" +
		"o#o#o#o#o#o\n" +
		"o#o#o#o#o#o\n" +
		"o#o#o#o#o#o\n" +
		"o#o#o#o#o#o\n" +
		"o#o#o#o#o#o\n" +
		"ooooooooooo\n" +
		"xoooooooooo\n",
		[
			new TransCell([10, 1],  "passage", [2, 3]),
		],
		[
			new EventCell(
				[3, 3],
				"paper"
			)
		]
	),
]