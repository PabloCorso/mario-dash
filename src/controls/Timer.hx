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

	public function start(initialTime:Float)
	{
		timePassed = initialTime;
	}

	override public function update(elapsed:Float):Void
	{
		if (!isPaused && timePassed > 0)
		{
			if (timePassed - elapsed < 0)
			{
				timePassed =  0;
			}
			else
			{
				timePassed -= elapsed;
			}
			text = getTimeDisplay(timePassed);
		}
		super.update(elapsed);
	}

	public function getTime()
	{
		return timePassed;
	}
}