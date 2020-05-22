event_inherited();

if(!dead)
{
	//Si l'ennemi entre en collision avec le mur
	if(position_meeting(x+ sprite_width/2 + sign(speed_horizontal),y,obj_Wall))
	{
		//Inverser sa direction
		speed_horizontal = -speed_horizontal;
	}
	//Sinon si il entre en collision avec un bloc danger
	else if(place_meeting(x,y,obj_Danger))
	{
		dying = true;
	}
	move_along_wall(speed_horizontal,speed_vertical)
}
else
{
	if(y - sprite_height > room_height)
	{
		instance_destroy();
	}
	else
	{
		y+=speed_vertical;
	}
}
if(dying)
{
	dead = true;
	dying = false;
	sprite_index = spr_EnemyDead
}
