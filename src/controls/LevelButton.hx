package controls;
import flixel.FlxG;
import states.GameState;

class LevelButton extends MenuButton
{
	var level:Int;

	public function new(X:Float=0, Y:Float=0, Level:Int)
	{
		level = Level;
		super(X, Y, getLevelText(), onClick);
	}

	function getLevelText()
	{
		return "Level " + level;
	}

	function onClick()
	{
		var mapId:String = getMapId();
		FlxG.switchState(new GameState(mapId));
	}

	function getMapId():String
	{
		switch (level)
		{
			case 1: { return AssetPaths.level1__csv; }
			default: return "";
		}
	}

}