package states ;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState 
{
	private var btnPlay:FlxButton;
	
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
		btnPlay = new FlxButton(0, 0, "Level 1", clickPlayLevel1);
		btnPlay.setGraphicSize(100, 28);
		btnPlay.setSize(100, 28);
		btnPlay.screenCenter();
		add(btnPlay);
	}
	
	function clickPlayLevel1():Void
	{
		FlxG.switchState(new GameState(AssetPaths.level1__csv));
	}
	
}