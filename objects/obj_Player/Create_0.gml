
//Récupère le code de l'évenement Create du parent (obj_ParentLiving)
event_inherited();

//Initialization
haswon = false;

/////PARAMETRES/////
speed_horizontal_max = 10;
speed_addition= 1;
jump_height = 15;
stomp_tolerance = 5;
stomp_height = jump_height/1.5;
deathjump_height = jump_height * 1.5;
sound_toggle = true;

//Choisi la musique de fond en fonction de la pièce
switch(room)
{
	case room0 :
	theme = snd_Theme;
	break;
	
	case room1 :
	theme = snd_ThemeDark;
	break;
}

//Joue la musique de fond en boucle
audio_play_sound(theme,0,true);

