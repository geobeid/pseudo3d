package;

import openfl.display.Tile;
import openfl.display.TileContainer;
import openfl.display.Tileset;

/**
 * ...
 * @author Killabunnies
 */
class TileSegment extends TileContainer
{
	var lines:Array<Int>;
	public function new(tileset:Tileset,lines:Array<Int>) 
	{
		super();

		this.tileset = tileset;
		this.lines = lines;
		
		redraw();
	}
	
	public function update()
	{
		redraw();
	}
	
	private function redraw()
	{
		this.removeTiles();
		var scan:Int = 0;
		
		for (i in lines) 
		{
			
			var scale :Float = 1 - .5 * (1 - scan / tileset.bitmapData.width);
			var posX : Float = (1 - scan / tileset.bitmapData.width) * (tileset.bitmapData.width / 4);
			
			
			var t:Tile = new Tile(i, posX, scan, scale);
			//t.tileset = tileset;
			addTile(t);
			
			scan++;
		}
	}
}