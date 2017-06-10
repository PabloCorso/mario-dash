package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Player extends FlxSprite
{
	private static inline var run:String = "run";
	private static inline var stand:String = "stand";
	private static inline var jump:String = "jump";
	private static inline var fall:String = "fall";

	public function new()
	{
		super();
		initializeGraphics();
		setPhysics();
	}

	function setPhysics()
	{
		drag.x = 500;
		maxVelocity.x = 75;
		acceleration.y = 200;
	}

	function initializeGraphics()
	{
		loadGraphic(AssetPaths.player__png, true, 16, 16);
		loadAnimations();
		flipX = true;
		setSize(16, 16);
	}

	function loadAnimations()
	{
		animation.add(run, [2, 3, 4, 5, 6, 7, 8, 9], 30);
		animation.add(stand, [10]);
		animation.add(jump, [1]);
		animation.add(fall, [0]);
		animation.play(stand);
	}

	private static inline var ACCELERATION:Float = 300;
	private static inline var velocityY:Int = -100;
	private static inline var maxJump:Float = 250;
	var isJumping:Bool;
	var jumpCounter: Float = 0;
	override public function update(elapsed:Float)
	{
		movement(elapsed);
		updateAnimation(elapsed);
		super.update(elapsed);
	}

	function movement(elapsed:Float)
	{
		acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT)
		{
			acceleration.x = -ACCELERATION;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			acceleration.x = ACCELERATION;
		}

		if (isStartingJump())
		{
			isJumping = true;
		}

		if (isJumping && isPressingJumpKey() && !reachedMaxJumpHeight())
		{
			jumpCounter += elapsed * 1000;
			velocity.y = velocityY;
		}
		else
		{
			isJumping = false;
			jumpCounter = 0;
		}
	}

	function reachedMaxJumpHeight()
	{
		return jumpCounter >= maxJump;
	}

	function isPressingJumpKey()
	{
		return FlxG.keys.pressed.SPACE || FlxG.keys.pressed.UP;
	}

	function isStartingJump()
	{
		return isTouching(FlxObject.FLOOR) && isPressingJumpKey();
	}

	override function updateAnimation(elapsed:Float)
	{
		if (!isTouching(FlxObject.FLOOR))
		{
			if (velocity.y > 0)
			{
				animation.play(fall);
			}
			else
			{
				animation.play(jump);
			}
		}
		else
		{
			if (velocity.x != 0)
			{
				animation.play(run);
			}
			else
			{
				animation.play(stand);
			}
		}

		super.updateAnimation(elapsed);
	}
}