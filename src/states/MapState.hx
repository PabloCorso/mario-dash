package states;
import flixel.FlxG;
import flixel.FlxState;

class MapState  extends FlxState
{
	var mapId:String;

	public function new(mapId:String)
	{
		this.mapId = mapId;
		super();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			returnToMenu();
		}
		else if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new GameState(mapId));
		}
	}

	function returnToMenu()
	{
		FlxG.switchState(new MenuState());
	}
}