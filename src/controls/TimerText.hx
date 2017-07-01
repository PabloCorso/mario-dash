package controls;

class TimerText extends HudText
{
	var seconds:Float;
	public function new(?seconds:Float=null)
	{
		super();

		this.seconds = seconds;
		if (seconds != null)
		{
			text = getTimeDisplay(seconds);
		}
	}

	function getTimeDisplay(secs:Float)
	{
		#if web
		var milliseconds = Std.int((secs * 100 - Math.floor(secs) * 100));
		var seconds:Int = Std.int((secs) % 60);
		var minutes:Int = Std.int((Math.floor(secs / 60) % 60));
		var hours:Int   = Std.int((Math.floor((secs / (60 * 60)) % 24)));
		#else
		var milliseconds = (secs * 100 - Math.floor(secs) * 100);
		var seconds:Int = cast (secs) % 60;
		var minutes:Int = cast ((secs / 60) % 60);
		var hours:Int   = cast ((secs / (60 * 60)) % 24);
		#end

		var hoursText = hours == 0 ? "" : hours + ":";
		var minsText = hours == 0 && minutes == 0 ? "" : minutes + ":";
		var secsText = seconds < 10 ? "0" + seconds : "" + seconds;
		var milliText = milliseconds < 10 ? "0" + milliseconds : "" + milliseconds;

		return hoursText + minsText + secsText + ":" + milliText.substr(0, 2);
	}

	public function setPrefix(prefix:String)
	{
		text = prefix + text;
	}

	public function setSecondaryTime(time:Float)
	{
		var secondaryTime = getTimeDisplay(time);
		text = text + " (" + secondaryTime + ")";
	}
}