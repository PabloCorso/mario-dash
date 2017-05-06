package controls;
import flixel.FlxG;
import states.GameState;

class MapButton extends MenuButton
{
	var mapNumber:Int;

	public function new(X:Float=0, Y:Float=0, MapNumber:Int)
	{
		mapNumber = MapNumber;
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
		return "Level " + mapNumber;
	}

	function onClick()
	{
		var mapId:String = getMapId();
		FlxG.switchState(new GameState(mapId));
	}

	function getMapId():String
	{
		switch (mapNumber)
		{
			case 1: { return AssetPaths.map_1__csv; }
			default: return "";
		}
	}

}