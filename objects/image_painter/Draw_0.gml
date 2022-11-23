for(var i = 0; i < array_length(images); i++){
	draw_sprite_ext(images[i].spr, image_index, images[i].pos_x, images[i].pos_y, images[i].scale_x, images[i].scale_y, 0, c_white, images[i].alpha);
}