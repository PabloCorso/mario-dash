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

	var tries:Int;
	var txtTries:FlxText;
	var triesBackground:FlxSprite;

	var txtTimer:FlxText;
	var timePassed:Int;

	public function new()
	{
		super();

		triesBackground = new FlxSprite();
		triesBackground.setPosition(sidesMargin - 4, topMargin);
		drawTriesBackground();
		add(triesBackground);

		tries = 0;
		txtTries = new FlxText(sidesMargin, topMargin, 0, getTriesText(), textSize);
		txtTries.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(txtTries);

		txtTimer = new FlxText();
		txtTimer.size = textSize;
		txtTimer.text = "00:00:00";
		txtTimer.setPosition(FlxG.width - txtTimer.width - sidesMargin, topMargin);
		add(txtTimer);

		setHudElementsFixedBehaviour();
	}

	function drawTriesBackground()
	{
		var length = IntUtils.getNumberLength(tries);
		var txtTriesNumbersWidth = textSize * length;
		var txtTriesWidth = txtTriesNumbersWidth + 8 - length * 4;
		triesBackground.makeGraphic(txtTriesWidth, 22, FlxColor.BLACK);
	}

	function setHudElementsFixedBehaviour()
	{
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}

	function getTriesText()
	{
		return "" + tries;
	}

	public function addTry()
	{
		tries += 1;
		txtTries.text = getTriesText();
		drawTriesBackground();
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