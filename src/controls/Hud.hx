package controls;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Timer;
import utils.IntUtils;

class Hud extends FlxTypedGroup<FlxSprite>
{
	static inline var textSize:Int = 16;
	static inline var sidesMargin:Int = 16;
	static inline var topMargin:Int = 8;

	var txtTimer:FlxText;
	var timePassed:Float;
	var txtMaxWidth:Float = 0;

	public var isPaused:Bool;
	
	public function new()
	{
		super();

		txtTimer = new FlxText();
		txtTimer.scrollFactor.set();
		txtTimer.size = textSize;
		add(txtTimer);
	}

	public function setBestTime(bestTime:Float)
	{
		var txtBestTime = new FlxText();
		txtBestTime.scrollFactor.set();
		txtBestTime.size = textSize;
		txtBestTime.text = getTimeDisplay(bestTime);
		txtBestTime.setPosition(sidesMargin, topMargin);
		add(txtBestTime);
	}

	public function startTimer()
	{
		timePassed = 0;
	}

	override public function update(elapsed:Float):Void
	{
		if (!isPaused)
		{
			timePassed += elapsed;
			txtTimer.text = getTimeDisplay(timePassed);
			updateTimerPosition();
		}
		super.update(elapsed);
	}

	function updateTimerPosition()
	{
		if (txtMaxWidth < txtTimer.width)
		{
			txtMaxWidth =  txtTimer.width;
			txtTimer.setPosition(FlxG.width - txtTimer.width - sidesMargin, topMargin);
		}
	}

	function getTimeDisplay(time:Float)
	{
		var milliseconds = round(time * 1000, 0) % 1000;
		var seconds:Int = cast (time) % 60;
		var minutes:Int = cast ((time / (60)) % 60);
		var hours:Int   = cast ((time / (60*60)) % 24);

		var hoursText = hours == 0 ? "" : hours + ":";
		var minsText = hours == 0 && minutes == 0 ? "" : minutes + ":";
		var secsText = seconds < 10 ? "0" + seconds : "" + seconds;
		var milliText = milliseconds < 10 ? "0" + milliseconds : "" + milliseconds;

		return hoursText + minsText + secsText + ":" + milliText.substr(0, 2);
	}

	public static function round(number:Float, ?precision=2): Float
	{
		number *= Math.pow(10, precision);
		return Math.round(number) / Math.pow(10, precision);
	}
}