map_width = 0;
map_height = 0;
cell_w = 96;
cell_h = 96;
mobility_per_turn = 5;

function pos2num(i, j) {
	// single argument
	if (is_undefined(j)) {
		j = i[1];
		i = i[0];
	}
	return i + j * map_width;
}

function num2pos(n) {
	var i = n mod map_width;
	var j = n div map_width;
	return [i, j];
}

now_num = 0;
draw_pos = [0, 0];
now_mobility = mobility_per_turn;
now_turn = 1;

hover_num = undefined;

move_time = 10;
move_time_left = move_time;
move_spd = 1;
this_path = [];

cells = [];
edges = [];
trans_cells = [];
map_sprite = undefined;

function abs_posx(posx) {
	return x + posx * cell_w;
}
function abs_posy(posy) {
	return y + posy * cell_h;
}

function draw_cell(_x, _y) {
	draw_rectangle(
		abs_posx(_x) - cell_w/2,
		abs_posy(_y) - cell_h/2, 
		abs_posx(_x) + cell_w/2,
		abs_posy(_y) + cell_h/2,
		0
	);
}

function get_distance(pos1, pos2) {
	return abs(pos1[0] - pos2[0]) + abs(pos1[1] - pos2[1]);
}

function str2map (str, sep_char) {	
	var strs = split(str, sep_char);
	var map_w = string_length(strs[0]);
	var map_h = array_length(strs);

	var map_arr = [];

	for (var i = 0; i < map_w; i++) {
		array_push(map_arr, []);
		for (var j = 0; j < map_h; j++) {
			array_push(map_arr[i], string_char_at(strs[j], i + 1));
		}
	}

	return map_arr;
}

function init_edges(cells) {
	var edges = array_create(map_width * map_height);

	//add all nodes' edges into the array above("edges")
	for (var i = 0; i < map_width; i++) {
		for (var j = 0; j < map_height; j++) {
			var num = pos2num(i, j);
			var es = [];// the edges that [i,j] is connected to
			
			if (cells[i][j] == "x") {// cells starts from [0][0]
				edges[num] = es;// if not passable, no edges connected
				continue;
			}
			
			var neighbors = [];
			// right
			if (i != map_width - 1) {
				array_push(neighbors, {
					num: pos2num(i + 1, j),
					c: cells[i + 1][j],
				});
			}
			// down
			if (j != map_height - 1) {
				array_push(neighbors, {
					num: pos2num(i, j + 1),
					c: cells[i][j + 1],
				});
			}
			// left
			if (i != 0) {
				array_push(neighbors, {
					num: pos2num(i - 1, j),
					c: cells[i - 1][j],
				});
			}
			// up
			if (j != 0) {
				array_push(neighbors, {
					num: pos2num(i, j - 1),
					c: cells[i][j - 1],
				});
			}
			
			for (var k = 0; k < array_length(neighbors); k++) {
				var to = neighbors[k].num;
				var c = neighbors[k].c;
				if (c == "x") {
					continue;
				}
				var w = 1;
				switch c {
					case "o":
						w = 1;
						break;
					case "#":
						w = 2;
						break;
				}
				array_push(es, {
					to: to,
					w: w,
				});
			};
			
			edges[num] = es;
		}
	}
	return edges;
}

function set_map(name, start_pos) {
	var map_info = map_control.get_map(name);
	
	map_sprite = map_info.spr;
	cells = str2map(map_info.signs, "\n");
	trans_cells = map_info.trans_cells;
	event_cells = map_info.event_cells;
	map_width = array_length(cells);
	map_height = array_length(cells[0]);
	
	edges = init_edges(cells);
	
	now_num = pos2num(start_pos[0], start_pos[1]);
	draw_pos = num2pos(now_num);
	
	x = room_width / 2 - map_width * cell_w / 2 + cell_w / 2;
	y = room_height / 2 - map_height * cell_h / 2 + cell_h / 2;

	
}

set_map("passage", [2, 3]);

function find_path(src, dest) {// src meaning source, dest meaning destination (shitty comment)
	var q = new Heap(function(a, b){return b.dis - a.dis;});
	q.push({
		v: src,
		dis: 0,
	});
	var from = array_create(map_width * map_height, -1);
	var dis  = array_create(map_width * map_height, -1);
	dis[src] = 0;
	
	while (!q.empty()) {
		var node = q.pop().v;
		var es = edges[node];
		for (var i = 0; i < array_length(es); i++) {//get the edges connected with this node
			var to = es[i].to;
			var w = es[i].w;
			var new_dis = dis[node] + w;
			if (dis[to] == -1 or dis[to] > new_dis) {
				dis[to] = new_dis;//update the distance
				from[to] = node;//update the path basing on the new minimum distance
				q.push({
					v: to,
					dis: new_dis + get_distance(num2pos(to), num2pos(dest)),
				});
			}
			
		}
	}
	if (dis[dest] == -1) {
		return {
			dis: dis,
			path: undefined,
		};
	}
	var p = dest;
	var path = [dest];
	while (p != src) {
		p = from[p];
		array_push(path, p);
	}
	return {
		dis: dis,
		path: array_reverse(path),
	};
}

