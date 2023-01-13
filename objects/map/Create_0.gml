map_width = 0;
map_height = 0;
cell_w = 100;
cell_h = 100;
mobility_per_turn = 5;

function pos2num(i, j) {
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
			var e = [];//the edges that [i,j] is connected to
			if (cells[i][j] != "o") {//cells starts from [0][0]
				edges[num] = e;//if not passable, no edges connected
				continue;
			}
			// right
			if (i != map_width - 1 && cells[i + 1][j] == "o") {
				array_push(e, {
					to: pos2num(i + 1, j),
					w: 1,
				});
			}
			// down
			if (j != map_height - 1 && cells[i][j + 1] == "o") {
				array_push(e, {
					to: pos2num(i, j + 1),
					w: 1,
				});
			}
			// left
			if (i != 0 && cells[i - 1][j] == "o") {
				array_push(e, {
					to: pos2num(i - 1, j),
					w: 1,
				});
			}
			// up
			if (j != 0 && cells[i][j - 1] == "o") {
				array_push(e, {
					to: pos2num(i, j - 1),
					w: 1,
				});
			}
			edges[num] = e;
		}
	}
	return edges;
}

s = 
"oxoooxooox\n" +
"ooxxoooxoo\n" +
"xooooooooo\n" +
"oxoooooooo\n" +
"oooooooooo\n" +
"oxoxoooxox\n" +
"oooooooooo\n" +
"oooooooooo\n" +
"oxoxoxoxox\n" +
"oooooooooo\n";

function set_map(str, start_pos) {
	cells = str2map(str, "\n");
	map_width = array_length(cells);
	map_height = array_length(cells[0]);
	edges = init_edges(cells);
	
	now_num = pos2num(start_pos[0], start_pos[1]);
	draw_pos = num2pos(now_num);
}

set_map(s, [0, 0]);

function find_path(src, dest) {//src meaning source, dest meaning destination (shitty comment)
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
		var e = edges[node];
		for (var i = 0; i < array_length(e); i++) {//get the edges connected with this node
			var to = e[i].to;
			var w = e[i].w;
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

