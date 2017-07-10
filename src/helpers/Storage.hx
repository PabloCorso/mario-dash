package helpers;
import flixel.FlxG;
import flixel.util.FlxSave;
import haxe.ds.IntMap;
import utils.Utils;

class Storage
{
	static inline var topTimesAmount = 10;
	static inline var storageBind = "storage";

	static var save:FlxSave;

	static function getSave():FlxSave
	{
		if (Storage.save == null)
		{
			Storage.save = new FlxSave();
			Storage.save.bind(storageBind);
		}

		return Storage.save;
	}

	static public function erase()
	{
		getSave().erase();
		Storage.close();
	}

	static function close()
	{
		if (Storage.save !=null )
		{
			Storage.save.close();
		}
	}

	static public function isTopTime(mapId:Int, time:Float):Bool
	{
		var topTimes = Storage.getTopTimes(mapId);
		return topTimes == null || topTimes.length < topTimesAmount || time > topTimes[topTimes.length - 1];
	}

	static public function saveTimeToTopTimes(mapId:Int, time:Float)
	{
		var topTimes = Storage.getTopTimes(mapId);
		if (topTimes.length == topTimesAmount)
		{
			topTimes.pop();
		}
		topTimes.push(time);
		Utils.sortFloatArray(topTimes);

		Storage.getSave().data.mapsTopTimes.set(mapId, topTimes);
		Storage.close();
	}

	static public function getTopTimes(mapId:Int):Array<Float>
	{
		var mapsTopTimes = Storage.getMapsTopTimes();
		var times;
		if (!mapsTopTimes.exists(mapId))
		{
			mapsTopTimes.set(mapId, []);
			Storage.getSave().data.mapsTopTimes = mapsTopTimes;
		}

		return Storage.getSave().data.mapsTopTimes.get(mapId);
	}

	static private function getMapsTopTimes():IntMap<Array<Float>>
	{
		var mapsTopTimes = Storage.getSave().data.mapsTopTimes;
		if (mapsTopTimes == null)
		{
			Storage.getSave().data.mapsTopTimes = mapsTopTimes = new IntMap<Array<Float>>();
		}

		return mapsTopTimes;
	}
}