package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	static inline var ACCELERATION:Float = 1000;
	var gun:Gun;

	public function new(aGun:Gun, X:Float=0, Y:Float=0)
	{
		super(X, Y);

		makeGraphic(40, 40);
		maxVelocity.set(400, 400);
		drag.set(500, 500);
		gun = aGun;
	}

	override public function update(elapsed:Float)
	{
		acceleration.set(0,0);
		if (FlxG.keys.pressed.LEFT)
		{
			acceleration.x -= ACCELERATION;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			acceleration.x += ACCELERATION;
		}
		if (FlxG.keys.pressed.UP)
		{
			acceleration.y -= ACCELERATION;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			acceleration.y += ACCELERATION;
		}
		if (FlxG.mouse.justPressed || FlxG.keys.justPressed.SPACE)
		{
			gun.fire(x, y);
		}

		super.update(elapsed);
	}

}