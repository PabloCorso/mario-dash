package controls;
import controls.menu.MenuList;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import flixel.util.FlxSpriteUtil;
import utils.FlxSpriteUtils;

class InGameMenu extends FlxTypedGroup<FlxBasic>
{
	static inline var resume = "Resume";
	static inline var quit = "Quit";

	public var requestedQuit:Bool;

	var sprBack:FlxSprite;
	var sprBackHeader:FlxSprite;
	var sprBackBody:FlxSprite;
	var txtHeader:FlxText;
	var menu:MenuList;

	public function new()
	{
		super();

		drawMenu();
		active = false;
		visible = false;
	}

	function drawMenu()
	{
		drawBackground();
		drawHeader();
		drawOptions();
	}

	function drawBackground()
	{
		var boxWith = 200;
		var boxHeight = 155;
		sprBack = new FlxSprite().makeGraphic(boxWith, boxHeight, FlxColor.WHITE);
		sprBack.scrollFactor.set();
		sprBack.screenCenter();

		var headerSize = 50;
		var borderSize = 2;
		var innerWidth = boxWith - borderSize;
		var bodyY = headerSize + borderSize;
		var bodyHeight = boxHeight - headerSize - borderSize - 1;
		sprBackHeader = new FlxSprite(sprBack.x + 1, sprBack.y + 1).makeGraphic(innerWidth, headerSize, FlxColor.BLACK);
		sprBackBody = new FlxSprite(sprBack.x + 1, sprBack.y + bodyY).makeGraphic(innerWidth, bodyHeight, FlxColor.BLACK);
		sprBackHeader.scrollFactor.set();
		sprBackBody.scrollFactor.set();

		add(sprBack);
		add(sprBackHeader);
		add(sprBackBody);
	}

	function drawHeader()
	{
		txtHeader = new FlxText();
		txtHeader.scrollFactor.set();
		txtHeader.text = "Pause";
		txtHeader.size = 20;
		FlxSpriteUtils.relativeCenter(txtHeader, sprBackHeader);
		add(txtHeader);
	}

	function drawOptions()
	{
		var options = new Array<FlxSprite>();
		var textSize = 16;

		var resumeOption = new FlxText();
		resumeOption.text = resume;
		resumeOption.size = textSize;
		options.push(resumeOption);

		var quitOption = new FlxText();
		quitOption.text = quit;
		quitOption.size = textSize;
		options.push(quitOption);

		menu = new MenuList(sprBackBody.x, sprBackBody.y + 20, sprBack.width, sprBack.height);
		menu.setOptions(options, optionSelected);
		menu.setPointerSound(FlxG.sound.load(AssetPaths.select__wav));
		add(menu);
	}

	function optionSelected(option:FlxSprite):Void
	{
		var txtOption:FlxText = cast option;
		switch (txtOption.text)
		{
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
			sprBack.screenCenter();
		}

		active = !active;
		visible = !visible;
	}
}