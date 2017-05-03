package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Player extends FlxSprite
{
	public function new(group:FlxGroup, X:Float=0, Y:Float=0)
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
		width = 40;
		height = 41;
	}

	function loadAnimations()
	{
		animation.add("run", [2, 3, 4, 5, 6, 7, 8, 9], 30);
		animation.add("stand", [10]);
		animation.add("jump", [1]);
		animation.add("fall", [0]);
		animation.add("wallHang",[11]);
		animation.play("stand");
	}

	var ACCELERATION:Float = 1000;
	override public function update(elapsed:Float)
	{
		acceleration.x = ACCELERATION;
		if (FlxG.keys.pressed.SPACE)
		{
			if (isTouching(FlxObject.FLOOR))
			{
				velocity.y = -400;
			}
		}

		updateAnimation(elapsed);
		super.update(elapsed);
	}

	override function updateAnimation(elapsed:Float)
	{
		if (!isTouching(FlxObject.FLOOR))
		{
			if (velocity.y > 0)
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