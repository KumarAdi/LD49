package;

import nape.constraint.Constraint;
import nape.constraint.AngleJoint;
import nape.phys.Material;
import Enemy.BlueEnemy;
import nape.callbacks.CbType;
import nape.callbacks.InteractionType;
import nape.callbacks.PreListener;
import flixel.addons.nape.FlxNapeTilemap;
import nape.geom.Vec2;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.addons.nape.FlxNapeSpace;

/**
 * ...
 * @author Zaphod
 */
class PlayState extends FlxState {
	static var _justDied:Bool = false;

	var _level:FlxNapeTilemap;
	var _player:Player;
	var _enemy:FlxNapeSprite;
	var _uprightConstraint:Constraint;

	override public function create():Void {
		FlxG.mouse.visible = false;
		FlxG.cameras.bgColor = 0xffaaaaaa;

		FlxNapeSpace.init();
		FlxNapeSpace.space.gravity = new Vec2(0, 500);

		_level = new FlxNapeTilemap();
		_level.loadMapFromCSV("assets/level.csv", FlxGraphic.fromClass(GraphicAuto), 0, 0, AUTO);
		_level.setupCollideIndex(1);
		_level.body.setShapeMaterials(new Material(0));
		add(_level);

		// Create _player
		_player = new Player(FlxG.width / 2 - 5, _level);
		_player.loadGraphic("assets/walk_cycle.png", true, 48, 88);
		_player.animation.add("walk", [for (i in 0...10) i]);
		_player.animation.play("walk");
		add(_player);

		// Add enemy
		_enemy = new BlueEnemy(_level, _player, FlxG.width / 3, 30);
		add(_enemy);

		_uprightConstraint = new AngleJoint(_player.body, _level.body, -Math.PI / 12, Math.PI / 12, 20);
		_uprightConstraint.space = FlxNapeSpace.space;
		_uprightConstraint.debugDraw = true;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (_player.y > FlxG.height) {
			_justDied = true;
			FlxG.resetState();
		}
	}
}
