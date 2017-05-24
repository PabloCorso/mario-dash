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
		maxVelocity.x = 150;
		acceleration.y = 750;
	}

	function initializeGraphics()
	{
		loadGraphic(AssetPaths.hero__png, true, 45, 60);
		loadAnimations();
		flipX = true;
		offset.y = 20;
		setSize(40, 41);
	}

	function loadAnimations()
	{
		animation.add(run, [2, 3, 4, 5, 6, 7, 8, 9], 30);
		animation.add(stand, [10]);
		animation.add(jump, [1]);
		animation.add(fall, [0]);
		animation.play(stand);
	}

	private static inline var ACCELERATION:Float = 1000;
	private static inline var velocityY:Int = -200;
	private static inline var maxJump:Float = 500;
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
		acceleration.x = ACCELERATION;
		if (isStartingJump())
		{
			isJumping = true;
			velocity.y = velocityY;
		}

		if (isJumping && pressedJumpKey() && jumpCounter < maxJump)
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

	function pressedJumpKey()
	{
		return FlxG.keys.pressed.SPACE;
	}

	function isStartingJump()
	{
		return isTouching(FlxObject.FLOOR) && pressedJumpKey();
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