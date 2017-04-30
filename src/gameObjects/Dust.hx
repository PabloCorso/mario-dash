package gameObjects;
import flixel.FlxSprite;

class Dust extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.dust__png, true, 32, 32);
		animation.add("dust", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 15, false);
		offset.x = 12;
		offset.y = 32;
	}

	override public function update(elapsed:Float)
	{
		if (animation.finished)
		{
			kill();
		}
		super.update(elapsed);
	}

	override public function reset(X:Float, Y:Float)
	{
		super.reset(X, Y);
		animation.play("dust");
	}
}