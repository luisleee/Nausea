map_width = 10;
map_height = 10;
cell_w = 100;
cell_h = 100;
mobility_per_turn = 5;

function pos2number(i, j) {
	return i + j * map_width;
}

function number2pos(n) {
	var i = n mod map_width;
	var j = n div map_width;
	return [i, j];
}

now_pos = pos2number(5, 5);
draw_pos = number2pos(now_pos);
now_mobility = mobility_per_turn;
now_turn = 1;

hover_pos = undefined;

move_time = 10;
move_time_left = move_time;
move_spd = 1;
this_path = [];

function abs_posx(posx) {
	return x + (posx + 1) * cell_w;
}
function abs_posy(posy) {
	return y + (posy + 1) * cell_h;
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


cells = [
	["o", "x", "o", "o", "o", "o", "x", "o", "o", "o"],
	["o", "x", "o", "x", "o", "o", "x", "o", "x", "o"],
	["o", "o", "o", "o", "o", "o", "o", "o", "o", "o"],
	["o", "o", "o", "o", "o", "o", "o", "o", "o", "o"],
	["o", "o", "o", "o", "o", "o", "o", "o", "o", "o"],
	["o", "x", "o", "o", "o", "o", "x", "o", "o", "o"],
	["o", "x", "o", "x", "o", "o", "x", "o", "x", "o"],
	["o", "o", "o", "o", "o", "o", "o", "o", "o", "o"],
	["o", "o", "o", "o", "o", "o", "o", "o", "o", "o"],
	["o", "o", "o", "o", "o", "o", "o", "o", "o", "o"],
];

edges = array_create(map_width * map_height);

//add all nodes' edges into the array above("edges")
for (var i = 0; i < map_width; i++) {
	for (var j = 0; j < map_height; j++) {
		var num = pos2number(i, j);
		var e = [];//the edges that [i,j] is connected to
		if (cells[i][j] != "o") {//cells starts from [0][0]
			edges[num] = e;//if not passable, no edges connected
			continue;
		}
		// right
		if (i != map_width - 1 && cells[i + 1][j] == "o") {
			array_push(e, {
				to: pos2number(i + 1, j),
				w: 1,
			});
		}
		// down
		if (j != map_height - 1 && cells[i][j + 1] == "o") {
			array_push(e, {
				to: pos2number(i, j + 1),
				w: 1,
			});
		}
		// left
		if (i != 0 && cells[i - 1][j] == "o") {
			array_push(e, {
				to: pos2number(i - 1, j),
				w: 1,
			});
		}
		// up
		if (j != 0 && cells[i][j - 1] == "o") {
			array_push(e, {
				to: pos2number(i, j - 1),
				w: 1,
			});
		}
		edges[num] = e;
	}
}

function find_path(src, dest) {//src meaning source, dest meaning destination
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
					dis: new_dis + get_distance(number2pos(to), number2pos(dest)),
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

