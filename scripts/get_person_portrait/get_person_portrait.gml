function get_person_portrait(person, emotion){
	var spr_map = ds_map_create();
	spr_map[? "Me"] = [
		spr_eyes_zzm,
		spr_eyes_zzm_angry,
		spr_eyes_zzm_crazy,
	];
	spr_map[? "Zww"] = [
		spr_eyes_zp_normal,
	];
	
	var sprs = ds_map_find_value(spr_map, person);
	
	var portrait = undefined;
	if (is_array(sprs)) {
		portrait = sprs[emotion];	
	}
	
	ds_map_destroy(spr_map);
	
	return portrait;
}