package;

import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Killabunnies
 */
class TileRoad extends Tilemap
{

	var segmentArray:Array<TileSegment>;
	var roadSet:Tileset;
	
	static public var currentX = 0;
	
	public function new(width:Int, height:Int, texture:BitmapData, lanes:Int = 1 ) 
	{
		super(width, height);
		
		roadSet = new Tileset(texture);
		
		for (i in 0...roadSet.bitmapData.height) 
		{
			roadSet.addRect(new Rectangle(0,i,roadSet.bitmapData.width,1));
		}
		
		segmentArray = new Array<TileSegment>();
		
		
		for (lane in 0...lanes){
			
			var auxSegment = new TileSegment(roadSet, [for (i in 0...(Math.floor(Main.stageHeight-Main.myHorizon))) i]);
			auxSegment.y = Main.myHorizon;
			
			if(lanes==1){
				auxSegment.X = 0;
			}else {
				if(lanes==2){	
					auxSegment.X = (-.5 + lane) * roadSet.bitmapData.width;
				}
				else{
					auxSegment.X = (lane - Math.floor(lanes / 2) + (.5 * (lanes + 1) % 2 ))  * roadSet.bitmapData.width;	
				}
			}
			
			//auxSegment.X = 0;
			segmentArray.push(auxSegment);
			addTile(auxSegment);
		
		}
		
		//currentX = Math.floor(width / 2);
		
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update(e:Event):Void 
	{
		for (i in segmentArray) 
		{
			i.x = i.X+TileRoad.currentX;
			i.update();			
		}
	}
	
}