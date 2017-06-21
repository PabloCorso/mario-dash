package gameObjects;

typedef MapData =
{
	var id:Int;
	var title:String;
	var path:String;
	var time:Float;
}

class MapDataConfig
{
	public static inline var mapsFilePath:String = "assets/maps/maps.json";

	static public function getPath(mapData:MapData)
	{
		return "assets/maps/" + mapData.path + ".csv";
	}
}