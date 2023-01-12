/// Draw the options
var display_w = display_get_gui_width();
var display_h = display_get_gui_height();
var text_scale = 3.5 / 1600 * display_w;
var frame_h = 0.2 * display_w;
var unframe_h = display_h - frame_h;
var border_w = 0.02 * display_w / 2;
var options_area_h = unframe_h * array_length(options) / 6;
var frame_color = make_color_rgb(44, 44, 44);
var inner_color = make_color_rgb(188, 188, 188);
var char_h = string_width("啊");

draw_set_color(c_aqua);

draw_init(fnt_default, c_white, "mc", 1);
var option_w = 0;
for (var i = 0; i < array_length(options); i++) {
	option_w = max(option_w, string_width(options[i]) * text_scale);
}

var baseline = (unframe_h - options_area_h) / 2;

for (var i = 0; i < array_length(options); i++) {
	var offset = 0;
	if (array_length(options) != 1) {
		offset = i / (array_length(options) - 1) * options_area_h;
	}
		
	draw_set_color(frame_color);
	draw_rectangle(
		display_w / 2 - option_w / 2 - border_w * 3,
		baseline + offset - char_h - border_w * 3,
		display_w / 2 + option_w / 2 + border_w * 3,
		baseline + offset + char_h + border_w * 3,
		0
	);
	draw_set_color(inner_color);
	draw_rectangle(
		display_w / 2 - option_w / 2 - border_w * 2,
		baseline + offset - char_h - border_w * 2,
		display_w / 2 + option_w / 2 + border_w * 2,
		baseline + offset + char_h + border_w * 2,
		0
	);
	draw_set_color(c_black);
	if (i == selected) {
		draw_set_color(c_white);
	}
	draw_text_transformed(
		display_w / 2,
		baseline + offset,
		options[i],
		text_scale,
		text_scale,
		0
	);
}
