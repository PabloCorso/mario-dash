package controls;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Hud extends FlxTypedGroup<FlxSprite>
{
	var txtTries:FlxText;
	var tries:Int;
	var sprBack:FlxSprite;

	public function new()
	{
		super();

		tries = 0;
		txtTries = new FlxText(16, 16, 0, getTriesText(), 16);
		txtTries.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(txtTries);

		setHudElementsFixedBehaviour();
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
	}
}