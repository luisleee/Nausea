for (var i = 0; i < array_length(imgs); i++) {
	var img = imgs[i];
	draw_sprite_ext(img.spr, img.spr.sprite_index, img.pos_x, img.pos_y, img.scale_x, img.scale_y, 0, c_white , img.alpha);	
}