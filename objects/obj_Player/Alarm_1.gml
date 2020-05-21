//Si la pièce actuelle est la dernière dans la liste
if(room == room_last) 
{
	//Quitte le jeu
	game_end();
}
//Sinon
else 
{
	//Passe à la pièce suivante
	room_goto_next();
}

