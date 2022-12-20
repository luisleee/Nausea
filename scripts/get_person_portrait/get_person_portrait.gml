function get_person_portrait(person, emotion){
	var spr_map = {
		Me: [
			spr_eyes_zzm,
			spr_eyes_zzm_angry,
			spr_eyes_zzm_crazy,
		],
		Zww: [spr_eyes_zp_normal,],
		Brain: [spr_portrait_CTbrain,],
	};
	
	var sprs = variable_struct_get(spr_map, person);
	
	return sprs[emotion];
}