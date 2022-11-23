// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_halt_time(char){
	var halt = 1;
	var halt_puncs = ["。","，","！","？","…","—","：","；"];
	if(array_includes(halt_puncs, char)){
		halt = 6;
	}
	return halt;
}