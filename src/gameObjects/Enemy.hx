package gameObjects;

/**
 * ...
 * @author ...
 */
class Enemy extends EnemyTemplate
{
	public static inline var RUN_SPEED:Int = 60;
	public static inline var GRAVITY:Int = 0;
	public static inline var JUMP_SPEED:Int = 60;
	public static inline var HEALTH:Int = 1;
	public static inline var SPAWNTIME:Float = 30;
	
	private var _gibs:FlxEmitter;
	private var _spawntimer:Float;

	public function new(X:Float, Y:Float, ThePlayer:Player, Gibs:FlxEmitter)
		{
		// Initialize sprite object
		super(X, Y);
		// Load this animated graphic file
		loadGraphic("assets/enemy1.png", true);
		// Setting the color tints the plain white alien graphic
		
		// Time to create a simple animation! "alien.png" has 3 frames of animation in it.
		// We want to play them in the order 1, 2, 3, 1 (but of course this stuff is 0-index).
		// To avoid a weird, annoying appearance the framerate is randomized a little bit
		// to a value between 6 and 10 (6+4) frames per second.
		this.animation.add("Default", [0, 1], 30);

		// Now that the animation is set up, it's very easy to play it back!
		this.animation.play("Default");
		
		// Everybody move to the right!
		velocity.x = 10;
		}
		
		
}