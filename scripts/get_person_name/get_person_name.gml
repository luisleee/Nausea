function get_person_name(person) {
	var name_map = {
		Me: "我",
		Brain: "我",
		Zww: "周文王",
	};


	return variable_struct_get(name_map, person);
}