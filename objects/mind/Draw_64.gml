var display_w = display_get_gui_width();
var display_h = display_get_gui_height();
//draw mind's flash
draw_set_color(c_white);
draw_set_alpha(mind_flash_apa);
draw_rectangle(0, 0, display_w, display_h, 0);