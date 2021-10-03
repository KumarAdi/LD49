import flixel.addons.nape.FlxNapeTilemap;
import flixel.util.FlxColor;
import flixel.FlxG;

enum abstract PlayerConfig(Float) to Float {
	var PLAYER_SPEED = 0.8;
	var PLAYER_JUMP_HEIGHT = 5;
}

class Player extends Entity {
	private var level:FlxNapeTilemap;

	public function new(x:Float = 0, y:Float = 0, level:FlxNapeTilemap) {
		super(x, y);
		createRectangularBody(8, 8);
		setBodyMaterial(0);

		this.level = level;
	}

	override function update(dt:Float) {
		if (FlxG.keys.anyPressed([LEFT, A])) {
			moveLeft(PLAYER_SPEED, level.body);
		}

		if (FlxG.keys.anyPressed([RIGHT, D])) {
			moveRight(PLAYER_SPEED, level.body);
		}

		if (FlxG.keys.anyJustPressed([SPACE, UP, W])) {
			jump(PLAYER_JUMP_HEIGHT);
		}

		super.update(dt);
	}
}
