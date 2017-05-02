package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Player extends FlxSprite
{
	var mDust:FlxGroup;
	public function new(group:FlxGroup,X:Float=0, Y:Float=0)
	{
		lastSpawnDustX = X;
		super(X, Y);

		mDust = new FlxGroup();
		group.add(mDust);

		loadGraphic(AssetPaths.hero__png, true, 45, 60);

		animation.add("run", [2, 3, 4, 5, 6, 7, 8, 9], 30);
		animation.add("stand", [10]);
		animation.add("jump", [1]);
		animation.add("fall", [0]);
		animation.add("wallHang",[11]);
		animation.play("stand");
		
		offset.y = 20;
		width = 40;
		height = 41;
		maxVelocity.x = 200;

		acceleration.y = 1000;
	}

	var ACCELERATION:Float = 1000;
	var lastSpawnDustX:Float = 0;
	static private inline var MIN_DISTANCE_SPAWN_DUST:Float = 15;
	override public function update(elapsed:Float)
	{
		acceleration.x = ACCELERATION;
		if (FlxG.keys.pressed.SPACE )
		{
			if (isTouching(FlxObject.FLOOR))
			{
				velocity.y = -400;
			}
		}
		if (needToSpawnDust())
		{
			lastSpawnDustX = x;
			var dust:Dust = cast mDust.recycle(Dust);
			if (velocity.x>0)
			{
				dust.reset(x, y+height);
			}
			else
			{
				dust.reset(x+width, y+height);
			}
		}

		updateAnimation(elapsed);
		super.update(elapsed);
	}

	inline function needToSpawnDust():Bool
	{
		return isTouching(FlxObject.FLOOR) && Math.abs(x - lastSpawnDustX) > MIN_DISTANCE_SPAWN_DUST;
	}

	override function updateAnimation(elapsed:Float)
	{
		if (velocity.x > 0)
		{
			flipX = true;
		}
		else if (velocity.x < 0)
		{
			flipX = false;
		}

		if (!isTouching(FlxObject.FLOOR))
		{
			if (isTouching(FlxObject.WALL))
			{
				animation.play("wallHang");
				flipX = isTouching(FlxObject.LEFT);
			}
			else if (velocity.y > 0)
			{
				animation.play("fall");
			}
			else
			{
				animation.play("jump");
			}
		}
		else
		{
			if (velocity.x != 0)
			{
				animation.play("run");
			}
			else
			{
				animation.play("stand");
			}
		}

		super.updateAnimation(elapsed);
	}
}