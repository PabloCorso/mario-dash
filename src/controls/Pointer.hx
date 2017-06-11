package controls;
import flixel.FlxSprite;

class Pointer extends FlxSprite
{
	static private inline var rotate:String = "rotate";
	
	public function new()
	{
		super();
		
		scrollFactor.set();
		loadGraphic(AssetPaths.pointer_coin__png, true);
		animation.add(rotate, [0, 1, 2, 3], 5, true);
		animation.play(rotate);
	}
}