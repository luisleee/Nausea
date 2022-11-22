draw_set_font(fnt_test);
draw_set_color(c_white);
draw_set_align("tl");
draw_set_alpha(1);

///var definitions
var text_scale = 3.5;

var dis_w = display_get_gui_width();
var dis_h = display_get_gui_height();
var frm_h = 0.2 * dis_w;
var bdr_w = 0.02 * dis_w;
var por_w = 0.15 * dis_w;
var eye_h = 0.07 * dis_w;
var name_h = 0.06 * dis_w;
var frm_col = make_color_rgb(44,44,44);
var inner_col = make_color_rgb(188,188,188);
var person_col = make_color_rgb(25,128,158);
var grid_col = make_color_rgb(0,0,255);
var person_name = "古神牟嘉齐";
var eye_spr = spr_eyes_zzm;
var uiscale = dis_w/400;

///draw basic elements
//draw grids
/*
draw_set_color(grid_col);
for(var i = 0; i <= dis_w; i += bdr_w/2){
	draw_line(i,0,i,dis_h);
}
for(var i = 0; i <= dis_h; i += bdr_w/2){
	draw_line(0,i,dis_w,i);
}*/


//draw frames and inners
draw_set_alpha(1);
draw_set_color(frm_col);
draw_rectangle(0,
	dis_h - frm_h,
	dis_w,
	dis_h,0);
draw_set_color(inner_col);
draw_rectangle(bdr_w * 2 + por_w,
	dis_h - frm_h + bdr_w,
	dis_w - bdr_w,
	dis_h - bdr_w,0);

//draw frame for name and portrait
draw_set_color(person_col);
draw_rectangle(bdr_w,
	dis_h - frm_h + bdr_w,
	bdr_w + por_w,
	dis_h - bdr_w,0);
draw_set_color(inner_col);
draw_rectangle(bdr_w + bdr_w/2,
	dis_h - bdr_w -bdr_w/2 - name_h,
	bdr_w + por_w - bdr_w/2,
	dis_h - bdr_w -bdr_w/2,0);
	
//draw eyes
draw_sprite_ext(eye_spr,0,bdr_w + bdr_w/2,
	dis_h - frm_h + bdr_w + bdr_w/2,
	uiscale,uiscale,0,c_white,1);

///draw text things
//fit in the name and draw the name
draw_set_alpha(1);
draw_set_color(c_black);
var name_xscale = (por_w - bdr_w)/string_width(person_name);
var name_yscale = name_h/string_height(person_name);
draw_text_transformed(bdr_w + bdr_w/2,
	dis_h - bdr_w -bdr_w/2 - name_h,
	person_name,name_xscale,name_yscale,0);

//draw lines
draw_set_alpha(1);
draw_set_color(c_black);
draw_set_font(fnt_test);

var text_h = string_width("啊") * text_scale;
//var correct_h = 7/32 *256;
var text_sep = ((frm_h - bdr_w * 2) - text_h * 3)/4;



draw_text_ext_transformed(bdr_w * 2 + por_w + bdr_w,
	dis_h - frm_h + bdr_w + text_sep,
	"梦中没有错与对　梦中有安也有危\n梦的时代我在胡说　梦醒时刻才会解脱\n我不知道　我不能去说",text_sep,
	dis_w - por_w - 5 * bdr_w,
	text_scale,text_scale,0);
	
