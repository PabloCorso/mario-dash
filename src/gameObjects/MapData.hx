package gameObjects;

typedef MapData =
{
	var id:Int;
	var title:String;
	var path:String;
	var time:Float;
	var enemyCollisions:String;
}

class MapDataConfig
{
	public static inline var mapsFilePath:String = "assets/maps/maps.json";

	static public function getPath(mapData:MapData)
	{
		return "assets/maps/" + mapData.path + ".csv";
	}
	
		static public function getPathEnemies(mapData:MapData)
	{
		if (mapData.enemyCollisions == "")
			return "";
		return "assets/maps/" + mapData.enemyCollisions + ".csv";
	}
}