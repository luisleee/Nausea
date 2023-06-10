function MindSymbol(_spr, _desc, _other_desc) constructor {
	spr = _spr;
	desc = _desc;
	other_desc = _other_desc;
	un_desc = variable_struct_get(_other_desc, "un");
	re_desc = variable_struct_get(_other_desc, "re");
	val_desc = variable_struct_get(_other_desc, "val");
	
	static function full_desc() {
		var marks = available_marks();
		var descs = array_map(marks, function(mk) {
			var preffixes = {
				no: "",
				un: "否定：",
				re: "逆转：",
				val: "量化：",
			};
			return variable_struct_get(preffixes, mk) + marked_desc(mk);
		});
		return array_join(descs, "\n");
	}
	
	static function marked_desc(mark) {
		if (mark == "no") {
			return desc;	
		}
		return variable_struct_get(other_desc, mark);
	}

	static function available_marks() {
		var all_marks = ["no", "un", "re", "val"];
		return array_filter(all_marks, function(mk) {
			return marked_desc(mk) != undefined;
		});
	}
}

function AnswerSymbol(_symbol, _mark) constructor {
	symbol = _symbol;
	spr = _symbol.spr;
	desc = _symbol.desc;
	un_desc = _symbol.un_desc;
	re_desc = _symbol.re_desc;
	val_desc = _symbol.val_desc;
	mark = _mark;
}

function Answer(_concepts, _sentence) constructor {
	concepts = _concepts;
	sentence = _sentence;
}