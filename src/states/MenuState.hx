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

	var title:FlxText;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		title = new FlxText(0, 0, 0, "Mario Dash", 25);
		title.screenCenter(FlxAxes.X);
		title.y = 20;
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
			list.y = title.y + title.health + 70;
			list.height = FlxG.height - list.y - 40;
			add(list);
		}
	}
}