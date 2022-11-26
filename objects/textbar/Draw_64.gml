draw_set_font(fnt_test);
draw_set_color(c_white);
draw_set_align("tl");
draw_set_alpha(1);

///var definitions


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
	
//draw eyes
draw_sprite_ext(
	person_portrait,
	0,
	border_w + border_w / 2,
	display_h - frame_h + border_w + border_w / 2,
	uiscale,
	uiscale,
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
draw_init(fnt_test, c_black, "tl", 1);

var text_h = string_width("啊") * text_scale;
var text_sep = ((frame_h - border_w * 2) - text_h * 3)/4;

var text_display = string_copy(current_text, 1, char_count);
var wrapped_text = string_wrap(
	text_display,
	display_w - portrait_w - 5 * border_w,
	text_scale
)

draw_text_ext_transformed(
	border_w * 2 + portrait_w + border_w,
	display_h - frame_h + border_w + text_sep,
	wrapped_text,
	text_sep,
	display_w - portrait_w - 5 * border_w,
	text_scale,
	text_scale,
	0
);
	
