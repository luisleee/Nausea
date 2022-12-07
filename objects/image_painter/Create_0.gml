enum MOVE_PATTERN {
	NONE,
	VERTICAL,
	HORIZONTAL,
	ZOOM,
}




var no_movement = new Movement(MOVE_PATTERN.NONE, {});
var v1 = new Movement(MOVE_PATTERN.VERTICAL, {
	spd : -2,
	stop_y : -sprite_get_height(spr_sunrise),
});
var zoom_in = new Movement(MOVE_PATTERN.ZOOM, {
	frame_col : make_color_rgb(44,44,44),
	process : 0,
	mode : 1,
});
var zoom_out = new Movement(MOVE_PATTERN.ZOOM, {
	frame_col : make_color_rgb(44,44,44),
	process : 0,
	mode : 0,
});

image_sources = [
	new Image(spr_frame_computer, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_frame_shelf, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_frame_bed, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_frame_door, 0, 0, 8, 8, 1, clone(zoom_in)),
	new Image(spr_frame_computer, 0, 0, 8, 8, 1, clone(zoom_out)),
	new Image(spr_frame_shelf, 0, 0, 8, 8, 1, clone(zoom_out)),
	new Image(spr_frame_bed, 0, 0, 8, 8, 1, clone(zoom_out)),
	new Image(spr_frame_door, 0, 0, 8, 8, 1, clone(zoom_out)),
	new Image(spr_bedroom_mess, 0, 0, 8, 8, 1, no_movement),
	new Image(spr_sunrise, 0, 0, 4, 4, 1, v1),
	new Image(spr_person_zp, 0, -200, 8, 8, 1, no_movement),
	new Image(spr_frame_bus, 0, 0, 4, 4, 1, clone(zoom_in)),
	new Image(spr_shashasha, 0, 0, 4, 4, 1, clone(zoom_in)),
];

imgs_bedroom_in = array_slice(image_sources, 0, 3);
imgs_bedroom_out = array_slice(image_sources, 4, 7);//delete this shabi thing later pls
imgs_bus = [image_sources[11]];

imgs = [];//imgs_bus;