package states ;
import controls.Hud;
import controls.InGameMenu;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import gameObjects.Coin;
import gameObjects.EntityType;
import gameObjects.Exit;
import gameObjects.MapData;
import gameObjects.Player;
import gameObjects.GameMap;

class GameState extends FlxState
{
	var mapData:MapData;

	var map:GameMap;
	var player:Player;
	var exit:Exit;
	var hud:Hud;
	var inGameMenu:InGameMenu;

	var coins:FlxTypedGroup<Coin>;
	var coinsTaken:Int;
	var totalCoins:Int;

	var finished:Bool;

	public function new(mapData:MapData)
	{
		this.mapData = mapData;
		super();
	}

	override public function create():Void
	{
		this.bgColor = FlxColor.fromString("#6B8CFF");

		coins = new FlxTypedGroup<Coin>();
		inGameMenu = new InGameMenu();
		hud = new Hud();
		
		createMap();
		map.setEntities(placeEntities);
		hud.setCoinsLeft(totalCoins);
		setCameraBehaviour();

		//var hills = new FlxBackdrop(AssetPaths.hills__png, 1, 0, true, false);
		//hills.setPosition(0, FlxG.height - hills.height);
		//var hillsSky = new FlxBackdrop(AssetPaths.hills_sky__png, 1, -0.1, true, true);
		//add(hillsSky);
		//add(hills);

		add(exit);
		add(coins);
		add(map);
		add(player);
		add(inGameMenu);
		add(hud);

		hud.startTimer();

		//hud.setBestTime(13.78);
	}

	function createMap()
	{
		map = new GameMap();
		map.load(mapData);
		map.setDeadlyTileCollisions(playerTouchDeadlyTile);
	}

	private function placeEntities(type:EntityType, position:FlxPoint):Void
	{
		switch (type)
		{
			case EntityType.Player:
				player = new Player(position.x, position.y);
			case EntityType.Coin:
				coins.add(new Coin(position.x, position.y));
				totalCoins++;
			case EntityType.Exit:
				exit = new Exit(position.x, position.y);
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
		if (isPressingPause())
		{
			inGameMenu.toggle();
		}

		player.moves = !inGameMenu.visible;
		hud.togglePause(inGameMenu.visible);
		super.update(elapsed);

		if (inGameMenu.requestedQuit)
		{
			FlxG.switchState(new QuitState());
			return;
		}
		if (FlxG.keys.justPressed.ESCAPE)
		{
			goToMapMenu();
			return;
		}

		FlxG.collide(map, player);
		FlxG.overlap(player, exit, playerTouchExit);
		FlxG.overlap(player, coins, playerTouchCoin);
	}

	function isPressingPause()
	{
		return FlxG.keys.justPressed.P &&
			   (player.isTouching(FlxObject.FLOOR) || inGameMenu.visible);
	}

	private function playerTouchCoin(player:Player, coin:Coin):Void
	{
		if (coin.alive && coin.exists)
		{
			coin.take();
			coinsTaken++;
			hud.setCoinsLeft(totalCoins - coinsTaken);
		}
	}

	function playerTouchExit(Tile:FlxObject, Particle:FlxObject)
	{
		if (coinsTaken >= totalCoins)
		{
			exit.playFininsh();
			finished = true;
			goToMapMenu();
		}
	}

	function playerTouchDeadlyTile(Tile:FlxObject, Particle:FlxObject)
	{
		goToMapMenu();
	}

	function goToMapMenu()
	{
		var seconds = hud.getSeconds();
		FlxG.switchState(new MapState(mapData, finished, seconds));
	}
}