enum movePattern {
	none,
	vertical,
	horizontal,
}

function Image (_spr, _posx, _posy, _scalex, _scaley, _alpha) constructor {
	spr = _spr;
	pos_x = _posx;
	pos_y = _posy;
	scale_x = _scalex;
	scale_y = _scaley;
	alpha = _alpha;
}


//var music = ;

image_sources = [
	new Image(spr_bedroom_f_computer, 0, 0, 4, 4, 1,),
	new Image(spr_bedroom_mess, 0, 0, 8, 8, 1,),
	new Image(spr_sunrise, 0, -200, 4, 4, 1,),
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

/*
function set_background_image(spr) {
	var sprites = get_image(spr);
	if (sprites == pointer_null) {
		return;
	}
	image_painter.set_images(sprites);
}*/

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
