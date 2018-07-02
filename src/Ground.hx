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
class Ground extends Tilemap
{

	var segmentArray:Array<GroundSegment>;
	var roadSet:Tileset;
	
	static public var currentX = 0;
	
	public function new(width:Int, height:Int) 
	{
		super(width, height);
		
		roadSet = new Tileset(Assets.getBitmapData("img/grass.png"));
		
		for (i in 0...roadSet.bitmapData.height) 
		{
			roadSet.addRect(new Rectangle(0,i,roadSet.bitmapData.width,1));
		}
		
		segmentArray = new Array<GroundSegment>();
		
		
		var auxSegment = new GroundSegment(roadSet, [for (i in 0...(Math.floor(Main.stageHeight-Main.myPerspective.y))) i]);
		auxSegment.y = Main.myPerspective.y ;
		//auxSegment.x = width / -2;
	
		
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
	
}