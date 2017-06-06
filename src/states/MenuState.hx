package states ;
import controls.menu.MapButton;
import controls.menu.MenuList;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
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
		var title = new FlxText(0, 0, 0, "Mario Dash", 50);
		title.screenCenter(FlxAxes.X);
		title.y = 40;
		title.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(title);

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
		if (maps.length > 0)
		{
			var list = new MenuList(maps);
			list.screenCenter(FlxAxes.X);
			list.y = 140;
			list.height = 220;
			add(list);
		}
	}
}