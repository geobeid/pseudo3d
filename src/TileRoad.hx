package;

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
	
	public function new(width:Int, height:Int) 
	{
		super(width, height);
		
		roadSet = new Tileset(Assets.getBitmapData("img/segment.png"));
		
		for (i in 0...roadSet.bitmapData.height) 
		{
			roadSet.addRect(new Rectangle(0,i,roadSet.bitmapData.width,1));
		}
		
		segmentArray = new Array<TileSegment>();
		
		var auxSegment = new TileSegment(roadSet, [for (i in 0...roadSet.bitmapData.height) i]);
		auxSegment.x = 500;
		auxSegment.y = 500;
		segmentArray.push(auxSegment);
		addTile(auxSegment);
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	function update(e:Event):Void 
	{
		for (i in segmentArray) 
		{
			i.update();
		}
	}
	
	public function addSegment(e:MouseEvent):Void 
	{
		trace ("added segment");
		var auxSegment = new TileSegment(roadSet, [for (i in 0...roadSet.bitmapData.height) i]);
		segmentArray.push(auxSegment);
		addTile(auxSegment);
		auxSegment.x = e.localX;
		auxSegment.y = e.localY;
	}
	
}