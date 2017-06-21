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
	static inline var txtCoinsMarginTop:Int = 30;
	static inline var txtCoinsMarginSide = 10;
	static inline var coinIconMarginTop = 13;
	static inline var topMargin:Int = 8;

	var txtCoinsLeft:FlxText;
	var timer:Timer;
	var txtMaxWidth:Float = 0;
	var coinIcon: FlxSprite;

	public function new()
	{
		super();
		txtCoinsLeft = new HudText();
		coinIcon = new FlxSprite();
		txtCoinsLeft.size = textSize;
		coinIcon.scrollFactor.set();
		coinIcon.loadGraphic(AssetPaths.hud_coin__png);
		coinIcon.setPosition(sidesMargin, coinIconMarginTop);
		txtCoinsLeft.setPosition(txtCoinsMarginTop, txtCoinsMarginSide);

		timer = new Timer();
		timer.size = textSize;
		add(coinIcon);
		add(txtCoinsLeft);
		add(timer);
	}

	public function setBestTime(bestTime:Float)
	{
		var txtBestTime = new TimerText(bestTime);
		txtBestTime.size = textSize;
		txtBestTime.setPosition(sidesMargin, topMargin);
		add(txtBestTime);
	}

	public function setCoinsLeft(coinsLeft:Int)
	{
		txtCoinsLeft.text = Std.string(coinsLeft);

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

	public function getSeconds()
	{
		return timer.getTime();
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