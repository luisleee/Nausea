// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_wrap(str,wid,str_scale){
	var text_return = "";
	var wid_count = 0;
	var char_w = string_width("啊") * str_scale;
	for(var i = 1; i <= string_length(str); i++){
		var next_char = string_char_at(str,i);
		wid_count += string_width(next_char);
		if(wid_count * str_scale >= wid - char_w/2){
			if(not is_punctuation(next_char)){
				text_return += "\n";
				wid_count = 0;
			}
		}
		text_return += next_char;	
	}
	return text_return;
}