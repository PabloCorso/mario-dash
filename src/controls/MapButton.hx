package controls;
import flixel.FlxG;
import gameObjects.MapData;
import states.GameState;

class MapButton extends MenuButton
{
	var map:MapData;

	public function new(X:Float=0, Y:Float=0, mapData:MapData)
	{
		map = mapData;
		super(X, Y, getMapText(), onClick);

		setControlProperties();
	}

	function setControlProperties()
	{
		setGraphicSize(100, 28);
		setSize(100, 28);
	}

	function getMapText()
	{
		return map.id + " - " + map.title;
	}

	function onClick()
	{
		var mapId:String = getMapId();
		FlxG.switchState(new GameState(mapId));
	}

	function getMapId():String
	{
		return "assets/maps/" + map.path + ".csv";
	}
}