package ;
import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{

	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE,init);
	}

	private function init(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);

		addChild(new FlxGame(800, 400, GameState));
	}

}