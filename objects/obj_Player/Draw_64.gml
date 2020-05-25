draw_set_font(font0);
draw_set_color(c_black)
if(audio_get_master_gain(0))
{
	draw_text(20,20,"Appuyez sur M pour faire cesser cette horrible musique");
}
else
{
	draw_text(20,20,"Appuyez sur M pour entendre cette délicieuse mélopée");
}