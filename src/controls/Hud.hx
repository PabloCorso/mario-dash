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
	var timePassed:Int;

	public function new()
	{
		super();

		txtTimer = new FlxText();
		txtTimer.size = textSize;
		txtTimer.text = "00:00:00";
		txtTimer.setPosition(FlxG.width - txtTimer.width/2 - sidesMargin, topMargin);
		add(txtTimer);

		setHudElementsFixedBehaviour();
	}

	function setHudElementsFixedBehaviour()
	{
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}

	public function resetTimer()
	{
		timePassed = 0;
	}

	override public function update(elapsed:Float):Void
	{
		timePassed += cast elapsed * 100000;
		updateTimerText();
		super.update(elapsed);
	}

	function updateTimerText()
	{
		var seconds:Int = cast (timePassed / 1000) % 60;
		var minutes:Int = cast ((timePassed / (1000*60)) % 60);
		var hours:Int   = cast ((timePassed / (1000*60*60)) % 24);

		var hoursText = hours == 0 ? "" : hours + ":";
		var minsText = hours > 0 && minutes < 10 ? "0" + minutes : "" + minutes;
		var secsText = seconds < 10 ? "0" + seconds : "" + seconds;

		txtTimer.text = hoursText + minsText + ":" + secsText;
	}
}