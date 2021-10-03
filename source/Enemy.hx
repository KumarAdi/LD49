import flixel.util.FlxTimer;
import flixel.addons.nape.FlxNapeSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.util.FlxPath;
import flixel.addons.nape.FlxNapeTilemap;
import nape.geom.Vec2;

enum EnemyState {
	Idle;
	// The path is defined in chunks, every chunk is seperated by a jump
	Moving(last_known_position:Vec2, forget_timer:FlxTimer, path:Array<FlxPath>);
	Attacking(attack_timer:FlxTimer);
}

class Enemy extends FlxNapeSprite {
	var tilemap:FlxNapeTilemap;
	var player:FlxSprite;
	var state:EnemyState;
	var movement:{
		walk_speed:Float,
		jump_range:Float,
	};
	var time_before_forget:Float;

	private function new(tilemap:FlxNapeTilemap, player:FlxSprite, x:Float, y:Float, walk_speed:Float, jump_range:Float, time_before_forget:Float) {
		super(x, y);
		this.tilemap = tilemap;
		this.player = player;
		this.state = Idle;
		this.movement = {
			walk_speed: walk_speed,
			jump_range: jump_range,
		};
		this.time_before_forget = time_before_forget;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		var new_state = null;

		switch (state) {
			case Idle:
				new_state = onIdle(elapsed);
			case Moving(last_known_position, forget_timer, path):
				new_state = onMoving(last_known_position, forget_timer, path, elapsed);
			case Attacking(timer):
				new_state = onAttacking(timer, elapsed);
		}

		// Handle switching here
		if (new_state != null) {
			switch (new_state) {
				case Idle:
					trace("To Idle");
					state = new_state;
				case Moving(last_known_position, forget_timer, path):
					trace("To Moving");
					state = new_state;
				case Attacking(timer):
					trace("To Attacking");
					state = new_state;
			}
		}
	}

	function onIdle(elapsed:Float):Null<EnemyState> {
		return null;
	}

	function onMoving(last_known_position:Vec2, forget_timer:FlxTimer, path:Array<FlxPath>, elapsed:Float):Null<EnemyState> {
		return null;
	}

	function onAttacking(timer:FlxTimer, elapsed:Float):Null<EnemyState> {
		return null;
	}

	function beginAttack():Bool {
		return false;
	}

	function getPlayerPositionFromVision(range:Float):Null<FlxPoint> {
		var pos = getPosition();
		var player_pos = player.getPosition();

		if (pos.distanceTo(player_pos) <= range && tilemap.ray(pos, player_pos)) {
			return player_pos;
		}

		return null;
	}
}

class BlueEnemy extends Enemy {
	final attack_range = 10;
	final vision_range = 70;
	final max_velocity = 10;

	public function new(tilemap:FlxNapeTilemap, player:FlxSprite, x:Float, y:Float) {
		super(tilemap, player, x, y, 1, 5, 2);
		makeGraphic(8, 8, FlxColor.BLUE);
		createRectangularBody(8, 8);
		setDrag(0.55);
		body.mass = 10;
		physicsEnabled = true;
	}

	override function onIdle(elapsed:Float):Null<EnemyState> {
		var player_pos = getPlayerPositionFromVision(vision_range);

		if (player_pos != null) {
			var timer = new FlxTimer();
			// TODO: Move to global variable sets time before going to a path stops
			timer.start(2);
			return Moving(new Vec2(player_pos.x, player_pos.y), timer, []);
		}

		return null;
	}

	override function onMoving(last_known_position:Vec2, forget_timer:FlxTimer, path:Array<FlxPath>, elapsed:Float):Null<EnemyState> {
		var player_pos = getPlayerPositionFromVision(vision_range);

		if (player_pos != null) {
			if (player_pos.distanceTo(getPosition()) <= attack_range) {
				var timer = new FlxTimer();
				// TODO: Move to global variable sets time before going to a path stops
				timer.start(1);
				return Attacking(timer);
			}

			last_known_position.x = player_pos.x;
			last_known_position.y = player_pos.y;

			forget_timer.reset();

			// TODO: clear path and populate the path again

			var player_on_left = (getPosition().x - player_pos.x) > 0;

			// TODO: figure out how to get the tileinfo
			trace(tilemap.getPosition());
			body.velocity = new Vec2(max_velocity * (player_on_left ? -1 : 1), 0);
		} else if (forget_timer.finished) {
			return Idle;
		}

		return null;
	}

	override function onAttacking(timer:FlxTimer, elapsed:Float):Null<EnemyState> {
		if (timer.finished) {
			return Idle;
		}
		return null;
	}

	override function beginAttack():Bool {
		var player_dist = getPosition().distanceTo(player.getPosition());

		// TODO: Might require refining
		return player_dist <= attack_range;
	}
}
