function MapInfo(_name, _spr, _signs, _trans_cells, _event_cells) constructor {
	name = _name;
	spr = _spr; 
	signs = _signs;
	trans_cells = _trans_cells;
	event_cells = _event_cells;
}

function TransCell(_pos, _to_map, _to_pos) constructor {
	pos = _pos;
	to_map = _to_map;
	to_pos = _to_pos;
}

function EventCell(_pos, _event_chain) constructor {
	pos = _pos;
	event_chain = _event_chain;
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
			new TransCell([2, 3],  "classroom_1", [10, 1]),
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
				[{
					type: ITEM_TYPE.DIALOG,
					speaker: "Me",
					line: "旁白酱的纸巾，上面有旁白酱的味道……嘿嘿",
					emotion: 0
				},{
					type: ITEM_TYPE.DIALOG,
					speaker: "Me",
					line: "想，想拿一张",
					emotion: 1
				},{
					type: ITEM_TYPE.OPTION,
					question: "啊啊啊啊拿一张？",
					name: "opt_tissue",
					options: ["Yes", "No"]
				}]
			)
		]
	),
]