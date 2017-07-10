package states;
import controls.TimerText;
import controls.menu.MenuList;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import gameObjects.MapData;
import helpers.Storage;
import utils.Utils;

class BestTimesState extends FlxState
{
	static inline var noBestTimesYet = "No best times yet!";
	static inline var textSize = 16;

	var mapData:MapData;
	var seconds:Float;
	var finished:Bool;
	var topTimes:Array<Float>;
	public function new(mapData:MapData, finished:Bool, seconds:Float)
	{
		super();

		this.mapData = mapData;
		this.seconds = seconds;
		this.finished = finished;
	}

	override public function create():Void
	{
		super.create();
		topTimes = Storage.getTopTimes(this.mapData.id);
		if (topTimes != null && topTimes.length > 0)
		{
			drawBestTimes();
		}
		else
		{
			drawNoBestTimesYet();
		}
	}

	function drawNoBestTimesYet()
	{
		var txtNoBestTimesYet = new FlxText();
		txtNoBestTimesYet.size = textSize;
		txtNoBestTimesYet.text = noBestTimesYet;
		txtNoBestTimesYet.screenCenter();
		add(txtNoBestTimesYet);
	}

	function drawBestTimes()
	{
		var options = new Array<FlxSprite>();
		var count = 1;
		for (time in this.topTimes)
		{
			var finishTime = getFinishTime(time);
			var option = new TimerText(finishTime);
			option.size = textSize;

			option.setPrefix(count++ + ". ");
			option.setSecondaryTime(time);
			options.push(option);
		}

		var menu = new MenuList(0, FlxG.height*0.1, FlxG.width, FlxG.height*0.8);
		menu.screenCenter(FlxAxes.X);
		menu.setOptions(options, null);
		add(menu);
	}

	function getFinishTime(time:Float)
	{
		return Utils.round(mapData.time - time);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MapState(mapData, finished, seconds));
		}
	}
}