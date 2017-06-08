package controls;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import utils.FlxSpriteUtils;

class InGameMenu extends FlxTypedGroup<FlxSprite>
{
	static inline var resume = "Resume";
	static inline var quit = "Quit";
	
	public var requestedQuit:Bool;

	var sprBack:FlxSprite;
	var sprBackHeader:FlxSprite;
	var sprBackBody:FlxSprite;
	var txtHeader:FlxText;

	var sndSelect:FlxSound;
	var selectedIndex:Int;
	var pointer:FlxSprite;
	var choices:Array<FlxText>;

	public function new()
	{
		super();

		drawMenu();

		selectedIndex = 0;
		active = false;
		visible = false;
	}

	function drawMenu()
	{
		drawBackground();
		drawHeader();
		drawOptions();
		initSounds();
	}

	function initSounds()
	{
		sndSelect = FlxG.sound.load(AssetPaths.select__wav);
	}

	function drawBackground()
	{
		var size = 200;
		sprBack = new FlxSprite().makeGraphic(size, size, FlxColor.WHITE);
		sprBack.screenCenter();
		add(sprBack);

		var headerSize = 50;
		var borderSize = 2;
		var innerWidth = size - borderSize;
		var bodyY = headerSize + borderSize;
		var bodyHeight = size - headerSize - borderSize - 1;
		sprBackHeader = new FlxSprite(sprBack.x + 1, sprBack.y + 1).makeGraphic(innerWidth, headerSize, FlxColor.BLACK);
		sprBackBody = new FlxSprite(sprBack.x + 1, sprBack.y + bodyY).makeGraphic(innerWidth, bodyHeight, FlxColor.BLACK);
		add(sprBackHeader);
		add(sprBackBody);
	}

	function drawHeader()
	{
		txtHeader = new FlxText();
		txtHeader.text = "Pause";
		txtHeader.size = 20;
		FlxSpriteUtils.relativeCenter(txtHeader, sprBackHeader);
		add(txtHeader);
	}

	function drawOptions()
	{
		pointer = new FlxSprite();
		pointer.loadGraphic(AssetPaths.pointer__png);
		pointer.x = sprBack.x + 20;
		add(pointer);

		var textSize = 16;
		choices = new Array<FlxText>();

		var optionsX = pointer.x + pointer.width + 20;
		var resumeOption = new FlxText();
		resumeOption.text = resume;
		resumeOption.size = textSize;
		resumeOption.x = optionsX;
		resumeOption.y = sprBackBody.y + 30;
		choices.push(resumeOption);

		var quitOption = new FlxText();
		quitOption.text = quit;
		quitOption.size = textSize;
		quitOption.x = optionsX;
		quitOption.y = resumeOption.y + textSize + 30;
		choices.push(quitOption);

		add(choices[0]);
		add(choices[1]);

		pointer.y = choices[0].y + (choices[0].height / 2) - 8;
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
		pointer.y = choices[selectedIndex].y + (choices[selectedIndex].height / 2) - 8;
	}

	function executeSelection()
	{
		var selectedOption = choices[selectedIndex].text;
		switch(selectedOption){
			case resume:
				toggle();
			case quit:
				requestedQuit = true;
		}
	}

	public function toggle()
	{
		if (!visible)
		{
			// TODO: ?????
			sprBack.screenCenter();
		}

		active = !active;
		visible = !visible;
	}
}

enum PointerMove
{
	UP;
	DOWN;
}