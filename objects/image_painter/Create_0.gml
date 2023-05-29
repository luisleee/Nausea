// todo: use some image/mov preset

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

