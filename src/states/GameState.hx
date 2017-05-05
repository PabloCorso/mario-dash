package states ;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.math.FlxRect;
import gameObjects.Player;
import openfl.Assets;

class GameState extends FlxState
{
	static inline var mapTilesSize:Int = 32;
	var map:FlxTilemap;
	var player:Player;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		startNewGame();
	}

	function startNewGame()
	{
		clearCurrentGame();
		createMap(AssetPaths.level1__csv);
		createPlayer();
		setCameraBehaviour();
	}

	function createMap(mapId:String)
	{
		if (map == null) map = new FlxTilemap();
		var mapData:String = Assets.getText(mapId);
		map.loadMapFromCSV(mapData, AssetPaths.tiles__png, mapTilesSize, mapTilesSize, null, 0, 1, 1);
		add(map);
	}

	function createPlayer()
	{
		var startCoords:FlxPoint = getStartPoint();
		player = new Player(startCoords.x, startCoords.y - mapTilesSize);
		add(player);
	}
	
	function getStartPoint() 
	{
		var startTileIndex:Int = map.getTileInstances(1)[0];
		map.setTileByIndex(startTileIndex, 0, true);
		return map.getTileCoordsByIndex(startTileIndex);
	}

	function clearCurrentGame()
	{
		if (player != null)
		{
			remove(player);
		}
	}

	function setCameraBehaviour()
	{
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.worldBounds.set(0, 0, map.width, map.height);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ESCAPE)
		{
			startNewGame();
		}

		if (player.y > 400)
		{
			gameOver();
		}

		super.update(elapsed);
		FlxG.collide(map, player);
	}

	function gameOver()
	{
		startNewGame();
	}
}