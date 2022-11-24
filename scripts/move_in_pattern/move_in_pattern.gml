// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_in_pattern(pattern, args){
	if(pattern == movePattern.vertical){
		if(args.spd > 0 and y < args.stop_y){
			y += args.spd;
		}
		if(args.spd < 0 and y > args.stop_y){
			y += args.spd;
		}	
	}
}