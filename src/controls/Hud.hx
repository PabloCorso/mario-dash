package controls;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import utils.IntUtils;

class Hud extends FlxTypedGroup<FlxSprite>
{
	static inline var triesNumberSize:Int = 16;

	var tries:Int;
	var txtTries:FlxText;
	var triesBackground:FlxSprite;

	public function new()
	{
		super();

		triesBackground = new FlxSprite();
		triesBackground.setPosition(16 - 4, 8);
		drawTriesBackground();
		add(triesBackground);

		tries = 0;
		txtTries = new FlxText(16, 8, 0, getTriesText(), triesNumberSize);
		txtTries.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(txtTries);

		setHudElementsFixedBehaviour();
	}

	function drawTriesBackground()
	{
		var length = IntUtils.GetNumberLength(tries);
		var txtTriesNumbersWidth = triesNumberSize * length;
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
}