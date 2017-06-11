package states;
import controls.menu.MenuList;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import gameObjects.MapData;

class MapState  extends FlxState
{
	static inline var playAgain = "Play again";
	static inline var replay = "Replay";
	static inline var bestTimes = "Best times";

	var mapData:MapData;
	var menu:MenuList;
	var txtHeader:FlxText;

	public function new(mapData:MapData)
	{
		super();
		this.mapData = mapData;

		drawHeader();
		drawMenu();
	}

	function drawHeader()
	{
		txtHeader = new FlxText();
		txtHeader.size = 18;
		txtHeader.text = "Level " + mapData.id + ": " + mapData.title;
		txtHeader.screenCenter(FlxAxes.X);
		txtHeader.y = 20;
		add(txtHeader);
	}

	function drawMenu()
	{
		var options = new Array<FlxSprite>();
		var textSize = 16;

		var playAgainOption = new FlxText();
		playAgainOption.text = playAgain;
		playAgainOption.size = textSize;
		options.push(playAgainOption);

		var replayOption = new FlxText();
		replayOption.text = replay;
		replayOption.size = textSize;
		options.push(replayOption);

		var bestTimesOption = new FlxText();
		bestTimesOption.text = bestTimes;
		bestTimesOption.size = textSize;
		options.push(bestTimesOption);

		menu = new MenuList(0, FlxG.height*0.3, FlxG.width, FlxG.height*0.5);
		menu.screenCenter(FlxAxes.X);
		menu.setOptions(options, optionSelected);
		add(menu);
	}

	function optionSelected(option:FlxSprite):Void
	{
		var txtOption:FlxText = cast option;
		switch (txtOption.text)
		{
			case playAgain:
				FlxG.switchState(new GameState(mapData));
				//case replay:
				//case bestTimes:
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}
}