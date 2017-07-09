package gameObjects;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import gameObjects.Exit;
import gameObjects.MapData.MapDataConfig;
import openfl.Assets;

class GameMap extends FlxTilemap
{
	static inline var mapTilesSize:Int = 16;
	static inline var startTile:Int = 1;
	static inline var keyTile:Int = 2;
	static inline var exitTile:Int = 3;
	static inline var enemyTile:Int = 6;
	static inline var dumpTile:Int = 60;
	var mapEnemies:FlxTilemap;

	var deadlyTiles = [45, 46, 47, 48, 49, 51];
	public function new()
	{
		super();
	}

	public function load(mapData:MapData)
	{
		var mapPath = MapDataConfig.getPath(mapData);
		var map:String = Assets.getText(mapPath);
		loadMapFromCSV(map, AssetPaths.map_tiles__png, mapTilesSize, mapTilesSize, null, 0, 20, 30);
		var enemyMapPath = MapDataConfig.getPathEnemies(mapData);
	
		if (enemyMapPath != ""){
			var enemyMap = Assets.getText(enemyMapPath);
			mapEnemies = new FlxTilemap();
			this.mapEnemies.loadMapFromCSV(enemyMap, AssetPaths.map_tiles__png, mapTilesSize, mapTilesSize, null, 0, 20, 30);
			
		}
	}

	public function setEntities(EntityLoadCallback:EntityType->FlxPoint->Void, EntityLayer:String = "entities"):Void
	{
		var startPosition = getEntityTilePositions(startTile)[0];
		EntityLoadCallback(EntityType.Player, startPosition);

		var exitPosition = getEntityTilePositions(exitTile)[0];
		EntityLoadCallback(EntityType.Exit, exitPosition);

		var keyPositions = getEntityTilePositions(keyTile);
		for (keyPosition in keyPositions)
		{
			EntityLoadCallback(EntityType.Key, keyPosition);
		}
		
		var enemyPositions = getEntityTilePositions(enemyTile);
		for (enemyPosition in enemyPositions)
		{
			EntityLoadCallback(EntityType.Enemy, enemyPosition);
		}
	}

	function getEntityTilePositions(tile:Int):Array<FlxPoint>
	{
		var tileIndices = getTileInstances(tile);

		var positions = new Array<FlxPoint>();
		if (tileIndices != null && tileIndices.length > 0)
		{
			for (tileIndex in tileIndices)
			{
				var position = getTilePositionByIndex(tileIndex);
				positions.push(position);
			}
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

	public function setDeadlyTileCollisions(playerDeath:FlxObject->FlxObject->Void)
	{
		for (tile in deadlyTiles)
		{
			setTileProperties(tile, FlxObject.ANY, playerDeath);
		}
	}
	
	public function getMapEnemies():FlxTilemap 
	{
		return mapEnemies;
	}
	
	public function setMapEnemies(value:FlxTilemap):FlxTilemap 
	{
		return mapEnemies = value;
	}
}