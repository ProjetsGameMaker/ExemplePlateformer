//DEPLACEMENTS
//Ajoute de la vitesse dans direction appropriée en fonction du bouton pressé
var key_right = (keyboard_check(vk_right) || keyboard_check(ord("D")));
var key_left = -(keyboard_check(vk_left) || keyboard_check(ord("Q")));
var key_jump = (keyboard_check(vk_up) || keyboard_check(vk_space));

//Etabli la direction en fonction des bouttons pressé
speeddir = key_right + key_left;

//Bouge le joueur horizontalement dans la limite maximum de vitesse
speedhor = clamp(speedhor + (speeddir * speedadd),-speedmax,speedmax);

if (speedver < 10) 
{
	speedver += grav;
}
//Vérifie si le joueur est au sol et le bouge verticalement si c'est le cas
if(place_meeting(x,y+1,obj_ParentCollision))
{
	speedver = key_jump * -speedjump;
}

//Vérifie s'il y a collision avec un mur horizontalement et avance le joueur au maximum
if(place_meeting(x+speedhor,y,obj_ParentCollision))
{
	while(!place_meeting(x + sign(speedhor),y,obj_ParentCollision)) x+= sign(speedhor);
	speedhor = 0;
}
x+= speedhor;

//Vérifie s'il y a collision avec un mur verticalement et avance le joueur au maximum
if(place_meeting(x+speedhor,y + speedver,obj_ParentCollision))
{
	while(!place_meeting(x,y + sign(speedver),obj_ParentCollision)) y+= sign(speedver);
	speedver = 0;
}
y+= speedver;


//Ralenti le joueur si rien n'est pressé et qu'il n'est pas à l'arrêt
if(speeddir == 0) 
{
	speedhor-= speeddecay * sign(speedhor);
	if(speedhor < speeddecay && speedhor > -speeddecay) speedhor = 0;
}

if(speedhor != 0) 
{
	sprite_index = spr_PlayerWalk;
	image_xscale = sign(speedhor);
}
else 
{
	image_index = 0;
	sprite_index = spr_PlayerIdle;
}

image_speed = speedhor/10;

//if(keyboard_check_pressed(vk_space))