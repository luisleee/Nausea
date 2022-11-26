// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_person_portrait(person, emotion){
	var display_spr = noone;
	switch person {
		case "Me":
			var sprs = [
				spr_eyes_zzm,
				spr_eyes_zzm_angry,
				spr_eyes_zzm_crazy,
			];
			break;
	}
	display_spr = sprs[emotion];
	return display_spr;
}