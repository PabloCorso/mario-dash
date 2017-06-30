package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;

class Exit extends FlxSprite
{
	private static inline var askHelp:String = "askHelp";
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		loadGraphic(AssetPaths.peach__png, true, 32, 32);
		width = 32;
		height = 32;
		setSize(32, 32);
		loadAnimations();
		
	}
	public function playFinish()
	{
		FlxG.sound.playMusic(AssetPaths.exit__wav, 1, false);
		FlxG.sound.play(AssetPaths.clear__wav);
		kill();
	}
	
	function loadAnimations()
	{
		animation.add(askHelp, [0, 1], 1);
		animation.play(askHelp);

	}
}