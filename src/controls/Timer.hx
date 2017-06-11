package controls;
import controls.TimerText;

class Timer extends TimerText
{
	public var isPaused:Bool;

	var timePassed:Float;

	public function new()
	{
		super();
	}

	public function start()
	{
		timePassed = 0;
	}

	override public function update(elapsed:Float):Void
	{
		if (!isPaused)
		{
			timePassed += elapsed;
			text = getTimeDisplay(timePassed);
		}
		super.update(elapsed);
	}
}