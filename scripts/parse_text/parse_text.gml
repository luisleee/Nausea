function parse_text(str){
	var effects = [];
	for (var i = 1; i <= string_length(str) + 1; i++) {
		effects[i] = {
				color : undefined,
				shake : undefined,
				halt : 0
			};
	}

	for (var i = 1; i <= string_length(str); i++) {
		var _cur_char = string_char_at(str, i);
		if (_cur_char == "<") {
			var tag_str_length = 1;
			var tag_effect = "";
			while(true){
				if(string_char_at(str, i + tag_str_length) == ">"){
					tag_effect = string_copy(str, i, tag_str_length + 1);
					break;
				}else {
					tag_str_length ++;
				}	
			}
			str = string_delete(str, i, tag_str_length + 1);
			if(tag_effect == "<color=red>"){
				effects[i].color = c_red;
			}
			if(tag_effect == "<color=aqua>"){
				effects[i].color = c_aqua;
			}
			if(tag_effect == "<color=black>"){
				effects[i].color = c_black;
			}
			if(string_copy(tag_effect, 2, 5) == "shake"){
				var l = string_length(tag_effect);
				effects[i].shake = real(string_copy(tag_effect, 8, l - 8));
			}
			i -= 1;
		}
		if (_cur_char == "^") {
			str = string_delete(str, i, 1);
			i -= 1;
			effects[i].halt += 2;
		}
	}
	var line = new Line(str, effects);
	//show_debug_message(line.effects);
	return line;
}