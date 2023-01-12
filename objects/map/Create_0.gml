map_width = 5;
map_height = 5;
cell_w = 100;
cell_h = 100;
mobility_per_turn = 2;

function pos2number(i, j) {
	return (i - 1) + (j - 1) * map_width;
}

function number2pos(n) {
	var i = n mod map_width + 1;
	var j = n div map_width + 1;
	return [i, j];
}

now_pos = pos2number(3, 3);
now_mobility = mobility_per_turn;
now_turn = 1;

last_pos = now_pos;
hover_pos = undefined;
goal_pos = now_pos;

movement_apa = 0;



function abs_posx(posx) {
	return posx * cell_w + x;
}
function abs_posy(posy) {
	return posy * cell_h + y;
}

function get_distance(pos1, pos2) {
	return abs(pos1[0] - pos2[0]) + abs(pos1[1] - pos2[1]);
}

my_player = instance_create_depth(abs_posx(number2pos(now_pos)[0]), abs_posy(number2pos(now_pos)[1]), -200, map_player);

cells = [
	["o", "x", "o", "o", "o"],
	["o", "x", "o", "x", "o"],
	["o", "o", "o", "o", "o"],
	["o", "o", "o", "o", "o"],
	["o", "o", "o", "o", "o"],
];

edges = array_create(map_width * map_height);

for (var i = 1; i <= map_width; i++) {
	for (var j = 1; j <= map_height; j++) {
		var num = pos2number(i, j);
		var e = [];
		if (cells[i - 1][j - 1] != "o") {
			edges[num] = e;
			continue;
		}
		// right
		if (i != map_width && cells[i][j - 1] == "o") {
			array_push(e, {
				to: pos2number(i + 1, j),
				w: 1,
			});
		}
		// down
		if (j != map_height && cells[i - 1][j] == "o") {
			array_push(e, {
				to: pos2number(i, j + 1),
				w: 1,
			});
		}
		// left
		if (i != 1 && cells[i - 2][j - 1] == "o") {
			array_push(e, {
				to: pos2number(i - 1, j),
				w: 1,
			});
		}
		// up
		if (j != 1 && cells[i - 1][j - 2] == "o") {
			array_push(e, {
				to: pos2number(i, j - 1),
				w: 1,
			});
		}
		edges[num] = e;
	}
}

function find_path(src, dest) {
	var q = new Heap(function(a, b){return b.dis - a.dis;});
	q.push({
		v: src,
		dis: 0,
	});
	var from = array_create(map_width * map_height, -1);
	var dis = array_create(map_width * map_height, -1);
	from[src] = undefined;
	dis[src] = 0;
	
	while(!q.empty()){
		var node = q.pop().v;
		if (node == dest) {
			break;
		}
		var e = edges[node];
		for (var i = 0; i < array_length(e); i++) {
			var to = e[i].to;
			var w = e[i].w;
			var new_dis = dis[node] + w;
			if (dis[to] == -1 or dis[to] > new_dis) {
				dis[to] = new_dis;
				from[to] = node;
				q.push({
					v: to,
					dis: new_dis + get_distance(number2pos(to), number2pos(dest)),
				});
			}
			
		}
	}
	var p = dest;
	var path = [dest];
	while (p != src) {
		p = from[p];
		array_push(path, p);
	}
	return {
		cost: dis[dest],
		path: array_reverse(path),
	};
}

show_debug_message(find_path(0, 20))