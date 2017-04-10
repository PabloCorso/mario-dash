package gameObjects;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Wall extends FlxSprite
{
 
	public function new(aX:Float, aY:Float, aWidth:Int, aHeight:Int ) 
	{
		super(aX, aY);
		makeGraphic(aWidth, aHeight, FlxColor.BLUE);
		immovable = true;
	}
	
}