event_inherited();


//Paramètres
speed_horizontal_max = 10;
speed_addition= 1;
stomp_tolerance = 5;
jump_height = 15;
sound_toggle = false;

switch(room)
{
	case room0 :
	theme = snd_Theme;
	break;
	
	case room1 :
	theme = snd_ThemeDark;
	break;
}

audio_play_sound(theme,0,true);

