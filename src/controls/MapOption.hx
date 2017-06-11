package controls;
import flixel.text.FlxText;
import gameObjects.MapData;

class MapOption extends FlxText
{
	var mapData:MapData;

	public function new(mapData:MapData)
	{
		super();

		this.mapData = mapData;
		text = getMapText();
	}

	function getMapText()
	{
		return mapData.id + " - " + mapData.title;
	}

	public function getMapData():MapData
	{
		return mapData;
	}
}
