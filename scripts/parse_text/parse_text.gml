function TextEffect(_color, _shake, _halt, _float) constructor {
	color = _color;
	shake = _shake;
	halt = _halt;
	float = _float;
}

/**
 * Parse a tag (without angle brackets)
 * @param {string} tag Unparsed tag
 * @returns {struct} Key-value pair in the tag
 */
function parse_tag(tag) {	
	var color_map = {
		red: c_red,
		aqua: c_aqua,
		black: c_black,
	}
	
	var params = split(tag, ",");
	var obj = {};
	for(var i = 0; i < array_length(params); i++) {
		var vals = split(params[i], "=");
		var key = vals[0];
		var val = vals[1];
		if (key == "color") {
			obj.color = variable_struct_get(color_map, val);
		} else if (key == "shake") {
			obj.shake = real(val);
		} else if (key == "float") {
			obj.float = real(val);
		}
	}
	return obj;
}

/**
 * Parse hyper-text
 * @param {string} text Unparsed text
 * @returns {struct} raw_text & effects
 */
function parse_text(text) {
	var raw_text = "";
	var effects = [new TextEffect(c_black, 0, 0, new FloatTextInfo(0, 0, 0))];// string starts from f**king 1
	var tag = "";
	var in_tag = false;

	var color = c_black;
	var shake = 0;
	var float = 0;
	
	for (var i = 1; i <= string_length(text); i++) {
		
		var ch = string_char_at(text, i)
		if (in_tag) {
			if (ch == ">") {
				in_tag = false;
				
				var tag_obj = parse_tag(tag);
				var c = variable_struct_get(tag_obj, "color");
				var s = variable_struct_get(tag_obj, "shake");
				var f = variable_struct_get(tag_obj, "float");
				color = is_undefined(c) ? color : c;
				shake = is_undefined(s) ? shake : s;
				float = is_undefined(f) ? float : f;
				
				tag = "";
			} else {
				tag += ch;
			}
		} else {
			if (ch == "^") {
				effects[array_length(effects) - 1].halt += 2;
				continue;
			} else if (ch == "<") {
				in_tag = true;
				continue;
			} else {
				raw_text += ch;
			}
			
			var float_info = float ? float_info_initialize() : new FloatTextInfo(0, 0, 0);
			var effect = new TextEffect(color, shake, 0, float_info);
			array_push(effects, effect);
		}
	}
	return {
		raw_text: raw_text,
		effects: effects,
	};
}