package states ;
import controls.MapButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	private var btnMap1:FlxButton;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		addLevelButtons();
		super.create();
	}

	function addLevelButtons()
	{
		btnMap1 = new MapButton(0, 0, 1);
		btnMap1 .screenCenter();
		add(btnMap1);
	}

}