package states ;
import controls.MapButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
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

		displayMapButtons(maps);
	}
	
	function displayMapButtons(maps:Array<MapData>) 
	{
		var i:Int;
		if (maps.length > 0)
		{
			var mult = FlxG.height / maps.length;
			for (i in 0...maps.length)
			{
				var btn = new MapButton(0, 0, maps[i]);
				btn.screenCenter(FlxAxes.X);
				btn.y += (i + 1 )* 50;
				add(btn);
			}
		}
	}
}