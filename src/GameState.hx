package ;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.math.FlxRect;
import gameObjects.Player;
import openfl.Assets;

class GameState extends FlxState
{
	var map:FlxTilemap;
	var player:Player;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		createMap();
		startNewGame();
	}

	function startNewGame()
	{
		createPlayer();
		setCameraBehaviour();
	}

	function createMap()
	{
		map = new FlxTilemap();
		var mapId:String = AssetPaths.mapCSV_map2_tiles__csv;
		var mapData:String = Assets.getText(mapId);
		map.loadMapFromCSV(mapData, AssetPaths.tiles__png, 32, 32, null, 0, 1, 1);
		add(map);
	}

	function createPlayer()
	{
		clearCurrentGame();
		player = new Player(this, 100, 100);
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

		super.update(elapsed);
		FlxG.collide(map, player);
	}
}