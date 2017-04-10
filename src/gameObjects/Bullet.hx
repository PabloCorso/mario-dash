package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Bullet extends FlxSprite
{

	static inline var SPEED:Float = 800;
	var lifeTime:Float = 0;

	public function new()
	{
		super(0, 0);
		makeGraphic(10, 10, FlxColor.RED);
	}

	public function shoot(aX:Float, aY:Float, aDirX:Float, aDirY:Float)
	{
		reset(aX, aY);
		velocity.set(SPEED * aDirX, SPEED * aDirY);
		lifeTime = 3;
	}

	override public function update(elapsed:Float)
	{
		lifeTime -= elapsed;
		if (lifeTime <= 0)
		{
			kill();
		}
		
		super.update(elapsed);
	}

}