package gameObjects;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Coin extends FlxSprite
{
	private static inline var rotate:String = "rotate";
	
	public function new(X:Float=0, Y:Float=0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.coin__png, true, 16, 16);
		setSize(13, 16);
		loadAnimations();
	}

	function loadAnimations()
	{
		animation.add(rotate, [0, 1, 2, 3], 5);
		animation.play(rotate);
	}
}