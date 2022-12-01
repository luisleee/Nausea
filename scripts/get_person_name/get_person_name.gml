function get_person_name(person) {
	var name_map = ds_map_create();
	name_map[? "Me"] = "我";
	name_map[? "Brain"] = "我";
	name_map[? "Zww"] = "周文王";

	var display_name = ds_map_find_value(name_map, person);
	
	ds_map_destroy(name_map);
	return display_name;
}