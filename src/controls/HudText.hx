package controls;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HudText extends FlxText
{
	public function new()
	{
		super();

		scrollFactor.set();
		borderSize = 1;
		borderColor = FlxColor.BLACK;
		borderStyle = FlxTextBorderStyle.OUTLINE;
	}
}