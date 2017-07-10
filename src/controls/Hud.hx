package controls;
import controls.Timer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import utils.Utils;

class Hud extends FlxTypedGroup<FlxSprite>
{
	static inline var textSize:Int = 16;
	static inline var sidesMargin:Int = 16;
	static inline var txtKeysMarginTop:Int = 32;
	static inline var txtKeysMarginSide = 10;
	static inline var keyIconMarginTop = 13;
	static inline var topMargin:Int = 8;

	var txtKeysLeft:FlxText;
	var timer:Timer;
	var txtMaxWidth:Float = 0;
	var keyIcon: FlxSprite;

	public function new()
	{
		super();
		txtKeysLeft = new HudText();
		keyIcon = new FlxSprite();
		txtKeysLeft.size = textSize;
		keyIcon.scrollFactor.set();
		keyIcon.loadGraphic(AssetPaths.hud_key__png);
		keyIcon.setPosition(sidesMargin, keyIconMarginTop);
		txtKeysLeft.setPosition(txtKeysMarginTop, txtKeysMarginSide);

		timer = new Timer();
		timer.size = textSize;
		add(keyIcon);
		add(txtKeysLeft);
		add(timer);
	}

	public function setBestTime(bestTime:Float)
	{
		var txtBestTime = new TimerText(bestTime);
		txtBestTime.size = textSize;
		txtBestTime.setPosition(sidesMargin, topMargin);
		add(txtBestTime);
	}

	public function setKeysLeft(coinsLeft:Int)
	{
		txtKeysLeft.text = Std.string(coinsLeft);

	}
	public function startTimer(initialTime:Float)
	{
		timer.start(initialTime);
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

	public function isTimeOut():Bool
	{
		return timer.getTime() == 0;
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