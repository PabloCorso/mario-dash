package controls;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionList extends FlxUIGroup
{
	var options:Array<FlxSprite>;
	var selectCallback:FlxSprite->Void;

	var pointer:FlxSprite;
	var sndSelect:FlxSound;
	var selectedIndex:Int;

	public function new()
	{
		super();
		
		createPointer();
		createSounds();
	}

	public function setOptions(options:Array<FlxSprite>, selectCallback:FlxSprite->Void)
	{
		this.options = options;
		this.selectCallback = selectCallback;
		placeOptions();
		initSelection();
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

	function initSelection()
	{
		selectedIndex = 0;
		pointer.y = options[0].y + (options[0].height / 2) - 8;
	}

	function placeOptions()
	{
		for (option in options)
		{
			option.scrollFactor.set();
			//option.screenCenter();
			add(option);
		}
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
						selectedIndex = 1;
					else
						selectedIndex--;
				case PointerMove.DOWN:
					if (selectedIndex == 1)
						selectedIndex = 0;
					else
						selectedIndex++;
			}

			sndSelect.play();
			pointer.y = options[selectedIndex].y + (options[selectedIndex].height / 2) - 8;
		}
	}

	function executeSelection()
	{
		var selectedOption = options[selectedIndex];
		selectCallback(selectedOption);
	}
}