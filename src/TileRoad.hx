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
	var roadSet2:Tileset;
	static public var currentX = 0;
	
	public function new(width:Int, height:Int) 
	{
		super(width, height);
		
		roadSet = new Tileset(Assets.getBitmapData("img/segment.png"));
		roadSet2 = new Tileset(Assets.getBitmapData("img/segment2.png"));
		
		for (i in 0...roadSet.bitmapData.height) 
		{
			roadSet.addRect(new Rectangle(0,i,roadSet.bitmapData.width,1));
			roadSet2.addRect(new Rectangle(0,i,roadSet2.bitmapData.width,1));
		}
		
		segmentArray = new Array<TileSegment>();
		
		
		var auxSegment = new TileSegment(roadSet, [for (i in 0...Math.floor(roadSet.bitmapData.height)) i]);
		auxSegment.x = width/2 - roadSet.bitmapData.width/2;
		auxSegment.y = height - roadSet.bitmapData.height ;
		
		var auxSegment2 = new TileSegment(roadSet2, [for (i in 0...Math.floor(roadSet2.bitmapData.height)) i]);
		auxSegment2.x = width/2 - roadSet2.bitmapData.width/2;
		auxSegment2.y = auxSegment.y - roadSet2.bitmapData.height;
		
		segmentArray.push(auxSegment);
		addTile(auxSegment);
		
		segmentArray.push(auxSegment2);
		addTile(auxSegment2);
		
		addEventListener(Event.ENTER_FRAME, update);
		Main.current.addEventListener(MouseEvent.MOUSE_DOWN, onMouseMove);
	}
	
	function update(e:Event):Void 
	{
		for (i in segmentArray) 
		{
			i.x = TileRoad.currentX;
			i.update();			
		}
	}
	
	public function addSegment(e:MouseEvent):Void 
	{
		return;
		trace ("added segment");
		var auxSegment = new TileSegment(roadSet, [for (i in 0...roadSet.bitmapData.height) i]);
		segmentArray.push(auxSegment);
		addTile(auxSegment);
		auxSegment.x = e.localX;
		auxSegment.y = e.localY;
	}
	
	function onMouseMove(E:MouseEvent) {
		return;
		segmentArray[0].y = E.stageY - roadSet.bitmapData.height;
		segmentArray[0].x = E.stageX;
		trace(segmentArray[0].x);
	}
	
}