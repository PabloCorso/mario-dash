package controls.menu;
import controls.menu.PointerMove;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class MenuList extends FlxTypedGroup<FlxSprite>
{
	private static inline var spacing:Int = 10;
	private static inline var pointerMargin:Int = 10;

	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	public var goAround:Bool;

	var options:Array<FlxSprite>;
	var selectCallback:FlxSprite->Void;

	var minVisibleIndex:Int = 0;
	var maxVisibleIndex:Int = 0;
	var optionsX:Float ;

	var selectedIndex:Int;
	var pointer:FlxSprite;
	var sndPointer:FlxSound;

	public function new(?x:Float=0, ?y:Float=0, ?width:Float=0, ?height:Float=0, ?goAround:Bool=true)
	{
		super();
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.goAround = goAround;

		selectedIndex = 0;
		pointer = new Pointer();
		add(pointer);
	}

	/**
	 * Edits same x and y that are passed on creation. Use before setting options.
	 */
	public function screenCenter(?axes:FlxAxes)
	{
		if (axes == null)
			axes = FlxAxes.XY;

		if (axes != FlxAxes.Y)
			x = (FlxG.width / 2) - (width / 2);
		if (axes != FlxAxes.X)
			y = (FlxG.height / 2) - (height / 2);
	}

	public function setOptions(options:Array<FlxSprite>, selectCallback:FlxSprite->Void)
	{
		this.options = options;
		this.selectCallback = selectCallback;

		optionsX = getOptionsXPosition();
		placeOptions();
		placePointer();
	}

	public function setPointerSound(sound:FlxSound)
	{
		sndPointer = sound;
	}

	public function setPointerTo(index:Int)
	{
		if (options != null && index > 0 && index < options.length)
		{
			selectedIndex = index;
			updateMenu();
		}
	}

	function placeOptions()
	{
		removeOptions();

		var currentY:Float = y;
		var i = minVisibleIndex;
		var canFitMore = true;
		while (i < options.length && canFitMore)
		{
			var option = options[i];
			canFitMore = currentY + spacing + option.height < y + height;
			if (canFitMore)
			{
				option.scrollFactor.set();
				option.x = optionsX;
				option.y = currentY;
				add(option);

				currentY += option.height + spacing;
				maxVisibleIndex = i++;
			}
		}
	}

	function removeOptions()
	{
		for (option in options)
		{
			remove(option);
		}
	}

	function getOptionsXPosition()
	{
		var optionsWidthSum:Float = 0;
		for (option in options)
		{
			optionsWidthSum += option.width;
		}

		var average = optionsWidthSum / options.length;
		return x + (width / 2) - (average / 2);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			executeSelection();
		}
		else if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
		{
			var move = FlxG.keys.justPressed.UP ? PointerMove.UP : PointerMove.DOWN;
			movePointer(move);
		}

		super.update(elapsed);
	}

	private function movePointer(pointerMove:PointerMove):Void
	{
		if (options == null || options.length <= 1)
		{
			selectedIndex = 0;
		}
		else
		{
			updateSelectedIndex(pointerMove);
			updateMenu();
		}
	}

	function updateMenu()
	{
		updateVisibleOptions();

		if (sndPointer != null) sndPointer.play();
		placePointer();
	}

	function updateSelectedIndex(pointerMove:PointerMove)
	{
		switch (pointerMove)
		{
			case PointerMove.UP:
				if (selectedIndex == 0)
					selectedIndex = goAround ? options.length - 1 : selectedIndex;
				else
					selectedIndex--;
			case PointerMove.DOWN:
				if (selectedIndex == options.length - 1)
					selectedIndex = goAround ? 0 : selectedIndex;
				else
					selectedIndex++;
		}
	}

	function updateVisibleOptions()
	{
		if (selectedIndex < minVisibleIndex)
		{
			if (selectedIndex == 0)
				minVisibleIndex = 0;
			else
				minVisibleIndex--;
			placeOptions();
		}
		else if (selectedIndex > maxVisibleIndex)
		{
			if (selectedIndex == options.length - 1)
				minVisibleIndex = options.length - 1 - (maxVisibleIndex - minVisibleIndex);
			else
				minVisibleIndex++;
			placeOptions();
		}
	}

	function placePointer()
	{
		var option = options[selectedIndex];
		pointer.x = option.x - pointer.width - pointerMargin;
		pointer.y = option.y + (option.height / 2) - 8;
	}

	function executeSelection()
	{
		if (selectCallback != null)
		{
			var selectedOption = options[selectedIndex];
			selectCallback(selectedOption);
		}
	}
}