// todo: beautify and review and reconstruct something..
enum RHYTHM_TRACK_MODES {
	NOTE,
	SHOW
}


now_song = "something changed";
//note_start = [0, 414, 828, 1241, 1655, 2069, 2483, 2897, 3310, 3724, 4138, 4552, 4966, 5379, 5793, 6207, 6621, 7034, 7448, 7862, 8276, 8690, 9103, 9517, 9931, 10345, 10759, 11172, 11586, 12000, 12414, 12828, 13241, 13655, 14069, 14483, 14897, 15310, 15724, 16138, 16552, 16966, 17379, 17793, 18207, 18621, 19034, 19448, 19862, 20276, 20690, 21103, 21517, 21931, 22345, 22759, 23172, 23586, 24000, 24414, 24828, 25241, 25655, 26069, 26483, 26897, 27310, 27724, 28138, 28552, 28966, 29379, 29793, 30207, 30621, 31034, 31448, 31862, 32276, 32690, 33103, 33517, 33931, 34345, 34759, 35172, 35586, 36000, 36414, 36828, 37241, 37655, 38069, 38483, 38897, 39310, 39724, 40138, 40552, 40966];
//[9126, 9285, 9661, 10170, 11907, 12447, 13210, 13438, 13708, 14195, 17262, 17511, 17797, 18305, 18829, 19338, 20339, 20604, 21351, 21626, 21864, 22378];

judgement_area = [50, 180, 300];

function name2track(_name) {
	for (var i = 0; i < array_length(tracks); i++) { 
		if (tracks[i].name == _name) {
			return i;
		}
	}
}


movement_lyrics = function(_name, _details) {
	//Create
	if (event_type == ev_create) {
		lyrics = _details.lyrics;
		lyric_page = 0;
		lyric_word = 0;
		lyric_sound = _details.sound;
		
		for (var i = 0; i < array_length(lyrics); i++) {
			lyrics[i] = split(lyrics[i], " ");
			for (var j = 0; j < array_length(lyrics[i]); j++) {
				lyrics[i][j] += " ";
			}
			for (var j = 0; j < array_length(lyrics[i]); j++) {
				var sep_words = split(lyrics[i][j], "+");
				if (array_length(sep_words) > 1) {
					lyrics[i][j] = sep_words[0];
					for (var n = 1; n < array_length(sep_words); n++) {
						array_insert(lyrics[i], j + n, sep_words[n]);
					}
				}
			}
		}
	}
	
	//Step
	var now_time = current_time - start_time;
	var track_num = name2track(_name);
	var note_time = tracks[track_num].keyframes[keyframe_num[track_num]] - relative_start;
	
	if (now_time >= note_time) {
		if (lyric_word < array_length(lyrics[lyric_page])) {
			lyric_word ++;
		}
		else if (lyric_page < array_length(lyrics) - 1){
			lyric_word = 1;
			lyric_page ++;
		}
		if (keyframe_num[track_num] < array_length(tracks[track_num].keyframes) - 1) {
			keyframe_num[track_num] ++;
			if (!is_undefined(lyric_sound)) {
				audio_play_sound(lyric_sound, 0, 0);
			}
		}
	}
	
	//draw
	draw_init(fnt_default, c_white, "tl", 1);
	var w = 0;
	for (var i = 0; i < array_length(lyrics[lyric_page]); i++) {
		if (i < lyric_word) {
			draw_set_color(c_black);
			draw_text_transformed(100 + w + 2, 100 + 2, lyrics[lyric_page][i], text_scale, text_scale, 0);
			draw_set_color(c_white);
			draw_text_transformed(100 + w, 100, lyrics[lyric_page][i], text_scale, text_scale, 0);
			
		}
		w += string_width(lyrics[lyric_page][i]) * text_scale;
	}
}
movement_snowflakes = function(_name, _details) {
	//Create
	if (event_type == ev_create) {
		snowflakes = _details.snowflakes;
		snowflake_kf_num = array_create(array_length(snowflakes), 0);
		petal_num = 6;
		now_petal_num = petal_num;
		snowflake_rot_off = 0;
		
	}
	
	//Step
	var now_time = current_time - start_time;
	var track_num = name2track(_name);
	var note_time = tracks[track_num].keyframes[keyframe_num[track_num]] - relative_start;

	
	var kn = keyframe_num[track_num];
	var keyf = tracks[track_num].keyframes[kn];
	
	snowflake_rot_off ++;
	
	/*if (keyboard_check_pressed(vk_space)) {
		if (now_petal_num > 0) {
			now_petal_num --;
		}
	}*/
	if (now_time >= note_time) {
		if (keyframe_num[track_num] < array_length(tracks[track_num].keyframes) - 1) {
			keyframe_num[track_num] ++;
		}
	}
	for (var a = 0; a < array_length(tracks[track_num].keyframes); a ++) {
		if (now_time >= snowflakes[a].kfs[a] - relative_start) {
			snowflake_kf_num[a] ++;
			snowflakes[a].now_petal_num --;
		}
	}
	
	
	//draw
	draw_init(fnt_default, c_white, "tl", 1);
	
	for (var a = 0; a < kn; a ++) {
		//if (snowflakes[a].last_frame < keyf) {
			for (var i = 0; i < snowflakes[a].petal_num; i ++) {
				draw_sprite_ext(
					spr_snowflake_part,
					0,
					snowflakes[a].start_pos[0],
					snowflakes[a].start_pos[1],
					1,
					1,
					360/petal_num * i + snowflake_rot_off + snowflakes[a].init_rot,
					c_white,
					i + 1 <= snowflakes[a].now_petal_num
				)
			}
		//}
	}
	
}
movement_bike = function(_name, _details) {
	//Create
	if (event_type == ev_create) {
		back_index = 0;
		back_spr = spr_bike_back_test;
		back_scale = room_height / sprite_get_height(back_spr);
		back_xoff = sprite_get_width(back_spr)/2 * back_scale - room_width/2;
		back_spd = 12;
		
		bike_back_spr = spr_bike_fps_back;
		bike_front_spr = spr_bike_fps_front;
		bike_scale = room_height / sprite_get_height(bike_back_spr);
		bike_rot_spd = 0.5;
		bike_rot = 0;
	} else {
		//Step
		back_index += 1/6;
		var xoff_max = [0, sprite_get_width(back_spr) * back_scale - room_width];
		var delta_rot = 0;
		if (keyboard_check(vk_right)) {
			if (back_xoff + back_spd < xoff_max[1]) {
				back_xoff += back_spd;
			}
			if (bike_rot - bike_rot_spd > -20) {
				delta_rot += -bike_rot_spd;
			}
		}
		if (keyboard_check(vk_left)) {
			if (back_xoff - back_spd > xoff_max[0]) {
				back_xoff -= back_spd;
			}
			
			if (bike_rot + bike_rot_spd < 20) {
				delta_rot += bike_rot_spd;
			}
		}
		bike_rot += delta_rot;
		
		var rot_dir = ((bike_rot < 0) - 0.5) * 2;
		if (delta_rot == 0) {
			bike_rot += bike_rot_spd/2 * rot_dir;
			if (is_in_interval(back_xoff - back_spd/2 * rot_dir, xoff_max[0], xoff_max[1], true)) {
				if (!is_in_interval(back_xoff, xoff_max[1]/2 - 10, xoff_max[1]/2 + 10, true)) {
					back_xoff -= back_spd/2 * rot_dir;
				}
			}
		}
		
		//Draw
		draw_sprite_ext(back_spr, back_index, -back_xoff, 0, back_scale, back_scale, 0, c_white, 1);
		draw_sprite_ext(bike_back_spr, 0,  room_width/2, room_height, bike_scale, bike_scale, 0, c_white, 1);
		draw_sprite_ext(bike_front_spr, 0,  room_width/2, room_height - 80, bike_scale, bike_scale, bike_rot, c_white, 1);
	
	}
}

