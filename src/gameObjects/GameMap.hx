package gameObjects;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import lime.Assets;

class GameMap extends FlxTilemap
{
	static inline var mapTilesSize:Int = 32;
	static inline var startTile:Int = 1;
	static inline var endTile:Int = 2;
	public static inline var dieTileRight = 11;
	public static inline var dieTileLeft = 12;
	public static inline var dieTileUp = 4;
	public static inline var dieTileDown = 13;

	var endPositionX:Float;

	public function new()
	{
		super();
	}

	public function load(mapId:String)
	{
		var mapData:String = Assets.getText(mapId);
		loadMapFromCSV(mapData, AssetPaths.tilesNew__png, mapTilesSize, mapTilesSize, null, 0, 1, 1);

		var endTileIndex:Int = getTileIndex(endTile);
		endPositionX = getTileCoordsByIndex(endTileIndex).x - mapTilesSize*2;
	}

	public function getStartPoint():FlxPoint
	{
		var startTileIndex:Int = getTileIndex(startTile);
		hideTile(startTileIndex);

		var startPoint:FlxPoint = getTileCoordsByIndex(startTileIndex);
		startPoint.y -= mapTilesSize;
		return startPoint;
	}

	public function getEndPosition():Float
	{
		return endPositionX;
	}

	public function getTileIndex(tile:Int):Int
	{
		return getTileInstances(tile)[0];
	}

	function hideTile(startTileIndex:Int)
	{
		setTileByIndex(startTileIndex, 0, true);
	}

	public function getAllTilesByTipe(tile:Int):Array<Int>
	{
		return getTileInstances(tile);
	}
}