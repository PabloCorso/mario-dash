package gameObjects;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import openfl.Assets;

class GameMap extends FlxTilemap
{
	static inline var mapTilesSize:Int = 16;
	static inline var startTile:Int = 1;
	static inline var finishTile:Int = 7;
	public static inline var dieTileRight = 11;
	public static inline var dieTileLeft = 12;
	public static inline var dieTileUp = 4;
	public static inline var dieTileDown = 13;

	var startPoistion:FlxPoint;
	
	public function new()
	{
		super();
	}

	public function load(mapId:String)
	{
		var mapData:String = Assets.getText(mapId);
		loadMapFromCSV(mapData, AssetPaths.map_tiles3__png, mapTilesSize, mapTilesSize, null, 0, 1, 1);

		setStartPosition();
	}

	function setStartPosition()
	{
		var startTileIndex:Int = getTileIndex(startTile);
		hideTile(startTileIndex);

		startPoistion = getTileCoordsByIndex(startTileIndex);
		startPoistion.y -= mapTilesSize;
	}

	public function getStartPoint():FlxPoint
	{
		return startPoistion;
	}

	function getTileIndex(tile:Int):Int
	{
		return getTileInstances(tile)[0];
	}

	function hideTile(startTileIndex:Int)
	{
		setTileByIndex(startTileIndex, 0, true);
	}

	public function setDeadlyTileCollisions(playerDeath:FlxObject->FlxObject->Void)
	{
		setTileProperties(dieTileDown, FlxObject.ANY, playerDeath);
		setTileProperties(dieTileLeft, FlxObject.ANY, playerDeath);
		setTileProperties(dieTileUp, FlxObject.ANY, playerDeath);
		setTileProperties(dieTileRight, FlxObject.ANY, playerDeath);
	}

	public function setFinishTile(playerMayFinish:FlxObject->FlxObject->Void)
	{
		setTileProperties(finishTile, FlxObject.ANY, playerMayFinish);
	}
}