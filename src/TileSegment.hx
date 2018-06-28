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
	var BMDwidth:Int = 0;
	
	public function new(tileset:Tileset,lines:Array<Int>) 
	{
		super();

		this.tileset = tileset;
		this.lines = lines;
		
		BMDwidth = tileset.bitmapData.width;
		
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
			
			var scale :Float = ((scan + y - Main.myPerspective.y) / (Main.stageHeight -Main.myPerspective.y));
			var tan = (Main.myPerspective.x - x + BMDwidth/2) / (Main.stageHeight - Main.myPerspective.y) ;
			var posX : Float = tan * (Main.stageHeight - (y + scan)) - BMDwidth/2;
			
			var t:Tile = new Tile(i, posX, scan, scale);
			//t.tileset = tileset;
			addTile(t);
			
			scan++;
		}
	}
}