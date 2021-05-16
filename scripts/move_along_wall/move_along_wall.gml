///@description move_along_wall()
///@param speed_h horizontal speed
///@param speed_v vertical speed
function move_along_wall(speed_h, speed_v) 
{

	//////COLLISIONS///////
	//Vérifie s'il y a collision avec un mur horizontalement et avance le joueur au maximum
	if(place_meeting(x + speed_h,y -1,obj_Wall))
	{
		while(!place_meeting(x + sign(speed_h)* 2,y-1,obj_Wall))
		{
			x+= sign(speed_h);
		}
		speed_h = 0;
	}
	x+= speed_h;

	//Vérifie s'il y a collision avec un sol verticalement et avance le joueur au maximum
	if(place_meeting(x,y + speed_v,obj_Wall))
	{
		while(!place_meeting(x,y + sign(speed_v),obj_Wall)) 
		{
			y+= sign(speed_v);
		}
		speed_v = 0;
	}
	y+= speed_v;

	var array;
	array[0] = speed_h;
	array[1] = speed_v;
	return array;


}
