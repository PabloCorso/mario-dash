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
	var x:Float;
	var y:Float;
	var width:Float;
	var height:Float;

	var options:Array<FlxSprite>;
	var selectCallback:FlxSprite->Void;

	var pointer:FlxSprite;
	var sndSelect:FlxSound;
	var selectedIndex:Int;

	public function new(?X:Float=0, ?Y:Float=0, ?Width:Float=0, ?Height:Float=0)
	{
		super();
		x = X;
		y = Y;
		width = Width;
		height = Height;

		selectedIndex = 0;
		createPointer();
		createSounds();
	}

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
		placeOptions();
		placePointer();
	}

	function createPointer()
	{
		pointer = new FlxSprite();
		pointer.scrollFactor.set();
		pointer.loadGraphic(AssetPaths.pointer__png);
		add(pointer);
	}

	function createSounds()
	{
		sndSelect = FlxG.sound.load(AssetPaths.select__wav);
	}

	function placeOptions()
	{
		var margin = 10;
		var currentY:Float = y;
		var optionsX:Float = getOptionsXPosition();
		for (option in options)
		{
			option.scrollFactor.set();
			option.x = optionsX;
			option.y = currentY;
			currentY += option.height + margin;
			add(option);
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
		else{

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

			sndSelect.play();
			placePointer();
		}
	}

	function placePointer()
	{
		var option = options[selectedIndex];
		pointer.x = option.x - pointer.width - 20;
		pointer.y = option.y + (option.height / 2) - 8;
	}

	function executeSelection()
	{
		var selectedOption = options[selectedIndex];
		selectCallback(selectedOption);
	}
}