tracks = [
	new RhythmTrack(
		RHYTHM_TRACK_MODES.NOTE,
		"ride",
		new RhythmNoteInfo(
			vk_left,
			spr_rh_arrow_left,
			snd_sfx_rh_ride,
			[2069, 3724, 5379, 7034, 7448, 7655, 8690, 10345, 12000, 13655, 14069, 
			14276, 15310, 16966, 18621, 20276, 20690, 21931, 23586, 25241, 26897, 
			27310, 27517, 28552, 30207, 31862, 33517, 33931, 35172, 36828, 38483, 
			40138, 40552, 40759]
		)
	),
	new RhythmTrack(
		RHYTHM_TRACK_MODES.NOTE,
		"kick",
		new RhythmNoteInfo(
			vk_up,
			spr_rh_arrow_up,
			snd_sfx_rh_kick,
			[1241, 2069, 2897, 3724, 4552, 5379, 6207, 7034, 7862, 8690, 9517, 10345,
			11172, 12000, 12828, 13655, 14483, 15310, 16138, 16966, 17793, 18621,
			19448, 20276, 21103, 21931, 22759, 23586, 24414, 25241, 26069, 26897,
			27724, 28552, 29379, 30207, 31034, 31862, 32690, 33517, 34345, 35172,
			36000, 36828, 37655, 38483, 39310, 40138]
		)
	),
	new RhythmTrack(
		RHYTHM_TRACK_MODES.NOTE,
		"snare",
		new RhythmNoteInfo(
			vk_right,
			spr_rh_arrow_right,
			snd_sfx_rh_snare,
			[1655, 2483, 3310, 4138, 4966, 5793, 6621, 7448, 8276, 9103, 9931,
			10759, 11586, 12414, 13241, 14069, 14897, 15724, 16552, 17379, 18207,
			19034, 19862, 20690, 21517, 22345, 23172, 24000, 24828, 25655, 26483,
			27310, 28138, 28966, 29793, 30621, 31448, 32276, 33103, 33931, 34759, 
			35586, 36414, 37241, 38069, 38897, 39724, 40552]
		)
	),
	new RhythmTrack(
		RHYTHM_TRACK_MODES.SHOW,
		"bike",
		new RhythmShowInfo(
			movement_bike,
			[],
			{
				
			}
		)
	),
	new RhythmTrack(
		RHYTHM_TRACK_MODES.SHOW,
		"melody",
		new RhythmShowInfo(
			movement_lyrics,
			[1241, 1345, 1448, 1552, 1655, 1862, 2069, 2897,
			3000, 3103, 3207, 3310, 3517, 3724, 4552, 4655,
			4759, 4862, 4966, 5172, 5379, 6207, 6310, 6414,
			6517, 6621, 6828, 7034, 7862, 7966, 8069, 8172,
			8276, 8483, 8690, 9517, 9621, 9724, 9828, 9931, 
			10138, 10345, 11172, 11276, 11379, 11483, 11586, 
			11793, 12000, 12828, 12931, 13034, 13138, 13241, 
			13448, 13655, 14483, 14586, 14690, 14793, 14897, 15103,
			15310, 16138, 16241, 16345, 16448, 16552, 16759, 16966,
			17793, 17897, 18000, 18103, 18207, 18414, 18621, 19448,
			19552, 19655, 19759, 19862, 20069, 20276, 21103, 21207,
			21310, 21414, 21517, 21724, 21931, 22759, 22862, 22966,
			23069, 23172, 23379, 23586, 24414, 24517, 24621, 24724, 
			24828, 25034, 25241, 26069, 26172, 26276, 26379, 26483, 
			26690, 26897, 27724, 27828, 27931, 28034, 28138, 28345, 
			28552, 29379, 29483, 29586, 29690, 29793, 30000, 30207, 
			31034, 31138, 31241, 31345, 31448, 31655, 31862, 32690, 
			32793, 32897, 33000, 33103, 33310, 33517],
			{
				lyrics: [
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？",
					"朝+阳+北+路+怎+么+走？"
				],
				sound: snd_sfx_text
			}
		)
	),
	new RhythmTrack(
		RHYTHM_TRACK_MODES.SHOW,
		"snowflakes",
		new RhythmShowInfo(
			movement_snowflakes,
			[4000,  //2897,
			],
			{
				snowflakes: [
					new SnowflakeInfo([5000, 6000, 7000, 8000, 9000, 10000], [100, 100], [100, 700]),
				]
			}
		)
	)
];

