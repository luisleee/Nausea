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

function EventCell(_pos, _chain) constructor {
	pos = _pos;
	chain = _chain;
}