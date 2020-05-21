var instance = instance_create_layer(x,y,"Instances",obj_Enemy);
instance.speed_horizontal = -instance.speed_horizontal;

alarm[0] = spawnspeed * room_speed;
