event_inherited();

if(!dead)
{
	if(position_meeting(x+ sprite_width/2 + sign(speed_horizontal),y,obj_Wall))
	{
		speed_horizontal = -speed_horizontal;
	}
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
