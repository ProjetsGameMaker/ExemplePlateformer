event_inherited();
//Initialization
haswon = false;

//Paramètres
speed_horizontal_max = 10;
speed_addition= 1;
jump_height = 15;

stomp_tolerance = 5;
stomp_height = jump_height/1.5;
deathjump_height = jump_height * 1.5;
sound_toggle = true;

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

