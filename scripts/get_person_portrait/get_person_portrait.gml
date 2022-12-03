function get_person_portrait(person, emotion){
	var spr_map = {};
	
	variable_struct_set(spr_map, "Me", [
		spr_eyes_zzm,
		spr_eyes_zzm_angry,
		spr_eyes_zzm_crazy,
	]);
	variable_struct_set(spr_map, "Zww", [
		spr_eyes_zp_normal,
	]);
	variable_struct_set(spr_map, "Brain", [
		spr_portrait_CTbrain,
	]);
	
	var sprs = variable_struct_get(spr_map, person);
	
	var portrait = undefined;
	if (is_array(sprs)) {
		portrait = sprs[emotion];	
	}
	
	return portrait;
}