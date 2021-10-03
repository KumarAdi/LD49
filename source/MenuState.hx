package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var playButton:FlxButton;

	override public function create()
	{
		// add bg
        var bg = new FlxSprite(0, 0);
        bg.color = FlxColor.BLACK;
		add(bg);
		bg.screenCenter();
		bg.scale.set(2, 2);

		// add play button
		playButton = new FlxButton(0, 0, "Play", clickPlay);
		add(playButton);
        playButton.screenCenter();

		// add title
        var title = new FlxText(100, 60, 0, "Unstable", 20, true);
        title.font = "assets/fonts/doomed.ttf";
        title.color = FlxColor.WHITE;
        add(title);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}
}
