package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Key extends FlxSprite
{
	private static inline var killKey:String = "killKey";

	public function new(X:Float=0, Y:Float=0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.key__png, true, 16, 16);
		setSize(13, 16);
		loadAnimations();
	}

	public function take()
	{
		animation.play(killKey);
		FlxG.sound.play(AssetPaths.coin__wav);
		kill();
	}

	function loadAnimations()
	{
		animation.add(killKey, [0, 1], 5);

	}
}