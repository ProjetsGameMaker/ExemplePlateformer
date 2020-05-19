//Applique la gravité
if (speed_vertical < speed_vertical_max) 
{
	speed_vertical += jump_gravity;
}

//////MOUVEMENTS//////	
if(!dead)
{
	
	//Ajoute de la vitesse dans direction appropriée en fonction du bouton pressé
	var key_right = (keyboard_check(vk_right) || keyboard_check(ord("D")));
	var key_left = -(keyboard_check(vk_left) || keyboard_check(ord("Q")));
	var key_jump = (keyboard_check(vk_up) || keyboard_check(vk_space));
	var key_down = (keyboard_check(vk_down) || keyboard_check(ord("S")))
	
	var can_jump = place_meeting(x,y + 1,obj_Wall);

	//Etabli la direction en fonction des bouttons pressé
	var direction_current = key_right + key_left;
	if(direction_current != 0) direction_saved = direction_current;

	if(direction_current != sign(speed_horizontal)) speed_horizontal = 0;
	//Bouge le joueur horizontalement dans la limite maximum de vitesse
	speed_horizontal = clamp(speed_horizontal + (direction_current * speed_addition),-speed_horizontal_max,speed_horizontal_max);
	
	//Ralenti le joueur si rien n'est pressé et qu'il n'est pas à l'arrêt
	if(direction_current == 0) 
	{
		speed_horizontal-= speed_decay * sign(speed_horizontal);
		if(speed_horizontal < speed_decay && speed_horizontal > -speed_decay) speed_horizontal = 0;
	}
	
	//Vérifie si le joueur est au sol et le bouge verticalement s'il appuie sur saut
	if(can_jump)
	{
		speed_vertical = key_jump * -jump_height;
	}
	
	//////COLLISIONS///////
	//Vérifie s'il y a collision avec un mur horizontalement et avance le joueur au maximum
	if(place_meeting(x + speed_horizontal,y - 5,obj_Wall))
	{
		while(!place_meeting(x + sign(speed_horizontal),y - 5,obj_Wall))
		{
			x+= sign(speed_horizontal);
		}
		speed_horizontal = 0;
	}
	x+= speed_horizontal;

	//Vérifie s'il y a collision avec un sol verticalement et avance le joueur au maximum
	if(place_meeting(x,y + speed_vertical,obj_Wall))
	{
		while(!place_meeting(x,y + sign(speed_vertical),obj_Wall)) 
		{
			y+= sign(speed_vertical);
		}
		speed_vertical = 0;
	}
	y+= speed_vertical;
	
	//Choisi le sprite approprié en fonction du mouvement
	if(!can_jump)
	{
		image_index = 0;
		sprite_index = spr_PlayerJump;
	}
	else if(direction_current != 0) 
	{
		sprite_index = spr_PlayerWalk;
	}
	else
	{
		image_index = 0;
		if(key_down)
		{
			sprite_index = spr_PlayerDown;
		}
		else
		{
			sprite_index = spr_PlayerIdle;
		}
	}
	image_xscale = direction_saved;
	image_speed = speed_horizontal/10;
	
	/////MORT/////
	if(place_meeting(x,y,obj_Danger))
	{
		speed_horizontal = 0;
		dead = true;
		speed_vertical = -jump_height * 1.5;
		sprite_index = spr_PlayerHurt;
		alarm[0] = room_speed * 1;
	}
	else if(place_meeting(x,y,obj_Trigger))
	{
		game_end();
	}
}
else
{
	y+=speed_vertical;
}
