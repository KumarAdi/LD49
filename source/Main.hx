package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(480, 288, MenuState, 1, 60, 60, true));
	}
}
