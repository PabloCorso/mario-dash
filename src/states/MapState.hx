package states;
import controls.OptionList;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class MapState  extends FlxState
{
	var mapId:String;
	var menu:OptionList;

	public function new(mapId:String)
	{
		super();
		this.mapId = mapId;

		drawMenu();
	}

	function drawMenu()
	{
		var options = new Array<FlxSprite>();
		var textSize = 16;

		var playAgainOption = new FlxText();
		playAgainOption.text = "Play Again";
		playAgainOption.size = textSize;
		options.push(playAgainOption);

		var replayOption = new FlxText();
		replayOption.text = "Replay";
		replayOption.size = textSize;
		options.push(replayOption);

		var bestTimesOption = new FlxText();
		bestTimesOption.text = "Best Times";
		bestTimesOption.size = textSize;
		options.push(bestTimesOption);

		menu = new OptionList(0, FlxG.height*0.3, FlxG.width, FlxG.height*0.5);
		menu.screenCenter(FlxAxes.X);
		menu.setOptions(options, optionSelected);
		add(menu);
	}

	function optionSelected(option:FlxSprite):Void
	{
		FlxG.switchState(new GameState(mapId));
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