package controls;
import controls.Timer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import utils.IntUtils;

class Hud extends FlxTypedGroup<FlxSprite>
{
	static inline var textSize:Int = 16;
	static inline var sidesMargin:Int = 16;
	static inline var topMargin:Int = 8;

	var timer:Timer;
	var txtMaxWidth:Float = 0;

	public function new()
	{
		super();

		timer = new Timer();
		timer.size = textSize;
		add(timer);
	}

	public function setBestTime(bestTime:Float)
	{
		var txtBestTime = new TimerText(bestTime);
		txtBestTime.size = textSize;
		txtBestTime.setPosition(sidesMargin, topMargin);
		add(txtBestTime);
	}

	public function startTimer()
	{
		timer.start();
	}

	public function togglePause(pause:Bool)
	{
		timer.isPaused  = pause;
	}

	override public function update(elapsed:Float):Void
	{
		if (!timer.isPaused)
		{
			updateTimerPosition();
		}

		super.update(elapsed);
	}

	function updateTimerPosition()
	{
		if (txtMaxWidth < timer.width)
		{
			txtMaxWidth =  timer.width;
			timer.setPosition(FlxG.width - timer.width - sidesMargin, topMargin);
		}
	}
}