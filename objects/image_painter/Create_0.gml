
/*
var no_movement = new NoMovement();
var zoom_in = new ZoomMovement(true);
var zoom_out = new ZoomMovement(false);

var pingpong_road = new PingPongMovement(false, {
	amplitude: 50,
	period: 60/108,
	init_phase: get_remainder(audio_sound_get_track_position(music_player.cur_track), 60/108),
});
var road_in = new ParallelMovement([zoom_in, pingpong_road]);

image_sources = [
	new Image(spr_frame_computer, 0, 0, true, [clone(zoom_in), no_movement, clone(zoom_out)], {
		scale_x: 8,
		scale_y: 8,
	}),
	new Image(spr_frame_shelf, 0, 0, true, [clone(zoom_in), no_movement, clone(zoom_out)], {
		scale_x: 8,
		scale_y: 8,
	}),
	new Image(spr_frame_bed, 0, 0, true, [clone(zoom_in), no_movement, clone(zoom_out)], {
		scale_x: 8,
		scale_y: 8,
	}),
	new Image(spr_frame_door, 0, 0, true, [clone(zoom_in), no_movement, clone(zoom_out)], {
		scale_x: 8,
		scale_y: 8,
	}),
	new Image(spr_sunrise, 0, 0, false, [no_movement, no_movement, no_movement], {
		scale_x: 4,
		scale_y: 4,
	}),
	new Image(spr_frame_bus, 0, 0, true, [clone(road_in), pingpong_road, clone(zoom_out)], {
		scale_x: 4,
		scale_y: 4,
	}),
	new Image(spr_shashasha, 0, 0, true, [clone(zoom_in), no_movement, clone(zoom_out)], {
		scale_x: 4,
		scale_y: 4,
	}),
];*/

imgs = [];

function add_image(_img) {
	array_push(imgs, createImage(_img));
}

function remove_image(_class) {
	for (var i = 0; i < array_length(imgs); i++) {
		if (imgs[i].class == _class) {
			imgs[i].movements.next();
		}
	}
}

function animation_finished() {
	return array_all(imgs, function(img){
		return !img.movements.start_phase() and !img.movements.end_phase();
	});	
}

function clear() {
	imgs = [];
}

