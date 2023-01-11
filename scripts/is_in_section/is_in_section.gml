function is_in_interval(arg, int_edge1, int_edge2, close_inter){
	var left = min(int_edge1, int_edge2);
	var right = max(int_edge1, int_edge2);
	if(close_inter){
		return (arg >= left and arg <= right);
	}
	else {
		return (arg > left and arg < right);
	}
}
