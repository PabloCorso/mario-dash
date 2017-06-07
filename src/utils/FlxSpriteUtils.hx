package utils;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxAxes;

class FlxSpriteUtils
{
	static public function relativeCenter(child:FlxSprite, parent:FlxSprite, ?axes:FlxAxes)
	{
		if (axes == null)
			axes = FlxAxes.XY;

		if (axes != FlxAxes.Y)
			child.x = parent.x + (parent.width / 2) - (child.width / 2);
		if (axes != FlxAxes.X)
			child.y = parent.y + (parent.height / 2) - (child.height / 2);
	}
}