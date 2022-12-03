function get_person_name(person) {
	var name_map = {};
	variable_struct_set(name_map, "Me", "我");
	variable_struct_set(name_map, "Brain", "我");
	variable_struct_set(name_map, "Zww", "周文王");

	var display_name = variable_struct_get(name_map, person);
	
	return display_name;
}