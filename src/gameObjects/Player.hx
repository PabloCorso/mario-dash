package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
	static inline var run:String = "run";
	static inline var stand:String = "stand";
	static inline var jump:String = "jump";
	static inline var fall:String = "fall";

	static inline var ACCELERATION:Float = 300;
	static inline var velocityY:Int = -100;
	static inline var maxJump:Float = 250;

	var isJumping:Bool;
	var jumpCounter: Float = 0;
	var sndJump:FlxSound;
	var prevVelocity:Float;

	public function new()
	{
		super();
		initializeGraphics();
		setPhysics();
		sndJump = FlxG.sound.load(AssetPaths.jump__wav);
	}

	function setPhysics()
	{
		drag.x = 500;
		maxVelocity.x = 80;
		acceleration.y = 200;
	}

	function initializeGraphics()
	{
		loadGraphic(AssetPaths.player_new__png, true, 20, 22);
		loadAnimations();
		offset.y = 2;
		width = 14;
		height = 20;
	}

	function loadAnimations()
	{
		animation.add(run, [1, 2, 3], 5);
		animation.add(stand, [0]);
		animation.add(jump, [6]);
		animation.add(fall, [5]);
		animation.play(stand);
	}

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
			sndJump.play(true);
		}

		if (keepJumping())
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

	function keepJumping()
	{
		return isJumping
			   && isPressingJumpKey()
			   && !reachedMaxJumpHeight()
			   && !isTouching(FlxObject.CEILING);
	}

	function reachedMaxJumpHeight()
	{
		return jumpCounter >= maxJump;
	}

	function isStartingJump()
	{
		return isTouching(FlxObject.FLOOR) && isPressingJumpKey();
	}

	function isPressingJumpKey()
	{
		return FlxG.keys.pressed.SPACE || FlxG.keys.pressed.UP;
	}

	override function updateAnimation(elapsed:Float)
	{
		updateOrientation();

		// TODO: velocitiy keeps setting to 3.333 after stand animation,
		//       and the player looks like he is always falling.
		if (!isTouching(FlxObject.FLOOR) && Math.abs(velocity.y) > 4)
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

	function updateOrientation()
	{
		// TODO: fix is turning.
		if (velocity.x != 0)
		{
			var isTurningLeft = (velocity.x < prevVelocity && FlxG.keys.pressed.LEFT);
			var isTurningRight = (velocity.x > prevVelocity && FlxG.keys.pressed.RIGHT);

			if (isTurningLeft || velocity.x > 0)
			{
				flipX = false;
			}
			else if (isTurningRight || velocity.x < 0)
			{
				flipX = true;
			}
		}
		prevVelocity = velocity.x;
	}
}