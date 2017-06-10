package states ;
import controls.Hud;
import controls.InGameMenu;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
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
	var coinsTaken:Int;
	var totalCoins:Int;
	var sndCoin:FlxSound;
	var sndExit:FlxSound;

	public function new(mapId:String)
	{
		this.mapId = mapId;
		super();
	}

	override public function create():Void
	{
		player = new Player();
		coins = new FlxTypedGroup<Coin>();
		sndCoin = FlxG.sound.load(AssetPaths.coin__wav);
		inGameMenu = new InGameMenu();
		hud = new Hud();

		createMap();
		setCameraBehaviour();
		map.setEntities(placeEntities);

		add(player);
		add(coins);
		add(map);
		add(inGameMenu);
		add(hud);

		hud.startTimer();
	}

	function createMap()
	{
		map = new GameMap();
		map.load(mapId);
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
				totalCoins++;
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
		if (isRequestingInGameMenuToggle())
		{
			inGameMenu.toggle();
		}

		player.moves = !inGameMenu.visible;
		super.update(elapsed);

		if (inGameMenu.requestedQuit)
		{
			FlxG.switchState(new MenuState());
			return;
		}
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MapState(mapId));
			return;
		}

		FlxG.collide(map, player);
		FlxG.overlap(player, coins, playerTouchCoin);
	}

	function isRequestingInGameMenuToggle()
	{
		return FlxG.keys.justPressed.P &&
			   (player.isTouching(FlxObject.FLOOR) || inGameMenu.visible);
	}

	private function playerTouchCoin(player:Player, coin:Coin):Void
	{
		if (coin.alive && coin.exists)
		{
			sndCoin.play(true);
			coinsTaken++;
			coin.kill();
		}
	}

	function playerMayFinished(Tile:FlxObject, Particle:FlxObject)
	{
		if (coinsTaken >= totalCoins)
		{
			FlxG.sound.playMusic(AssetPaths.exit__wav, 1, false);
			returnToMenu();
		}
	}
}