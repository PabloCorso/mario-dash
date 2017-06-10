package controls.menu;
import controls.menu.MapButton;
import flixel.FlxG;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import gameObjects.MapData;

class MenuList extends FlxUIList
{
	static inline var buttonWidth:Int = 100;
	static inline var buttonHeight:Int = 28;

	public function new(maps: Array<MapData>)
	{
		var items = new Array<IFlxUIWidget>();
		var i:Int;
		for (i in 0...maps.length)
		{
			var btn = new MapButton(buttonWidth, buttonHeight, maps[i]);
			items.insert(i, btn);
		}

		super(0, 0, items);
		width = buttonWidth;
		prevButtonOffset.y = -12;
		spacing = 20;
	}
}