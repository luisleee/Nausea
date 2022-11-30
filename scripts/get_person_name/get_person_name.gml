// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_person_name(person){
	var display_name = "";
	switch person {
		case "Me":
			display_name = "我";
			break;
		case "Zww":
			display_name = "周文王";
			break;

	}
	return display_name;
}