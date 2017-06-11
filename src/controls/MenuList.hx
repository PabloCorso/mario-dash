package controls;
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

	var x:Float;
	var y:Float;
	var width:Float;
	var height:Float;

	var options:Array<FlxSprite>;
	var selectCallback:FlxSprite->Void;

	var minVisibleIndex:Int;
	var maxVisibleIndex:Int;
	var optionsX:Float;

	var selectedIndex:Int;
	var pointer:FlxSprite;
	var sndPointer:FlxSound;

	public function new(?X:Float=0, ?Y:Float=0, ?Width:Float=0, ?Height:Float=0)
	{
		super();
		x = X;
		y = Y;
		width = Width;
		height = Height;

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
		var maxOptionWidth:Float = 0;
		for (option in options)
		{
			if (option.width > maxOptionWidth)
			{
				maxOptionWidth = option.width;
			}
		}

		return x + (width / 2) - (maxOptionWidth / 2);
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
			switch (pointerMove)
			{
				case PointerMove.UP:
					if (selectedIndex == 0)
						selectedIndex = options.length - 1;
					else
						selectedIndex--;
				case PointerMove.DOWN:
					if (selectedIndex == options.length - 1)
						selectedIndex = 0;
					else
						selectedIndex++;
			}

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

			if (sndPointer != null) sndPointer.play();
			placePointer();
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
		var selectedOption = options[selectedIndex];
		selectCallback(selectedOption);
	}
}