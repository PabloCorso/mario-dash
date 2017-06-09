package states ;
import controls.Hud;
import controls.InGameMenu;
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
	var inGameMenu:InGameMenu;

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
		player = new Player();
		createMap();
		setCameraBehaviour();
		createViewControls();
		renewGame();
	}

	function createViewControls()
	{
		hud = new Hud();
		add(hud);

		inGameMenu = new InGameMenu();
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
		add(player);
		add(inGameMenu);
		hud.addTry();
		hud.resetTimer();
	}

	function setPlayerAtStart()
	{
		var startCoords:FlxPoint = map.getStartPoint();
		player.setPosition(startCoords.x, startCoords.y);
	}

	function clearCurrentGame()
	{
		remove(player);
		remove(inGameMenu);
	}

	override public function update(elapsed:Float):Void
	{
		if (isRequestingInGameMenuToggle())
		{
			toggleInGameMenu();
		}
		else if (isRequestingRenew() || isPlayerFallingOut())
		{
			renewGame();
		}

		player.moves = !inGameMenu.visible;
		super.update(elapsed);

		if (inGameMenu.requestedQuit)
		{
			returnToMenu();
			return;
		}
		if (playerFinished())
		{
			finishGame();
			return;
		}

		FlxG.collide(map, player);
	}

	function toggleInGameMenu()
	{
		inGameMenu.toggle();
	}

	function isRequestingInGameMenuToggle()
	{
		return FlxG.keys.justPressed.P &&
			   (player.isTouching(FlxObject.FLOOR) || inGameMenu.visible);
	}

	function isRequestingRenew()
	{
		return FlxG.keys.justPressed.R;
	}

	function isPlayerFallingOut()
	{
		return player.y > FlxG.height;
	}

	function finishGame()
	{
		returnToMenu();
	}

	function returnToMenu()
	{
		FlxG.switchState(new MenuState());
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