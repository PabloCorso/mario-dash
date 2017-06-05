package states ;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.math.FlxPoint;
import gameObjects.Player;
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
		player = new Player();

		startNewGame();
	}

	function startNewGame()
	{
		createMap();
		setCameraBehaviour();
		renewGame();
	}

	function createMap()
	{
		map.load(mapId);
		add(map);
	}

	function setCameraBehaviour()
	{
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.worldBounds.set(0, 0, map.width, map.height);
	}

	function renewGame()
	{
		clearCurrentGame();
		setPlayerAtStart();
		map.setDeadlyTileCollisions(deadlyTileCollision);
	}

	function setPlayerAtStart()
	{
		var startCoords:FlxPoint = map.getStartPoint();
		player.setPosition(startCoords.x, startCoords.y);
		add(player);
	}

	function clearCurrentGame()
	{
		if (player != null)
		{
			remove(player);
		}
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ESCAPE)
		{
			renewGame();
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
		renewGame();
	}

	public function deadlyTileCollision(Tile:FlxObject, Particle:FlxObject):Void
	{
		this.gameOver();
	}
}