for (var i = 0; i < array_length(tracks); i++) {
	if (tracks[i].track_mode == RHYTHM_TRACK_MODES.NOTE) {
		note_num[i] = 0;
		note_judgement[i] = array_create(array_length(tracks[i].notes), undefined);
	}
	if (tracks[i].track_mode == RHYTHM_TRACK_MODES.SHOW) {
		keyframe_num[i] = 0;
	}
}


text_scale = 4;
start_time = current_time;
relative_start = 0;
audio_play_sound(snd_ost_birthday, 0, 0, 1, relative_start/1000);

function show_perform() {
	for (var i = 0; i < array_length(tracks); i++) { 
		if (tracks[i].track_mode == RHYTHM_TRACK_MODES.SHOW) {
			tracks[i].movement(tracks[i].name, tracks[i].details);
		}
	}
}

function judgement_rate(ranges, ratings, val) {
	for (var i = 0; i < array_length(ranges); i++) {
		if (abs(val) <= ranges[i]) {
			return ratings[i];
		}
	}
	return array_last(ratings);
	//example: judgement_rate([100, 200, 300], ["perfect", "good", "bad", "miss"], press_time - note_start)
}

function note_num2word_num(_note_num) {
	var num_add = 0;
	for (var i = 0; i < array_length(lyrics); i++) {
		if (_note_num - num_add <= array_length(lyrics[i])) {
			return _note_num - num_add;
		}
		num_add += array_length(lyrics[i]);
	}
}

function note_num_addup(_page) {
	var num_add = 0;
	for (var i = 0; i < _page; i++) {
		num_add += array_length(lyrics[i]);
	}
	return num_add;
}

function get_closest_note(_track, _max_distance) {
	var closest_num = undefined;
	var closest_distance = _max_distance;
	for (var i = 0; i < array_length(tracks[_track].notes); i++) {
		var this_distance = abs((current_time - start_time) - (tracks[_track].notes[i] - relative_start));
		if(this_distance < closest_distance and is_undefined(note_judgement[_track][i])) {
			closest_distance = this_distance;
			closest_num = i;
		}
	}
	return closest_num;
}

show_perform();