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
		btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		btnPlay.screenCenter();
		add(btnPlay);
		super.create();
	}
	
	function clickPlay():Void
	{
		FlxG.switchState(new GameState());
	}
	
}