package states ;
import controls.Hud;
import controls.InGameMenu;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import gameObjects.Coin;
import gameObjects.EntityType;
import gameObjects.Player;
import gameObjects.GameMap;

class GameState extends FlxState
{
	var map:GameMap;
	var mapId:String;
	var player:Player;
	var hud:Hud;
	var inGameMenu:InGameMenu;
	var coins:FlxTypedGroup<Coin>;

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
		coins = new FlxTypedGroup<Coin>();
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
		map.setFinishTile(playerMayFinished);
		//map.setDeadlyTileCollisions(deadlyTileCollision);
	}

	private function placeEntities(type:EntityType, position:FlxPoint):Void
	{
		switch (type)
		{
			case EntityType.Player:
				player.setPosition(position.x, position.y);
			case EntityType.Coin:
				coins.add(new Coin(position.x, position.y));
		}
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
		add(player);
		map.setEntities(placeEntities);
		add(coins);
		add(inGameMenu);
		hud.resetTimer();
	}

	function clearCurrentGame()
	{
		remove(player);
		remove(inGameMenu);
		remove(coins);
	}

	override public function update(elapsed:Float):Void
	{
		if (isRequestingInGameMenuToggle())
		{
			toggleInGameMenu();
		}
		else if (isRequestingRenew())
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

		FlxG.collide(map, player);
		FlxG.overlap(player, coins, playerTouchCoin);
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

	private function playerTouchCoin(player:Player, coin:Coin):Void
	{
		if (coin.alive && coin.exists)
		{
			//sndCoin.play(true);
			//_money++;
			//_hud.updateHUD(_health, _money);
			coin.kill();
		}
	}

	function playerMayFinished(Tile:FlxObject, Particle:FlxObject)
	{
		if (true)
		{
			finishGame();
		}
	}

	function deadlyTileCollision(Tile:FlxObject, Particle:FlxObject):Void
	{
		renewGame();
	}

	function finishGame()
	{
		returnToMenu();
	}

	function returnToMenu()
	{
		FlxG.switchState(new MenuState());
	}
}