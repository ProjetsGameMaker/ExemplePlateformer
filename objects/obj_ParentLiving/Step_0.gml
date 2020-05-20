//Applique la gravité
if (speed_vertical < speed_vertical_max) 
{
	speed_vertical += gravity_;
}

if(sign(speed_horizontal) != 0) image_xscale = sign(speed_horizontal);
image_speed = speed_horizontal/10;