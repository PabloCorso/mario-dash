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
	private static inline var wallHang:String = "wallHang";

	public function new(X:Float=0, Y:Float=0)
	{
		super(X, Y);

		initializeGraphics();
		setPhysics();
	}

	function setPhysics()
	{
		maxVelocity.x = 200;
		acceleration.y = 1000;
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
		animation.add(wallHang,[11]);
		animation.play(stand);
	}

	var ACCELERATION:Float = 1000;
	override public function update(elapsed:Float)
	{
		movement();
		updateAnimation(elapsed);
		super.update(elapsed);
	}
	
	function movement() 
	{
		acceleration.x = ACCELERATION;
		if (mustJump())
		{
			velocity.y = -400;
		}
	}

	function mustJump()
	{
		return isTouching(FlxObject.FLOOR) && FlxG.keys.pressed.SPACE;
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