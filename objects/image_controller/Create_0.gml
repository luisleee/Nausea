enum movePattern {
	none,
	vertical,
	horizontal,
}

function Pattern (_move_pattern, _args) constructor {
	move_pattern = _move_pattern;
	args = _args;
}

function Image (_spr, _posx, _posy, _scalex, _scaley, _alpha, _pattern) constructor {
	spr = _spr;
	pos_x = _posx;
	pos_y = _posy;
	scale_x = _scalex;
	scale_y = _scaley;
	alpha = _alpha;
	pattern = _pattern;
}

var no_movement = new Pattern(movePattern.none, {});

image_sources = [
	new Image(spr_bedroom_f_computer, 0, 0, 4, 4, 1, no_movement),
	new Image(spr_bedroom_mess, 0, 0, 8, 8, 1, no_movement),
	new Image(spr_sunrise, 0, 0, 4, 4, 1, no_movement),
];
	
function get_image(_spr) {
	var len = array_length(image_sources);
	for (var i = 0; i < len; i++) {
		if (image_sources[i].spr == _spr) {
			return image_sources[i];
		}
	}
	return pointer_null;
}

function add_image(spr){
	var dep = 0;
	for(var i = 0; i < array_length(spr); i ++){
		var img = get_image(spr[i]);
		var myplayer = instance_create_depth(img.pos_x, img.pos_y, dep, sprite_player);
		myplayer.sprite_index = img.spr;
		myplayer.image_xscale = img.scale_x;
		myplayer.image_yscale = img.scale_y;
		myplayer.image_alpha = img.alpha;
		dep --;
	}
}

function remove_image(spr){
	for(var i = 0; i < array_length(spr); i ++){
		with sprite_player {
			if(sprite_index == spr[i])instance_destroy();
		}
	}
}

add_image([spr_sunrise]);
//remove_image([spr_bedroom_mess]);
