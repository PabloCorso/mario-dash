package gameObjects;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite
{
	public static inline var ACCELERATION:Int = 500;
	public static inline var walk:String = "walk";

	private var player:Player;

	public function new(X:Float, Y:Float, ThePlayer:Player)
		{
		// Initialize sprite object
		super(X, Y);
		this.player = ThePlayer;
		// Load this animated graphic file
		loadGraphic(AssetPaths.enemy1__png, true,16,16);
		// Setting the color tints the plain white alien graphic
		width = 16;
		height = 16;
		setSize(16, 16);
		allowCollisions = FlxObject.ANY;
		loadAnimations();
		
		velocity.x = -20;
		}
		
	function loadAnimations()
	{
		animation.add(walk, [0, 1], 1);
		animation.play(walk);

	}
	override public function update(elapsed:Float)
	{
		
		movement(elapsed);
		super.update(elapsed);
	}
	
	function movement(elapsed:Float)
	{
		acceleration.x = 0;
		if (this.isTouching(FlxObject.LEFT))
		{
			acceleration.x += ACCELERATION;
		}
		if (this.isTouching(FlxObject.RIGHT))
		{
			acceleration.x = -ACCELERATION;
		}
		updateOrientation();
	}
	
	function updateOrientation()
	{
		if (velocity.x != 0)
		{
			if (velocity.x > 0)
			{
				flipX = true;
			}
			else if (velocity.x < 0)
			{
				flipX = false;
			}
		}
	}
		
}