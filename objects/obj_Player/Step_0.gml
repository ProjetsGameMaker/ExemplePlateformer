event_inherited();

//////MOUVEMENTS//////	
if(!dead)
{
	//Ajoute de la vitesse dans direction appropriée en fonction du bouton pressé
	var key_right = (keyboard_check(vk_right) || keyboard_check(ord("D")));
	var key_left = -(keyboard_check(vk_left) || keyboard_check(ord("Q")));
	var key_jump = (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space));
	var key_down = (keyboard_check(vk_down) || keyboard_check(ord("S")))
	
	var can_jump = place_meeting(x,y + 1,obj_Wall);

	//Etabli la direction en fonction des bouttons pressé
	var direction_current = key_right + key_left;
	if(direction_current != 0) direction_saved = direction_current;

	if(direction_current != sign(speed_horizontal)) speed_horizontal = 0;
	
	//Accélère horizontalement dans la limite maximum de vitesse
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
	var speed_vector = move_along_wall(speed_horizontal,speed_vertical);
	speed_vector[0] = speed_horizontal;
	speed_vector[1] = speed_vertical;
	
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
	
	/////MORT/////
	if(place_meeting(x,y,obj_Enemy))
	{
		var touched_enemy = noone;
		with(obj_Enemy)
		{
			if(!dead && !dying)
			{
				if(place_meeting(x,y,obj_Player)) 
				{
					var touched_enemy = id;
				}
			}
		}
		if(touched_enemy != noone)
		{
			if(touched_enemy.y - stomp_tolerance> y + sprite_height/2)
			{
				touched_enemy.dying = true;
				touched_enemy.speed_vertical = -jump_height;
				speed_vertical = -jump_height/1.5;
			}
			else
			{
				dying = true;
			}
		}
	}
	if(place_meeting(x,y,obj_Danger))
	{
		speed_horizontal = 0;
		dying = true;
	}
	else if(place_meeting(x,y,obj_Trigger))
	{
		if(room == room_last) 
		{
			game_end();
		}
		else 
		{
			room_goto_next();
		}
	}
}
else
{
	if(y - sprite_height > room_height)
	{
		room_restart();
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
	speed_vertical = -jump_height * 1.5;
	sprite_index = spr_PlayerHurt;
}