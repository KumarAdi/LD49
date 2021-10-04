package;

import flixel.system.FlxAssets.FlxTilemapGraphicAsset;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.addons.nape.FlxNapeTilemap;

class FlxOgmoNapeLoader extends FlxOgmo3Loader {
    /**
	 * Load a Nape Tilemap.
	 * Collision with entities should be handled with the reference returned from this function.
	 *
	 * IMPORTANT: Tile layers must export using IDs, not Coords!
	 *
	 * @param	tileGraphic		A String or Class representing the location of the image asset for the tilemap.
	 * @param	tileLayer		The name of the layer the tilemap data is stored in Ogmo editor, usually `"tiles"` or `"stage"`.
	 * @param	tilemap			(optional) A tilemap to load tilemap data into. If not specified, new `FlxTilemap` instance is created.
	 * @return	A `FlxTilemap`, where you can collide your entities against.
	 */
	public function loadNapeTilemap(tileGraphic:FlxTilemapGraphicAsset, tileLayer:String = "tiles", ?tilemap:FlxNapeTilemap):FlxNapeTilemap
        {
            if (tilemap == null)
                tilemap = new FlxNapeTilemap();
    
            // var layer = level.getTileLayer(tileLayer);
		    // var tileset = project.getTilesetData(layer.tileset);
            var layer = getTileLayer(level, tileLayer);
            var tileset = getTilesetData(project, layer.tileset);
            switch (layer.arrayMode)
            {
                case 0:
                    tilemap.loadMapFromArray(layer.data, layer.gridCellsX, layer.gridCellsY, tileGraphic, tileset.tileWidth, tileset.tileHeight);
                case 1:
                    tilemap.loadMapFrom2DArray(layer.data2D, tileGraphic, tileset.tileWidth, tileset.tileHeight);
            }
            return tilemap;
        }


    // copied from FlxOgmo3Loader    

	static function getTilesetData(data:ProjectData, name:String):ProjectTilesetData
        {
            for (tileset in data.tilesets)
                if (tileset.label == name)
                    return tileset;
            return null;
        }


	static function getTileLayer(data:LevelData, name:String):TileLayer
        {
            for (layer in data.layers)
                if (layer.name == name)
                    return cast layer;
            return null;
        }

}