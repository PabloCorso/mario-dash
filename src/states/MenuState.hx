package states ;
import controls.LevelButton;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	private var btnLevel1:FlxButton;

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
		//btnPlay = new FlxButton(0, 0, "Level 1", clickPlayLevel1);
		btnLevel1 = new LevelButton(0, 0, 1);
		btnLevel1.setGraphicSize(100, 28);
		btnLevel1.setSize(100, 28);
		btnLevel1.screenCenter();
		add(btnLevel1);
	}

}