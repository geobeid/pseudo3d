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
	var myDelta:Float = 0;
	public var X:Float = 0;
	public var Y:Float = 0;
	
	
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
				//NO SE PORQUE -200000 pero funciona
				var Z = (Main.myPerspective.z) / ((lines.length - i) - Main.stageHeight / 2 );
		
				var scale :Float = ((scan + y - Main.myPerspective.y) / (Main.stageHeight -Main.myPerspective.y));
				//var scale :Float = ((scan + y - Main.myPerspective.y) / (Main.stageHeight -Main.myPerspective.y));
				var tan = (Main.myPerspective.x - x + BMDwidth/2) / (Main.stageHeight - Main.myPerspective.y) ;
				var posX : Float = tan * (Main.stageHeight - (y + scan)) - BMDwidth / 2;
				posX += Math.sin(i/180)*100;

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