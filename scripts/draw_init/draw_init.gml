/**
 * Initialize draw environment
 * @param {asset.GMFont} fnt Font
 * @param {Constant.Color} col Color
 * @param {string} ali Align
 * @param {real} apa Opacity
 */
function draw_init(fnt, col, ali, apa) {
	draw_set_font(fnt);
	draw_set_color(col);
	draw_set_align(ali);
	draw_set_alpha(apa);
}