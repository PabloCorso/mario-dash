package states;
import controls.menu.MenuList;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import openfl.system.System;

class QuitState extends FlxState
{
	static inline var textSize = 16;
	static inline var noOption = "No";
	static inline var yesOption = "Yes";

	public function new()
	{
		super();
		this.bgColor = FlxColor.BLACK;

		var txtHeader = new FlxText();
		txtHeader.size = textSize;
		txtHeader.text = "Do you want to exit?";
		txtHeader.screenCenter(FlxAxes.X);
		txtHeader.y = 20;
		add(txtHeader);

		var options = new Array<FlxSprite>();

		var yes = new FlxText();
		yes.text = yesOption;
		yes.size = textSize;
		options.push(yes);

		var no = new FlxText();
		no.text = noOption;
		no.size = textSize;
		options.push(no);

		var menu = new MenuList();
		menu.goAround = false;
		menu.width = FlxG.width;
		menu.height = FlxG.height*0.5;
		menu.screenCenter();
		menu.setOptions(options, optionSelected);
		add(menu);
	}

	function optionSelected(option:FlxSprite):Void
	{
		var txtOption:FlxText = cast option;
		switch (txtOption.text)
		{
			case yesOption:
				exitGame();
			case noOption:
				goToMainMenu();
		}
	}

	function goToMainMenu()
	{
		FlxG.switchState(new MenuState());
	}

	function exitGame()
	{
		System.exit(0);
	}
}