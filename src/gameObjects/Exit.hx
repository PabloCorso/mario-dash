package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;

class Exit extends FlxSprite
{
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		loadGraphic(AssetPaths.exit__png, false, 16, 16);
		width = 16;
		height = 16;
	}

	public function playFininsh()
	{
		FlxG.sound.playMusic(AssetPaths.exit__wav, 1, false);
	}
}