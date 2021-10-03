import flixel.util.FlxPath;
import flixel.addons.nape.FlxNapeTilemap;
import nape.geom.Vec2;

function standable(x: Int, y: Int, map: FlxNapeTilemap): Bool {
    // TODO: Also add a hight clearance check
    return map.getTile(x, y) == 0 && map.getTile(x, y - 1) == 1;
}

function get_move_jump_nodes(
    pos: {x: Int, y: Int},
    jump_range: Float,
    map: FlxNapeTilemap
): Array<{point: Vec2, dist: Float}> {
    var x = pos.x;
    var y = pos.y;
    var pos = new Vec2(x, y);
    var nodes = [];

    // Right
    if (standable(x + 1, y, map)) {
        var point = new Vec2(x + 1, y);
        nodes.push({point: point, dist: Vec2.distance(point, pos), jump: false});
    }
    // Left
    if (standable(x - 1, y, map)) {
        var point = new Vec2(x - 1, y);
        nodes.push({point: point, dist: Vec2.distance(point, pos), jump: false});
    }

    // Jumpable
    for (y in - Std.int(jump_range) ... (Std.int(jump_range) + 1)) {
        var xh = Std.int(Math.sqrt(Math.pow(jump_range, 2) - Math.pow(y, 2)));
        for (x in -xh ... (xh + 1)) {
            if (standable(x, y, map)) {
                // TODO: Check for parabola collisions

                var point = new Vec2(x, y); 
                nodes.push({point: point, dist: Vec2.distance(point, pos), jump: true});
            }
        }
    }

    return nodes;
}

// A star modified for a side scroller game that supports jumping
function side_scroller_jumping_a_star(
    start: {x: Int, y: Int},
    end: {x: Int, y: Int},
    jump_range: Float,
    map: FlxNapeTilemap
): Array<FlxPath> {
    

    
    
    // TODO
    return [];
}