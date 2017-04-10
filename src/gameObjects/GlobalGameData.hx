package gameObjects;

typedef GGD = GlobalGameData;
class GlobalGameData
{
	public static var player:Player;

	public function new() 
	{
		
	}
	
	public static function clear():Void
	{
		player = null;
	}
}