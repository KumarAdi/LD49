package;

import nape.constraint.Constraint;
import nape.constraint.AngleJoint;
import nape.phys.Material;
import flixel.system.FlxAssets.FlxTilemapGraphicAsset;
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

	var _player:Player;
	var _enemy:FlxNapeSprite;
	var ogmoLevel:FlxNapeTilemap;

	override public function create():Void {
		FlxG.mouse.visible = false;
		FlxG.cameras.bgColor = 0xffaaaaaa;

		FlxNapeSpace.init();
		FlxNapeSpace.space.gravity = new Vec2(0, 500);

		var ogmoLevelLoader = new FlxOgmoNapeLoader("assets/Stage.ogmo", "assets/level1.json");
		ogmoLevel = ogmoLevelLoader.loadNapeTilemap(FlxGraphic.fromAssetKey("assets/Tiles.png"), "bg");
		ogmoLevel.setupCollideIndex(1);
		ogmoLevel.body.setShapeMaterials(new Material(0));
		add(ogmoLevel);

		ogmoLevel.follow();

		// Create _player
		_player = new Player(FlxG.width / 2 - 5, ogmoLevel);
		_player.loadGraphic("assets/walk_cycle.png", true, 48, 88);
		_player.animation.add("walk", [for (i in 0...10) i]);
		_player.animation.play("walk");
		add(_player);

		FlxG.camera.target = _player;

		// Add enemy
		_enemy = new BlueEnemy(ogmoLevel, _player, FlxG.width / 3, 30);
		add(_enemy);

		var _uprightConstraint = new AngleJoint(_player.body, ogmoLevel.body, -Math.PI / 12, Math.PI / 12, 20);
		_uprightConstraint.space = FlxNapeSpace.space;
		_uprightConstraint.debugDraw = true;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
