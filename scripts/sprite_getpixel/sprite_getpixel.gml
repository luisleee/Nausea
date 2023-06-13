function sprite_data_free() {
	//Delete all buffers
	for (var i = 0; i < ds_map_size(global.sprBuff); i++) {
	    var arr = global.sprBuff[? i];
	    for (var j = 0; j < array_length(arr); j++) {
	        if (buffer_exists(arr[j])) {
	            buffer_delete(arr[j]);
	        }
	    }
	}

	//Delete map
	ds_map_destroy(global.sprBuff);
}


/// @description  Get the RGBA value of a pixel from sprite 
/// @function  sprite_get_pixel
/// @param {sprite} sprite Target sprite
/// @param {real} subimg Subimage of the sprite
/// @param {real} x X-coordination of the pixel
/// @param {real} y Y-coordination of the pixel
/// @returns {arr} The the RGBA value of the pixel
function sprite_get_pixel(_sprite, _subimg, _x, _y) {
	var sprW = sprite_get_width(_sprite);
	var sprH = sprite_get_height(_sprite);
	var sprX = sprite_get_xoffset(_sprite);
	var sprY = sprite_get_yoffset(_sprite);
	var key = string(_sprite);

	if (!variable_global_exists("sprBuff")) {
		global.sprBuff = ds_map_create();
	}

	//Create sprite array
	if (!ds_map_exists(global.sprBuff, key)) {
	    var arr = array_create(_subimg + 1, -1);
	    global.sprBuff[? key] = arr;
	}

	//Create buffer
	var arr = global.sprBuff[? key];
	if (array_length(arr) <= _subimg || !buffer_exists(arr[_subimg])) {
	    var buff = buffer_create(4 * sprW * sprH, buffer_fixed, 1);
	    arr[@ _subimg] = buff;

	    var surf = surface_create(sprW, sprH);
		var old_surf = surface_get_target();
	    surface_set_target(surf);

	    draw_clear_alpha(c_white, 0);

	    gpu_set_blendmode_ext(bm_one, bm_zero);

	    draw_sprite(_sprite, _subimg, sprX, sprY);

	    gpu_set_blendmode(bm_normal);

		surface_reset_target();
	    buffer_get_surface(arr[_subimg], surf, 0);
		
		
		if(surface_exists(surf)) {
			surface_free(surf);
		}
	   
	}

	//Get pixel
	var buff = arr[_subimg];
	buffer_seek(buff, buffer_seek_start, 4 * (sprW * _y+_x));

	var clr = array_create(4);
	clr[0] = buffer_read(buff, buffer_u8);
	clr[1] = buffer_read(buff, buffer_u8);
	clr[2] = buffer_read(buff, buffer_u8);
	clr[3] = buffer_read(buff, buffer_u8);

	return clr;
}
