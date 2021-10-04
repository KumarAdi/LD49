package;

import flixel.FlxBasic;
import flixel.addons.editors.ogmo.FlxOgmo3Loader.EntityData;
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
		ogmoLevel = ogmoLevelLoader.loadNapeTilemap(FlxGraphic.fromAssetKey("assets/Tiles.png"), "platforms");
		ogmoLevel.setupCollideIndex(1);
		ogmoLevel.body.setShapeMaterials(new Material(0));
		add(ogmoLevel);

		ogmoLevel.follow();

		var ogmoDetails = ogmoLevelLoader.loadNapeTilemap(FlxGraphic.fromAssetKey("assets/Tiles.png"), "non-collide-details");
		add(ogmoDetails);

		// Create _player
		_player = new Player(FlxG.width / 2 - 5, ogmoLevel);
		_player.animation.play("walk");
		add(_player);

		FlxG.camera.target = _player;

		function loadEntities(entity: EntityData) {
			switch (entity.name) {
				case "Enemy":
					var enemy = new BlueEnemy(ogmoLevel, _player, entity.x, entity.y);
					add(enemy);
			}
		}
		ogmoLevelLoader.loadEntities(loadEntities, "enemies");

		var _uprightConstraint = new AngleJoint(_player.body, ogmoLevel.body, -Math.PI / 12, Math.PI / 12, 20);
		_uprightConstraint.space = FlxNapeSpace.space;
		_uprightConstraint.debugDraw = true;

		// Debug stuff
        FlxG.watch.addMouse();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
