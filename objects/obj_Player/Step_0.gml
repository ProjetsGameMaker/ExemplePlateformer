//Récupère le code de l'objet parent (obj_ParentLiving)
event_inherited();

//////MOUVEMENTS//////	
//Si le joueur n'est pas victorieux
if(!haswon)
{
	//Si le joueur n'est pas déjà mort ou 
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
			//Prépare une variable locale pour recevoir l'id de l'instance touchée et validé, qui vaudra noone si aucune instance valide n'est trouvée
			var touched_enemy = noone;
		
			//Execute le code suivant par tous les instances d'ennemis
			with(obj_Enemy)
			{
				//Si l'instance d'ennemi est valide (pas mort ou en train de mourir)
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
				//Si le joueur se situe en haut de l'ennemi
				if(touched_enemy.y - stomp_tolerance> y + sprite_height/2)
				{
					//Marque l'ennemi comme en train de mourir
					touched_enemy.dying = true;
				
					//Accélère l'ennemi verticalement
					touched_enemy.speed_vertical = -jump_height;
				
					//Fait rebondir le joueur
					speed_vertical = -stomp_height;
				
					//Joue le son de mort d'ennemi une fois
					audio_play_sound(snd_EnemyDeath,0,false);
				}
				//Sinon
				else
				{
					//Marque le joueur comme mourant
					dying = true;
				
				}
			}
		}
		//Si le joueur rentre en collision avec un carré danger
		if(place_meeting(x,y,obj_Danger))
		{
			//Stoppe le joueur
			speed_horizontal = 0;
		
			//Marque le comme mourrant
			dying = true;
		}
		//Sinon si le joueur rentre en collision avec un carré trigger
		else if(place_meeting(x,y,obj_Trigger))
		{
			//Joue le son de victoire une fois
			audio_play_sound(snd_Win,0,false);
		
			//Programme l'évenement alarme 1 quand le son de victoire sera terminé
			alarm[1] = audio_sound_length(snd_Win) * room_speed;
		
			//Marque le joueur comme victorieux
			haswon = true;
		}
	}
	//Sinon (Si le joueur est mort)
	else
	{
		//Si le joueur a atteint le bas de la pièce
		if(y - sprite_height > room_height)
		{
			//Redémarrez la pièce
			room_restart();
		}
		//Sinon
		else
		{
			//Faites le bouger vers le bas
			y+=speed_vertical;
		}
	}

	//Si le joueur est mourant
	if(dying)
	{
		//Jouer le son de mort une fois
		audio_play_sound(snd_PlayerDeath,0,false);
		//Marquer le joueur comme mort et non plus mourant
		dead = true;
		dying = false;
	
		//Fait rebondir le joueur
		speed_vertical = -deathjump_height;
		
		//Affiche la pose de douleur
		sprite_index = spr_PlayerHurt;
	}
}