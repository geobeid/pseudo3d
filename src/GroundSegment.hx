package;

import openfl.display.Tile;
import openfl.display.TileContainer;
import openfl.display.Tileset;

/**
 * ...
 * @author Killabunnies
 */
class GroundSegment extends TileContainer
{
	var lines:Array<Int>;
	var BMDwidth:Int = 0;
	var myDelta:Float = 0;
	
	
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
			if (y + i > Main.myHorizon){
				var Z = (Main.myPerspective.z) / ((lines.length - i) - Main.stageHeight / 2 );
		
				var scale :Float = 1;
				//var scale :Float = ((scan + y - Main.myPerspective.y) / (Main.stageHeight -Main.myPerspective.y));
				var tan = (Main.myPerspective.x - x + BMDwidth/2) / (Main.stageHeight - Main.myPerspective.y) ;
				var posX : Float = 0;
				 
				
				var myID:Int = Math.floor(Z + myDelta) % tileset.bitmapData.height;
				var t:Tile = new Tile(myID, posX, scan, scale);
				//t.tileset = tileset;
				addTile(t);
			}
			
			scan++;
		}
		myDelta+=Main.speed*Main.dt;

	}
}