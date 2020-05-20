event_inherited();

//////MOUVEMENTS//////	

//Si le joueur n'est pas déjà mort
if(!dead)
{
	//Check les boutons de direction & saut qui sont actuellement pressés
	var key_right = (keyboard_check(vk_right) || keyboard_check(ord("D")));
	var key_left = -(keyboard_check(vk_left) || keyboard_check(ord("Q")));
	var key_jump = (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space));
	var key_down = (keyboard_check(vk_down) || keyboard_check(ord("S")))
	
	//Vérifie si le joueur est au sol
	var can_jump = place_meeting(x,y + 1,obj_Wall);

	//Etabli la direction en fonction des bouttons de direction pressés
	var direction_current = key_right + key_left;

	//Si le joueur a changé de direction, annuler l'inertie
	if(direction_current != sign(speed_horizontal)) speed_horizontal = 0;
	
	//Calcule la vitesse horizontale du joueur dans la limite maximum
	speed_horizontal = clamp(speed_horizontal + (direction_current * speed_addition),-speed_horizontal_max,speed_horizontal_max);
	
	//Vérifie si le joueur est au sol 
	if(can_jump)
	{
		//Calcule la vitesse verticale du joueur si il a appuyé sur le bouton de saut
		speed_vertical = key_jump * -jump_height;
		
		//Si le joueur a appuyé sur le bouton saut
		if(key_jump)
		{
			//Joue le son de saut
			audio_play_sound(snd_Jump,0,false);
		}
	}
	
	//Transmet les vitesses calculées à la fonction de mouvement avec collision
	var speed_vector = move_along_wall(speed_horizontal,speed_vertical);
	
	//Récupère les vitesses digérées par la fonction
	speed_vector[0] = speed_horizontal;
	speed_vector[1] = speed_vertical;
	
	///SPRITE
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
	
	/////MORT OU VICTOIRE/////
	//Si le joueur touche un ennemi
	if(place_meeting(x,y,obj_Enemy))
	{
		var touched_enemy = noone;
		
		//Execute le code suivant par tous les instances d'ennemis
		with(obj_Enemy)
		{
			//Si l'ennemi n'est pas mort ou en train de mourir
			if(!dead && !dying)
			{
				//Si l'ennemi touche le joueur
				if(place_meeting(x,y,obj_Player)) 
				{
					//Sauvegarde la référence de l'ennemi
					touched_enemy = id;
				}
			}
		}
		
		//Si le joueur a touché un ennemi validé
		if(touched_enemy != noone)
		{
			
			if(touched_enemy.y - stomp_tolerance> y + sprite_height/2)
			{
				touched_enemy.dying = true;
				touched_enemy.speed_vertical = -jump_height;
				speed_vertical = -jump_height/1.5;
				audio_play_sound(snd_EnemyDeath,0,false);
			}
			else
			{
				dying = true;
				audio_play_sound(snd_PlayerDeath,0,false);
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
		audio_play_sound(snd_Win,0,false);
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