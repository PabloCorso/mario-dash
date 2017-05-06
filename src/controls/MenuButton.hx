package controls;

import flixel.ui.FlxButton;

class MenuButton extends FlxButton 
{

	public function new(X:Float=0, Y:Float=0, Text:String, CallBack:Void->Void) 
	{
		super(X, Y, Text, CallBack);
	}
	
	override function onUpHandler():Void 
	{
		super.onUpHandler();
		
	}
	
}