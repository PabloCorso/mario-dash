package gameObjects;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import gameObjects.MapData.MapDataConfig;
import openfl.Assets;

class GameMap extends FlxTilemap
{
	static inline var mapTilesSize:Int = 16;
	static inline var startTile:Int = 1;
	static inline var coinTile:Int = 2;
	static inline var exitTile:Int = 3;

	var deadlyTiles = [46,47,48,49,51];

	public function new()
	{
		super();
	}

	public function load(mapData:MapData)
	{
		var mapId = MapDataConfig.getId(mapData);
		var map:String = Assets.getText(mapId);
		loadMapFromCSV(map, AssetPaths.map_tiles__png, mapTilesSize, mapTilesSize, null, 0, 1, 30);
	}

	public function setEntities(EntityLoadCallback:EntityType->FlxPoint->Void, EntityLayer:String = "entities"):Void
	{
		var startPosition = getEntityTilePositions(startTile, true)[0];
		EntityLoadCallback(EntityType.Player, startPosition);

		var coinPositions = getEntityTilePositions(coinTile, true);
		for (coinPosition in coinPositions)
		{
			EntityLoadCallback(EntityType.Coin, coinPosition);
		}
	}

	function getEntityTilePositions(tile:Int, ?hide:Bool=false):Array<FlxPoint>
	{
		var tileIndices = getTileInstances(tile);
		if (hide) hideTiles(tileIndices);

		var positions = new Array<FlxPoint>();
		for (tileIndex in tileIndices)
		{
			var position = getTilePositionByIndex(tileIndex);
			positions.push(position);
		}

		return positions;
	}

	function getTilePositionByIndex(tileIndex:Int):FlxPoint
	{
		var position = getTileCoordsByIndex(tileIndex);
		position.x -= mapTilesSize/2;
		position.y -= mapTilesSize/2;
		return position;
	}

	function hideTiles(tileIndices:Array<Int>)
	{
		for (tileIndex in tileIndices)
		{
			setTileByIndex(tileIndex, 0, true);
		}
	}

	public function setDeadlyTileCollisions(playerDeath:FlxObject->FlxObject->Void)
	{
		for (tile in deadlyTiles)
		{
			setTileProperties(tile, FlxObject.ANY, playerDeath);
		}
	}

	public function setFinishTile(playerMayFinish:FlxObject->FlxObject->Void)
	{
		setTileProperties(exitTile, FlxObject.ANY, playerMayFinish);
	}
}