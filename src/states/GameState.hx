package states ;
import controls.Hud;
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
	var hud:Hud;

	public function new(mapId:String)
	{
		this.mapId = mapId;
		super();
	}

	override public function create():Void
	{
		startNewGame();
	}

	function startNewGame()
	{
		createHud();
		player = new Player();
		createMap();
		setCameraBehaviour();
		renewGame();
	}

	function createHud()
	{
		hud = new Hud();
		add(hud);
	}

	function createMap()
	{
		map = new GameMap();
		map.load(mapId);
		add(map);
		map.setDeadlyTileCollisions(deadlyTileCollision);
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
		hud.addTry();
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
		if (FlxG.keys.justPressed.ESCAPE || isPlayerFalling())
		{
			renewGame();
		}

		super.update(elapsed);

		if (playerFinished())
		{
			finishGame();
			return;
		}

		FlxG.collide(map, player);
	}

	function isPlayerFalling()
	{
		return player.y > FlxG.height;
	}

	function finishGame()
	{
		return FlxG.switchState(new MenuState());
	}

	function playerFinished()
	{
		return player.x >= map.getEndPosition();
	}

	function deadlyTileCollision(Tile:FlxObject, Particle:FlxObject):Void
	{
		renewGame();
	}
}