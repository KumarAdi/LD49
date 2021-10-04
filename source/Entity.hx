import nape.phys.Body;
import nape.geom.Vec2;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeSpace;

class Entity extends FlxNapeSprite {
	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset, CreateRectangularBody:Bool = true, EnablePhysics:Bool = true) {
		super(X, Y, SimpleGraphic, CreateRectangularBody, EnablePhysics);
	}

	function jump(height:Float, ?level:Body) {
		body.applyImpulse(body.normalImpulse(level).xy().mul(10));
		body.applyImpulse(new Vec2(0, -height));
	}

	function moveRight(speed:Float, ?level:Body) {
		this.flipX = false;
		// var impulse = new Vec2(body.normalImpulse(level).xy().perp().mul(speed).x, 0);
		// body.applyImpulse(impulse);
		body.velocity.x = 60;
	}

	function moveLeft(speed:Float, ?level:Body) {
		this.flipX = true;
		// var impulse = new Vec2(body.normalImpulse(level).xy().perp().mul(-speed).x, 0);
		// body.applyImpulse(impulse);
		body.velocity.x = -60;
	}
}
