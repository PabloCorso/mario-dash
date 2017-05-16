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
import gameObjects.GameMap;

class GameState extends FlxState
{
	var map:GameMap;
	var mapId:String;
	var player:Player;

	public function new(mapId:String)
	{
		this.mapId = mapId;
		super();
	}

	override public function create():Void
	{
		map = new GameMap();
		startNewGame();
	}

	function startNewGame()
	{
		clearCurrentGame();
		createMap();
		createPlayer();
		setCameraBehaviour();
		setDieTiles();
	}

	function createMap()
	{
		map.load(mapId);
		add(map);
	}

	function createPlayer()
	{
		var startCoords:FlxPoint = map.getStartPoint();
		player = new Player(startCoords.x, startCoords.y);
		add(player);
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

		if (playerFinished())
		{
			finishGame();
			return;
		}

		FlxG.collide(map, player);
	}

	function finishGame()
	{
		return FlxG.switchState(new MenuState());
	}

	function playerFinished()
	{
		return player.x >= map.getEndPosition();
	}

	function gameOver()
	{
		startNewGame();
	}

	public function setDieTiles()
	{
		map.setTileProperties(GameMap.dieTileDown, FlxObject.ANY, playerDeath);
		map.setTileProperties(GameMap.dieTileLeft, FlxObject.ANY, playerDeath);
		map.setTileProperties(GameMap.dieTileUp, FlxObject.ANY, playerDeath);
		map.setTileProperties(GameMap.dieTileRight, FlxObject.ANY, playerDeath);
	}

	public function playerDeath(Tile:FlxObject, Particle:FlxObject):Void
	{
		this.gameOver();
	}
}