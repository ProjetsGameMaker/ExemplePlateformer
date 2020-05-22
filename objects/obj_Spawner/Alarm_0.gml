//Crée une instance d'ennemi à la position du spawner, sur le calque "Instances"
var instance = instance_create_layer(x,y,"Instances",obj_Enemy);

//
instance.speed_horizontal = -instance.speed_horizontal;

//Redémarre le timer pour lancer cet évenement
alarm[0] = spawnspeed * room_speed;
