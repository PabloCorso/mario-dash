package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import gameObjects.Bullet;
import gameObjects.GlobalGameData.GGD;
import gameObjects.Gun;
import gameObjects.Jason;
import gameObjects.Player;
import gameObjects.Wall;

class GameState extends FlxState
{
	var player:Player;
	var wall:Wall;
	var bullets:FlxGroup;
	var jasons:FlxGroup;

	public function new()
	{
		super();
	}

	override function create():Void
	{
		bullets = new FlxGroup();
		add(bullets);
		
		var gun:Gun = new Gun(bullets);
		player = new Player(gun, 100, 100);

		add(player);
		GGD.player = player;

		jasons = new FlxGroup();
		add(jasons);
		for (i in 0...10)
		{
			jasons.add(new Jason());
		}

		wall = new Wall(800, 100, 40, 600);
		add(wall);

		FlxG.camera.target = player;
		FlxG.worldBounds.setSize(FlxG.camera.width, FlxG.camera.height);

	}
	
	override function update(elapsed:Float):Void
	{
		var camera:FlxCamera = FlxG.camera;
		
		FlxG.worldBounds.x = camera.scroll.x;
		FlxG.worldBounds.y = camera.scroll.y;
		
		FlxG.collide(player, wall);
		FlxG.overlap(wall, bullets, wallVsBullets);
		FlxG.overlap(player, jasons, playerVsJason);
		FlxG.overlap(bullets, jasons, bulletsVsJason);
		
		super.update(elapsed);
	}

	function bulletsVsJason(aBullet:Bullet, aJason:Jason)
	{
		aBullet.kill();
		aJason.damage();
	}

	function playerVsJason(aPlayer:Player, aJason:Jason)
	{
		FlxG.switchState(new Death());
	}

	function wallVsBullets(aWall:Wall, aBullet:Bullet)
	{
		aBullet.kill();
	}

	override public function destroy():Void
	{
		super.destroy();
		GGD.clear();
	}
}