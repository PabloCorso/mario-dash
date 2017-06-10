package controls.menu;
import flixel.FlxG;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import gameObjects.MapData;
import states.GameState;

class MapButton extends MenuButton implements IFlxUIWidget
{
	var map:MapData;
	public var name:String = "";
	public var broadcastToFlxUI:Bool = false;

	public function new(Width:Int=100, Height:Int=28, mapData:MapData)
	{
		map = mapData;
		super(0, 0, getMapText(), onClick);

		setControlProperties(Width, Height);
	}

	function setControlProperties(Width:Int=100, Height:Int=28)
	{
		setGraphicSize(Width, Height);
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