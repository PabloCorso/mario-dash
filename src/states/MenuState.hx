package states ;
import controls.menu.MenuList;
import controls.MapOption;
import flixel.FlxG;
import flixel.FlxSprite;
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
	static inline var textSize:Int = 16;

	var title:FlxText;
	var menu:MenuList;

	public function new()
	{
		super();
		FlxG.mouse.visible = false;
	}

	override public function create():Void
	{
		title = new FlxText(0, 0, 0, "Mario Dash", 25);
		title.screenCenter(FlxAxes.X);
		title.y = 15;
		title.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(title);

		addMapButtons();
		super.create();
	}

	function addMapButtons()
	{
		var mapsFile = Assets.getText(MapDataConfig.mapsFilePath);
		var maps:Array<MapData> = Json.parse(mapsFile);

		var options = new Array<FlxSprite>();
		for (mapData in maps)
		{
			var option = new MapOption(mapData);
			option.size = textSize;
			options.push(option);
		}

		var titleYSpace = title.y + title.height + 15;
		menu = new MenuList(0, titleYSpace, FlxG.width, FlxG.height - titleYSpace);
		menu.screenCenter(FlxAxes.X);
		menu.setOptions(options, optionSelected);
		add(menu);
	}

	function optionSelected(option:FlxSprite):Void
	{
		var mapOption:MapOption = cast option;
		var mapData = mapOption.getMapData();
		FlxG.switchState(new GameState(mapData));
	}
}