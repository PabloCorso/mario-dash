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
	var mTray:Tray;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		map = new FlxTilemap();
		map.loadMapFromCSV(Assets.getText(AssetPaths.mapCSV_map2_tiles__csv), AssetPaths.tiles__png, 32, 32, null, 0, 1, 1);
		add(map);

		var mapMayonnaise = new FlxTilemap();
		mapMayonnaise.loadMapFromCSV(Assets.getText(AssetPaths.mapCSV_map2_tiles__csv), AssetPaths.tiles__png, 32, 32, null, 0, 1, 1);
		for (y in 0...mapMayonnaise.heightInTiles)
		{
			for (x in 0...mapMayonnaise.widthInTiles)
			{
				if (mapMayonnaise.getTile(x, y) != 0)
				{
					mapMayonnaise.setTile(x, y, -1);
				}
			}
		}

		add(mapMayonnaise);
		mTray = new Tray(mapMayonnaise);

		player = new Player(this,100, 100);
		add(player);

		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.worldBounds.set(0, 0, map.width, map.height);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(map, player);

		mTray.setContactPosition(player.x + player.width / 2, player.y + player.height + 1, FlxObject.DOWN);
		mTray.setContactPosition(player.x -1, player.y + player.height/2, FlxObject.LEFT);
		mTray.setContactPosition(player.x + player.width+1, player.y + player.height/2, FlxObject.RIGHT);
	}
}