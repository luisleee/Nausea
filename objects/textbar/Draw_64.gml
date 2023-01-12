draw_init(fnt_default, c_white, "tl", 1);

/// var definitions

var display_w = display_get_gui_width();
var display_h = display_get_gui_height();
var text_scale = 3.5/1600 * display_w;
var frame_h = 0.2 * display_w;
var border_w = 0.02 * display_w;
var portrait_w = 0.15 * display_w;
var eye_h = 0.07 * display_w;
var name_h = 0.06 * display_w;
var frame_color = make_color_rgb(44,44,44);
var inner_color = make_color_rgb(188,188,188);
var person_color = make_color_rgb(25,128,158);

var uiscale = 0.0025 * display_w;

/// draw basic elements

//draw CASIO icon first
var icon_y = (display_h - task_manager.pos_y) * 46/300;
draw_sprite_stretched(spr_casio_icon, 0, 0, icon_y, display_w, display_h);

// draw frames and inners
draw_set_alpha(1);
draw_set_color(frame_color);
draw_rectangle(
	0,
	display_h - frame_h,
	display_w,
	display_h,
	0
);
draw_set_color(inner_color);
draw_rectangle(
	border_w * 2 + portrait_w,
	display_h - frame_h + border_w,
	display_w - border_w,
	display_h - border_w,
	0
);

//draw frame for name and portrait
draw_set_color(person_color);
draw_rectangle(
	border_w,
	display_h - frame_h + border_w,
	border_w + portrait_w,
	display_h - border_w,
	0
);
draw_set_color(inner_color);
draw_rectangle(
	border_w + border_w / 2,
	display_h - border_w - border_w / 2 - name_h,
	border_w + portrait_w - border_w / 2,
	display_h - border_w - border_w / 2,
	0
);

assert("person_portrait is not undefined", !is_undefined(person_portrait));
//draw eyes
draw_sprite_ext(
	person_portrait,
	subimg,
	border_w + border_w / 2,
	display_h - frame_h + border_w + border_w / 2,
	uiscale * (52 / sprite_get_width(person_portrait)),
	uiscale * (28 / sprite_get_height(person_portrait)),
	0,
	c_white,
	1
);


///draw text things
//fit in the name and draw the name
draw_set_alpha(1);
draw_set_color(c_black);
var name_yscale = name_h / string_height(person_name);
var name_xscale = name_yscale;
if((portrait_w - border_w) / string_width(person_name) < name_yscale){
	name_xscale = (portrait_w - border_w) / string_width(person_name);
}

draw_set_align("mc");
draw_text_transformed(
	border_w + portrait_w / 2,
	display_h - border_w - border_w / 2 - name_h/2,
	person_name,
	name_xscale,
	name_yscale,
	0
);

//draw lines
draw_init(fnt_default, c_black, "tl", 1);

var text_h = string_width("啊") * text_scale;
var text_w = string_width("啊") * text_scale;
var text_sep = ((frame_h - border_w * 2) - text_h * 3)/4;


var text_display = string_copy(raw_text, 1, char_count);
var wrapped_text = string_wrap(
	text_display,
	display_w - portrait_w - 5 * border_w,
	text_scale,
	"^"
);

var wrap_count = 0;
var cur_line_width = 0;
var j = 1;

for (var i = 1; i <= string_length(wrapped_text); i++) {
	draw_set_color(text_effects[j].color);
	var char_shake_range = text_effects[j].shake;
	
	var cur_char = string_char_at(wrapped_text, i);
	if (cur_char == "^") {
		wrap_count++;
		cur_line_width = 0;
		continue;
	} 
	if (cur_char == "\n") {
		wrap_count++;
		cur_line_width = 0;
	} 
	var xoffset = random_range(-char_shake_range, char_shake_range);
	var yoffset = random_range(-char_shake_range, char_shake_range);
	draw_text_transformed(
		border_w * 2 + portrait_w + border_w + cur_line_width + xoffset,
		display_h - frame_h + border_w + text_sep + (text_sep + text_h) * wrap_count + yoffset,
		cur_char,
		text_scale,
		text_scale,
		0
	)
	cur_line_width += string_width(cur_char) * text_scale;
	j++;
}

