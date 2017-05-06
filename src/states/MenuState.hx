package states ;
import controls.MapButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import gameObjects.MapData;
import haxe.Json;
import openfl.Assets;

class MenuState extends FlxState
{
	static inline var mapsFilePath:String = "assets/maps/maps.json";

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		addMapButtons();
		super.create();
	}

	function addMapButtons()
	{
		var mapsFile = Assets.getText(mapsFilePath);
		var maps:Array<MapData> = Json.parse(mapsFile);

		var i:Int;
		for (i in 0...maps.length)
		{
			var btn = new MapButton(0, 0, maps[i]);
			btn.screenCenter();

			add(btn);
		}
	}

}